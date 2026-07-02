import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/services/update_service.dart';

class MockDio extends Mock implements Dio {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockDio mockDio;
  late MockFlutterSecureStorage mockStorage;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockFlutterSecureStorage();

    PackageInfo.setMockInitialValues(
      appName: "Job Seeker",
      packageName: "com.job.seeker",
      version: "1.0.0",
      buildNumber: "1",
      buildSignature: "signature",
    );
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

  group('UpdateNotifier Version Logic Tests', () {
    test('isNewerVersion parses and compares correct version increments', () {
      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );
      final notifier = container.read(updateStateProvider.notifier);

      expect(notifier.isNewerVersion('1.0.0', '1.0.1'), isTrue);
      expect(notifier.isNewerVersion('1.0.0', '1.1.0'), isTrue);
      expect(notifier.isNewerVersion('1.0.0', '2.0.0'), isTrue);
      expect(notifier.isNewerVersion('1.0.26', '1.0.26'), isFalse);
      expect(notifier.isNewerVersion('1.1.0', '1.0.9'), isFalse);
      expect(notifier.isNewerVersion('1.0.10', '1.0.2'), isFalse);
    });

    test('isMajorUpdate correctly checks for major versions bump', () {
      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );
      final notifier = container.read(updateStateProvider.notifier);

      expect(notifier.isMajorUpdate('1.0.26', '2.0.0'), isTrue);
      expect(notifier.isMajorUpdate('1.0.26', '1.1.0'), isFalse);
      expect(notifier.isMajorUpdate('2.1.3', '3.0.0'), isTrue);
    });
  });

  group('UpdateNotifier Network State Tests', () {
    test('checkForUpdates transitions to none if version is same or older', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          'tag_name': 'v1.0.0',
          'name': 'v1.0.0 [OPTIONAL]',
          'body': 'Notes',
          'assets': [
            {
              'name': 'app-release.apk',
              'browser_download_url': 'https://github.com/test/download/app-release.apk'
            }
          ]
        },
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );

      await container.read(updateStateProvider.notifier).checkForUpdates();

      final state = container.read(updateStateProvider);
      expect(state.status, UpdateStatus.none);
    });

    test('checkForUpdates transitions to optional if newer version exists', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          'tag_name': 'v1.1.0',
          'name': 'v1.1.0 [OPTIONAL]',
          'body': 'Notes',
          'assets': [
            {
              'name': 'app-release.apk',
              'browser_download_url': 'https://github.com/test/download/app-release.apk'
            }
          ]
        },
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);
      when(() => mockStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);

      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );

      await container.read(updateStateProvider.notifier).checkForUpdates();

      final state = container.read(updateStateProvider);
      expect(state.status, UpdateStatus.optional);
      expect(state.latestVersion, 'v1.1.0');
      expect(state.apkUrl, 'https://github.com/test/download/app-release.apk');
      expect(state.isSnoozed, isFalse);
    });

    test('checkForUpdates transitions to mandatory if release name contains tag', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          'tag_name': 'v1.0.1',
          'name': 'v1.0.1 [MANDATORY]',
          'body': 'Notes',
          'assets': [
            {
              'name': 'app-release.apk',
              'browser_download_url': 'https://github.com/test/download/app-release.apk'
            }
          ]
        },
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );

      await container.read(updateStateProvider.notifier).checkForUpdates();

      final state = container.read(updateStateProvider);
      expect(state.status, UpdateStatus.mandatory);
    });

    test('checkForUpdates transitions to mandatory on major version change', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {
          'tag_name': 'v2.0.0',
          'name': 'v2.0.0 [OPTIONAL]',
          'body': 'Notes',
          'assets': [
            {
              'name': 'app-release.apk',
              'browser_download_url': 'https://github.com/test/download/app-release.apk'
            }
          ]
        },
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );

      await container.read(updateStateProvider.notifier).checkForUpdates();

      final state = container.read(updateStateProvider);
      expect(state.status, UpdateStatus.mandatory);
    });
  });

  group('UpdateNotifier Snooze Logic Tests', () {
    test('snoozeUpdate writes snooze version and date to storage', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => {});

      final container = createContainer(
        overrides: [
          updateStateProvider.overrideWith(() => UpdateNotifier(dio: mockDio, storage: mockStorage)),
        ],
      );

      final notifier = container.read(updateStateProvider.notifier);
      
      // Seed provider state through state mutation inside container context
      notifier.state = UpdateState(
        status: UpdateStatus.optional,
        latestVersion: 'v1.1.0',
        apkUrl: 'https://github.com/test/download/app-release.apk',
      );

      await notifier.snoozeUpdate();

      verify(() => mockStorage.write(key: 'update_snooze_version', value: 'v1.1.0')).called(1);
      verify(() => mockStorage.write(key: 'update_snooze_time', value: any(named: 'value'))).called(1);
      
      final state = container.read(updateStateProvider);
      expect(state.isSnoozed, isTrue);
    });
  });
}
