import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/l10n/app_localizations.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/screens/applications_detail_screen.dart';

void main() {
  final mockJob = JobModel(
    id: 101,
    title: 'Software Engineer',
    jobposterName: 'Acme Corp',
    location: 'Remote',
    type: 'Full-time',
    salary: 'Monthly',
    amount: 5000.0,
    startDate: '2026-07-04',
    status: 'Open',
    description: 'Description of the job',
    requirements: ['Requirement 1'],
    benefits: ['Benefit 1'],
    categories: ['Tech'],
    jobposterId: 1,
    createdAt: '2026-07-04',
    numOfPositions: 1,
  );

  final appScheduled = ApplicationModel(
    id: 5,
    userId: 3,
    applicationStatus: 'INTERVIEW_SCHEDULED',
    createdAt: '2026-07-04',
    job: mockJob,
    interviewDate: '2026-07-10',
    interviewTime: '14:00',
    interviewLocation: 'https://zoom.us/j/123456789',
  );

  final appAccepted = ApplicationModel(
    id: 5,
    userId: 3,
    applicationStatus: 'ACCEPTED',
    createdAt: '2026-07-04',
    job: mockJob,
  );

  Widget createTestWidget({required ApplicationModel application, Locale locale = const Locale('en')}) {
    final item = ApplicationWithJob(application: application, job: mockJob);
    return ProviderScope(
      child: MaterialApp(
        locale: locale,
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
        home: Scaffold(
          body: ApplicationDetailScreen(item: item),
        ),
      ),
    );
  }

  group('ApplicationDetailScreen Widget Tests', () {
    testWidgets('Shows Interview Details section in English when INTERVIEW_SCHEDULED', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(application: appScheduled, locale: const Locale('en')));
      await tester.pumpAndSettle();

      // Should display interview header and details
      expect(find.text('Interview Details'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('2026-07-10'), findsOneWidget);
      expect(find.text('Time'), findsOneWidget);
      expect(find.text('14:00'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('https://zoom.us/j/123456789'), findsOneWidget);
      expect(find.text('Join Interview'), findsOneWidget);
    });

    testWidgets('Shows Interview Details section in Arabic when INTERVIEW_SCHEDULED', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(application: appScheduled, locale: const Locale('ar')));
      await tester.pumpAndSettle();

      // Should display Arabic translated text
      expect(find.text('تفاصيل المقابلة'), findsOneWidget);
      expect(find.text('التاريخ'), findsOneWidget);
      expect(find.text('2026-07-10'), findsOneWidget);
      expect(find.text('الوقت'), findsOneWidget);
      expect(find.text('14:00'), findsOneWidget);
      expect(find.text('الموقع'), findsOneWidget);
      expect(find.text('الانضمام للمقابلة'), findsOneWidget);
    });

    testWidgets('Hides Interview Details section when status is ACCEPTED', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(application: appAccepted, locale: const Locale('en')));
      await tester.pumpAndSettle();

      // Should NOT display interview details
      expect(find.text('Interview Details'), findsNothing);
      expect(find.text('Join Interview'), findsNothing);
    });
  });
}
