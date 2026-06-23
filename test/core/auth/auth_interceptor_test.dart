import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/core/auth/auth_interceptor.dart';

void main() {
  group('AuthInterceptor', () {
    const testToken = 'eyJhbGciOiJIUzM4NCJ9.test_token';
    late AuthInterceptor interceptor;

    setUp(() {
      interceptor = AuthInterceptor(() => Future.value(testToken));
    });

    test(
      'should add Bearer token to request headers when token exists',
      () async {
        final options = RequestOptions(
          path: '/api/test',
          headers: {'Content-Type': 'application/json'},
        );

        final handler = MockRequestInterceptorHandler();

        interceptor.onRequest(options, handler);

        // Wait for async operation
        await Future.delayed(Duration.zero);

        expect(handler.nextCalled, isTrue);
        expect(handler.rejectCalled, isFalse);
        expect(options.headers['Authorization'], equals('Bearer $testToken'));
      },
    );

    test('should reject request when token is null for protected endpoint', () async {
      final interceptorNoToken = AuthInterceptor(() => Future.value(null));

      final options = RequestOptions(
        path: '/api/test',
        headers: {'Content-Type': 'application/json'},
      );

      final handler = MockRequestInterceptorHandler();

      interceptorNoToken.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(handler.rejectCalled, isTrue);
      expect(handler.nextCalled, isFalse);
      expect(handler.rejectedError?.message, contains('No authentication token available'));
    });

    test('should reject request when token is empty for protected endpoint', () async {
      final interceptorEmptyToken = AuthInterceptor(() => Future.value(''));

      final options = RequestOptions(
        path: '/api/test',
        headers: {'Content-Type': 'application/json'},
      );

      final handler = MockRequestInterceptorHandler();

      interceptorEmptyToken.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(handler.rejectCalled, isTrue);
      expect(handler.nextCalled, isFalse);
      expect(handler.rejectedError?.message, contains('No authentication token available'));
    });

    test('should allow public auth endpoint to proceed without token', () async {
      final interceptorNoToken = AuthInterceptor(() => Future.value(null));

      final options = RequestOptions(
        path: 'users/login',
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
      );

      final handler = MockRequestInterceptorHandler();

      interceptorNoToken.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(handler.nextCalled, isTrue);
      expect(handler.rejectCalled, isFalse);
      expect(options.headers.containsKey('Authorization'), isFalse);
    });

    test('should preserve existing headers when adding token', () async {
      final options = RequestOptions(
        path: '/api/test',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final handler = MockRequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(options.headers['Content-Type'], equals('application/json'));
      expect(options.headers['Accept'], equals('application/json'));
      expect(options.headers['Authorization'], equals('Bearer $testToken'));
    });

    test('should use correct Bearer token format', () async {
      const customToken = 'jwt_token_12345';
      final customInterceptor = AuthInterceptor(
        () => Future.value(customToken),
      );

      final options = RequestOptions(path: '/api/test', headers: {});

      final handler = MockRequestInterceptorHandler();

      customInterceptor.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(
        options.headers['Authorization'],
        equals('Bearer jwt_token_12345'),
      );
    });
  });
}

class MockRequestInterceptorHandler extends RequestInterceptorHandler {
  bool nextCalled = false;
  bool rejectCalled = false;
  DioException? rejectedError;
  RequestOptions? nextOptions;

  @override
  void next(RequestOptions options) {
    nextCalled = true;
    nextOptions = options;
  }

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = false]) {
    rejectCalled = true;
    rejectedError = error;
  }
}
