import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/l10n/app_localizations.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/screens/applications_screen.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock Classes
class MockApplicationsService extends Mock implements ApplicationsService {}

class MockPersonalInfoNotifier extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;
  MockPersonalInfoNotifier(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}

// Mock Data
final mockJob = JobModel(
  id: 101,
  title: 'Flutter Developer',
  jobposterName: 'Tech Co',
  location: 'Remote',
  type: 'Full-time',
  salary: 'Monthly',
  amount: 5000,
  startDate: '2023-02-01',
  status: 'Open',
  description: 'Desc',
  requirements: [],
  benefits: [],
  categories: ['Mobile'],
  jobposterId: 10,
  createdAt: '2023-01-01',
  numOfPositions: 1,
);

final mockApplication = ApplicationModel(
  id: 1,
  userId: 5,
  applicationStatus: 'Pending',
  createdAt: '2023-01-01',
  appliedDate: '2023-01-01',
  job: mockJob,
);

final mockApplicationWithJob = ApplicationWithJob(
  application: mockApplication,
  job: mockJob,
);

void main() {
  late MockApplicationsService mockService;

  setUp(() {
    mockService = MockApplicationsService();
    registerFallbackValue(mockApplicationWithJob);
  });

  Widget createTestWidget({required Widget child}) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      home: Scaffold(body: child),
    );
  }

  group('ApplicationsScreen Tests', () {
    testWidgets('Shows empty state when no applications', (
      WidgetTester tester,
    ) async {
      when(
        () => mockService.getApplicationsForUser(any()),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            applicationsServiceProvider.overrideWithValue(mockService),
            personalInformationProvider.overrideWith(
              () => MockPersonalInfoNotifier(
                const PersonalInformationModel(
                  id: 1,
                  name: 'User',
                  email: 'e@e.com',
                  country: 'US',
                  number: '123',
                  favoriteJobs: [],
                  ownedapplications: [],
                ),
              ),
            ),
          ],
          child: createTestWidget(child: const ApplicationsScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('No applications yet'), findsOneWidget);
    });

    testWidgets('Shows application list when data exists', (
      WidgetTester tester,
    ) async {
      when(
        () => mockService.getApplicationsForUser(any()),
      ).thenAnswer((_) async => [mockApplicationWithJob]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            applicationsServiceProvider.overrideWithValue(mockService),
            personalInformationProvider.overrideWith(
              () => MockPersonalInfoNotifier(
                const PersonalInformationModel(
                  id: 1,
                  name: 'User',
                  email: 'e@e.com',
                  country: 'US',
                  number: '123',
                  favoriteJobs: [],
                  ownedapplications: [],
                ),
              ),
            ),
          ],
          child: createTestWidget(child: const ApplicationsScreen()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
    });

    testWidgets('Orders applications by appliedDate descending (most recent first)', (
      WidgetTester tester,
    ) async {
      final appOlder = ApplicationWithJob(
        application: mockApplication.copyWith(
          id: 2,
          appliedDate: '2023-01-01',
          createdAt: '2023-01-01',
          job: mockJob.copyWith(title: 'Older Dev'),
        ),
        job: mockJob.copyWith(title: 'Older Dev'),
      );
      final appNewer = ApplicationWithJob(
        application: mockApplication.copyWith(
          id: 3,
          appliedDate: '2023-01-03',
          createdAt: '2023-01-03',
          job: mockJob.copyWith(title: 'Newer Dev'),
        ),
        job: mockJob.copyWith(title: 'Newer Dev'),
      );
      final appMiddle = ApplicationWithJob(
        application: mockApplication.copyWith(
          id: 4,
          appliedDate: '2023-01-02',
          createdAt: '2023-01-02',
          job: mockJob.copyWith(title: 'Middle Dev'),
        ),
        job: mockJob.copyWith(title: 'Middle Dev'),
      );

      when(
        () => mockService.getApplicationsForUser(any()),
      ).thenAnswer((_) async => [appOlder, appNewer, appMiddle]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            applicationsServiceProvider.overrideWithValue(mockService),
            personalInformationProvider.overrideWith(
              () => MockPersonalInfoNotifier(
                const PersonalInformationModel(
                  id: 1,
                  name: 'User',
                  email: 'e@e.com',
                  country: 'US',
                  number: '123',
                  favoriteJobs: [],
                  ownedapplications: [],
                ),
              ),
            ),
          ],
          child: createTestWidget(child: const ApplicationsScreen()),
        ),
      );

      await tester.pumpAndSettle();

      // Find the titles to verify order
      final finders = find.byType(Text);
      final listTitles = finders.evaluate().map((element) {
        final textWidget = element.widget as Text;
        return textWidget.data ?? '';
      }).toList();

      // Verify "Newer Dev" appears before "Middle Dev" and "Older Dev"
      final indexNewer = listTitles.indexOf('Newer Dev');
      final indexMiddle = listTitles.indexOf('Middle Dev');
      final indexOlder = listTitles.indexOf('Older Dev');

      expect(indexNewer, isNot(-1));
      expect(indexMiddle, isNot(-1));
      expect(indexOlder, isNot(-1));
      expect(indexNewer, lessThan(indexMiddle));
      expect(indexMiddle, lessThan(indexOlder));
    });
  });
}
