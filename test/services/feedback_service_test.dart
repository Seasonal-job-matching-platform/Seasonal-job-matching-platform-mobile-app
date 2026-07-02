import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/services/profile_screen_services/feedback_service.dart';
import 'package:job_seeker/providers/profile_screen_providers/feedback_provider.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/endpoints.dart';

class MockDio extends Mock implements Dio {}
class MockFeedbackService extends Mock implements FeedbackService {}

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  ProviderContainer createContainer({List? overrides}) {
    final container = ProviderContainer(
      overrides: [
        ...?overrides,
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('FeedbackService API Submission Tests', () {
    test('submitFeedback makes POST request with email if provided', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'message': 'Feedback submitted successfully'},
      );

      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => mockResponse);

      final service = FeedbackService(mockDio);

      await service.submitFeedback(
        title: 'Title Test',
        body: 'Body Test',
        userEmail: 'test@example.com',
      );

      verify(() => mockDio.post(
            FEEDBACK,
            data: {
              'title': 'Title Test',
              'body': 'Body Test',
              'userEmail': 'test@example.com',
            },
          )).called(1);
    });

    test('submitFeedback omits userEmail if not provided (anonymous)', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 201,
        data: {'message': 'Feedback submitted successfully'},
      );

      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => mockResponse);

      final service = FeedbackService(mockDio);

      await service.submitFeedback(
        title: 'Title Test',
        body: 'Body Test',
      );

      verify(() => mockDio.post(
            FEEDBACK,
            data: {
              'title': 'Title Test',
              'body': 'Body Test',
            },
          )).called(1);
    });

    test('submitFeedback throws Exception on non-200/201 response status code', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'message': 'Invalid input data'},
      );

      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenAnswer((_) async => mockResponse);

      final service = FeedbackService(mockDio);

      expect(
        () => service.submitFeedback(title: 'T', body: 'B'),
        throwsA(isA<Exception>()),
      );
    });

    test('submitFeedback throws Exception on DioException', () async {
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 500,
            data: {'message': 'Internal Server Error'},
          ),
        ),
      );

      final service = FeedbackService(mockDio);

      expect(
        () => service.submitFeedback(title: 'T', body: 'B'),
        throwsA(isA<Exception>()),
      );
    });
   group('FeedbackNotifier Riverpod Provider Tests', () {
    test('submits with user email if anonymous is false', () async {
      final mockFeedbackService = MockFeedbackService();
      final mockUser = PersonalInformationModel(
        id: 123,
        name: 'John Doe',
        email: 'john@example.com',
        number: '12345678',
        country: 'Test Country',
        wantsEmails: true,
        currency: 'USD',
      );

      when(() => mockFeedbackService.submitFeedback(
            title: any(named: 'title'),
            body: any(named: 'body'),
            userEmail: any(named: 'userEmail'),
          )).thenAnswer((_) async => {});

      final container = createContainer(
        overrides: [
          feedbackServiceProvider.overrideWithValue(mockFeedbackService),
          personalInformationProvider.overrideWith(
            () => PersonalInformationAsyncNotifierMock(mockUser),
          ),
        ],
      );

      await container.read(personalInformationProvider.future);

      final notifier = container.read(feedbackProvider.notifier);

      expect(container.read(feedbackProvider), const AsyncValue<void>.data(null));

      await notifier.submitFeedback(
        title: 'Form Title',
        body: 'Form Body',
        anonymous: false,
      );

      expect(container.read(feedbackProvider), const AsyncValue<void>.data(null));
      verify(() => mockFeedbackService.submitFeedback(
            title: 'Form Title',
            body: 'Form Body',
            userEmail: 'john@example.com',
          )).called(1);
    });

    test('submits without email if anonymous is true', () async {
      final mockFeedbackService = MockFeedbackService();

      when(() => mockFeedbackService.submitFeedback(
            title: any(named: 'title'),
            body: any(named: 'body'),
            userEmail: any(named: 'userEmail'),
          )).thenAnswer((_) async => {});

      final container = createContainer(
        overrides: [
          feedbackServiceProvider.overrideWithValue(mockFeedbackService),
        ],
      );

      final notifier = container.read(feedbackProvider.notifier);

      await notifier.submitFeedback(
        title: 'Form Title',
        body: 'Form Body',
        anonymous: true,
      );

      expect(container.read(feedbackProvider), const AsyncValue<void>.data(null));
      verify(() => mockFeedbackService.submitFeedback(
            title: 'Form Title',
            body: 'Form Body',
            userEmail: null,
          )).called(1);
    });
  });
 });
}

class PersonalInformationAsyncNotifierMock
    extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;
  PersonalInformationAsyncNotifierMock(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}
