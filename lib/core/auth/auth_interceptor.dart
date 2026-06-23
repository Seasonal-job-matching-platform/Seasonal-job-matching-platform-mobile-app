import 'package:dio/dio.dart';
import '../logger.dart';

typedef TokenProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  final TokenProvider _getToken;
  AuthInterceptor(this._getToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken();
    
    final path = options.path.toLowerCase();
    final method = options.method.toUpperCase();
    
    final isAuthEndpoint = path.contains('auth/') ||
        path.contains('users/login') ||
        path.contains('users/signup') ||
        (path == 'users' && method == 'POST');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      super.onRequest(options, handler);
    } else if (isAuthEndpoint) {
      // Allow public endpoints to proceed without token
      super.onRequest(options, handler);
    } else {
      AppLogger.warning('[DEBUG] AuthInterceptor: Blocking request to ${options.path} - No token available');
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No authentication token available.',
          message: 'No authentication token available.',
          type: DioExceptionType.cancel,
        ),
      );
    }
  }
}


