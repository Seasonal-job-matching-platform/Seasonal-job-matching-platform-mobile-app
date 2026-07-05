import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/l10n/app_localizations.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/screens/Profile/edit_profile_screen.dart';

class MockPersonalInfoNotifier extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;
  MockPersonalInfoNotifier(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}

void main() {
  final mockUser = const PersonalInformationModel(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    country: 'Egypt',
    number: '+201012345678',
    favoriteJobs: [],
    ownedapplications: [],
    fieldsOfInterest: ['Software Development'],
  );

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        personalInformationProvider.overrideWith(
          () => MockPersonalInfoNotifier(mockUser),
        ),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        home: EditProfileScreen(),
      ),
    );
  }

  testWidgets('EditProfileScreen does not show the upload photo / camera button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Verify name is prefilled
    expect(find.text('Test User'), findsOneWidget);

    // Verify camera overlay icon is NOT present
    expect(find.byIcon(Icons.camera_alt), findsNothing);

    // Verify CircleAvatar (representing the photo placeholder) is NOT present
    expect(find.byType(CircleAvatar), findsNothing);
  });
}
