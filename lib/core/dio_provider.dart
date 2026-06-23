import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';
import 'auth/auth_interceptor.dart';
import 'auth/auth_storage.dart';
import 'auth/auth_dialog_manager.dart';
import 'navigation_service.dart';
import '../providers/auth_provider.dart';

import 'logger.dart';

final appConfigProvider = Provider<AppConfig>((_) => const AppConfig.dev());

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final storage = AuthStorage();

  dio.interceptors.add(
    AuthInterceptor(() async {
      final currentState = ref.read(authProvider);
      if (currentState.token != null) {
        return currentState.token;
      }
      return storage.getToken();
    }),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        final requestPath = error.requestOptions.path;
        AppLogger.debug(
          '[DEBUG] Interceptor: Received ${error.response?.statusCode} for $requestPath',
        );

        final cleanPath = requestPath.toLowerCase();
        final method = error.requestOptions.method.toUpperCase();

        // Skip auth endpoints - they might return 401/403 during authentication flows
        final isAuthEndpoint = cleanPath.contains('auth/') ||
            cleanPath.contains('users/login') ||
            cleanPath.contains('users/signup') ||
            (cleanPath == 'users' && method == 'POST');

        if (isAuthEndpoint) {
          AppLogger.debug(
            '[DEBUG] Interceptor blocked: Auth/Public endpoint - skipping check',
          );
          handler.next(error);
          return;
        }

        // Check if user is on auth screen - if so, silently handle
        if (NavigationService().isOnAuthScreen()) {
          AppLogger.debug('[DEBUG] Interceptor blocked: User is on auth screen');
          handler.next(error);
          return;
        }

        if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
          AppLogger.debug(
            '[DEBUG] Interceptor: ${error.response?.statusCode} detected - checking if already handled',
          );

          // Check if already handled to prevent multiple triggers
          if (AuthDialogManager().isSessionExpiredHandled) {
            AppLogger.debug(
              '[DEBUG] Interceptor blocked: Session expired already handled',
            );
            handler.next(error);
            return;
          }

          AuthDialogManager().markSessionExpiredHandled();
          AppLogger.warning('[DEBUG] Interceptor: Clearing storage and logging out');
          await storage.clearToken();
          await storage.clearUserId();
          ref.read(authProvider.notifier).logout(sessionExpired: true);
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});
