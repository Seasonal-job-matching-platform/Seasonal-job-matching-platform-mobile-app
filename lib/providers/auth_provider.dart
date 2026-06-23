import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:job_seeker/core/auth/auth_dialog_manager.dart';
import 'package:job_seeker/core/logger.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_controller.dart';
import 'package:job_seeker/providers/home_screen_providers/recommended_jobs_provider.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';
import 'package:job_seeker/providers/jobs_screen_providers/paginated_jobs_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_comments_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/jobs_filter_provider.dart';
import 'package:job_seeker/models/auth_models/login_request_model.dart';
import 'package:job_seeker/models/auth_models/signup_request_model.dart';
import 'package:job_seeker/services/auth_service.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/providers/profile_screen_providers/resume_provider.dart';
import 'package:job_seeker/services/notification_service.dart';
import 'package:job_seeker/services/notifications_api_service.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? token;
  final int? userId;
  final String? error;
  final bool sessionExpired;

  const AuthState({
    this.status = AuthStatus.initial,
    this.token,
    this.userId,
    this.error,
    this.sessionExpired = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    int? userId,
    String? error,
    bool? sessionExpired,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      error: error,
      sessionExpired: sessionExpired ?? this.sessionExpired,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.initial;
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _authService = ref.read(authServiceProvider);
  final AuthStorage _storage = AuthStorage();

  @override
  AuthState build() {
    _checkStoredSession();
    return const AuthState(status: AuthStatus.initial);
  }

  Future<void> _checkStoredSession() async {
    final token = await _storage.getToken();

    if (token != null && token.isNotEmpty) {
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: int.tryParse(await _storage.getUserId() ?? ''),
      );
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState(status: AuthStatus.initial);

    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await _authService.login(request);

      final token = response.token;
      final userId = response.user.id;

      if (token == null) {
        throw Exception('Authentication successful but no token received.');
      }

      await _storage.saveToken(token);
      await _storage.saveUserId(userId.toString());

      // Update state BEFORE making any subsequent API calls that might need the token
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: userId,
      );

      await _registerFcmToken(userId);

      // Reset dialog manager on successful login
      AuthDialogManager().resetSessionExpired();
      AppLogger.debug('[DEBUG] Login successful, dialog manager reset');
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signup({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
  }) async {
    state = const AuthState(status: AuthStatus.initial);

    try {
      final request = SignupRequestModel(
        name: name,
        country: country,
        number: number,
        email: email,
        password: password,
      );

      final response = await _authService.signup(request);

      final token = response.token;
      final userId = response.user.id;

      // If no token is returned, perform automatic login
      if (token == null) {
        AppLogger.debug('[DEBUG] Signup successful, performing automatic login...');
        return await login(email: email, password: password);
      }

      await _storage.saveToken(token);
      await _storage.saveUserId(userId.toString());

      // Update state BEFORE making any subsequent API calls
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: userId,
      );

      await _registerFcmToken(userId);

      // Reset dialog manager on successful signup
      AuthDialogManager().resetSessionExpired();
      AppLogger.debug('[DEBUG] Signup successful, dialog manager reset');
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout({bool sessionExpired = false}) async {
    AppLogger.debug('[DEBUG] === LOGOUT STARTED ===');

    await _storage.clearToken();
    await _storage.clearUserId();
    await _storage.clearFcmToken();
    AppLogger.debug('[DEBUG] Storage cleared');

    state = AuthState(
      status: AuthStatus.unauthenticated,
      sessionExpired: sessionExpired,
    );

    // Invalidate non-reactive state providers to prevent data leakage.
    // Reactive providers (like personalInformationProvider, paginatedJobsProvider,
    // favoriteJobsProvider, applicationsProvider, recommendedJobsProvider,
    // jobsNotifierProvider, resumeProvider) automatically reset because they watch authProvider.
    ref.invalidate(appliedJobsLocalProvider);
    ref.invalidate(favoritesControllerProvider);
    ref.invalidate(applyControllerProvider);
    ref.invalidate(jobCommentsNotifierProvider);
    ref.invalidate(jobsFilterProvider);
    AppLogger.debug('[DEBUG] Non-reactive state providers invalidated');

    // Clear local applied jobs set
    ref.read(appliedJobsLocalProvider.notifier).state = {};
    AppLogger.debug('[DEBUG] appliedJobsLocalProvider cleared');

    AppLogger.debug('[DEBUG] === LOGOUT COMPLETE ===');
  }

  Future<void> _registerFcmToken(int userId) async {
    try {
      final savedToken = await _storage.getFcmToken();
      final currentToken = await NotificationService().getToken();

      if (currentToken != null && currentToken != savedToken) {
        await _storage.saveFcmToken(currentToken);

        final apiService = ref.read(notificationsApiServiceProvider);
        await apiService.registerToken(
          userId: userId,
          token: currentToken,
          deviceType: Platform.isIOS ? 'iOS' : 'Android',
        );
        AppLogger.debug('[DEBUG] FCM token registered successfully');
      }
    } catch (e) {
      AppLogger.error('[DEBUG] Error registering FCM token: $e');
    }
  }
}
