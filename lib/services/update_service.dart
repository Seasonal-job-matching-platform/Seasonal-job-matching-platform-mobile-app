import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum UpdateStatus { none, optional, mandatory }

class UpdateState {
  final UpdateStatus status;
  final String? latestVersion;
  final String? apkUrl;
  final String? releaseNotes;
  final bool isSnoozed;

  UpdateState({
    required this.status,
    this.latestVersion,
    this.apkUrl,
    this.releaseNotes,
    this.isSnoozed = false,
  });

  UpdateState copyWith({
    UpdateStatus? status,
    String? latestVersion,
    String? apkUrl,
    String? releaseNotes,
    bool? isSnoozed,
  }) {
    return UpdateState(
      status: status ?? this.status,
      latestVersion: latestVersion ?? this.latestVersion,
      apkUrl: apkUrl ?? this.apkUrl,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      isSnoozed: isSnoozed ?? this.isSnoozed,
    );
  }
}

final updateStateProvider = NotifierProvider<UpdateNotifier, UpdateState>(() {
  return UpdateNotifier();
});

class UpdateNotifier extends Notifier<UpdateState> {
  final Dio? _testDio;
  final FlutterSecureStorage? _testStorage;

  UpdateNotifier({Dio? dio, FlutterSecureStorage? storage})
      : _testDio = dio,
        _testStorage = storage;

  Dio get _dio => _testDio ?? Dio();
  FlutterSecureStorage get _storage => _testStorage ?? const FlutterSecureStorage();

  @override
  UpdateState build() {
    return UpdateState(status: UpdateStatus.none);
  }

  static const _snoozeTimeKey = 'update_snooze_time';
  static const _snoozeVersionKey = 'update_snooze_version';

  Future<void> checkForUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // Fetch from GitHub Releases API
      final response = await _dio.get(
        'https://api.github.com/repos/Seasonal-job-matching-platform/Seasonal-job-matching-platform-mobile-app/releases/latest',
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final String latestTagName = data['tag_name'] ?? '';
        final String latestVersion = latestTagName.replaceAll('v', '').trim();
        final String releaseName = data['name'] ?? '';
        final String releaseBody = data['body'] ?? '';

        final List assets = data['assets'] ?? [];
        Map<String, dynamic>? apkAsset;
        for (final asset in assets) {
          if (asset is Map && asset['name'] != null && asset['name'].toString().endsWith('.apk')) {
            apkAsset = Map<String, dynamic>.from(asset);
            break;
          }
        }

        if (apkAsset == null) return;
        final String apkUrl = apkAsset['browser_download_url'] ?? '';

        if (isNewerVersion(currentVersion, latestVersion)) {
          final isMandatory = isMajorUpdate(currentVersion, latestVersion) ||
              releaseName.contains('[MANDATORY]') ||
              releaseBody.contains('[MANDATORY]');

          if (isMandatory) {
            state = UpdateState(
              status: UpdateStatus.mandatory,
              latestVersion: latestTagName,
              apkUrl: apkUrl,
              releaseNotes: releaseBody,
            );
          } else {
            // Check snooze logic
            final isSnoozed = await _checkIfSnoozed(latestTagName);
            state = UpdateState(
              status: UpdateStatus.optional,
              latestVersion: latestTagName,
              apkUrl: apkUrl,
              releaseNotes: releaseBody,
              isSnoozed: isSnoozed,
            );
          }
        } else {
          state = UpdateState(status: UpdateStatus.none);
        }
      }
    } catch (e) {
      // Fail silently in production, keeping status as none
    }
  }

  Future<void> snoozeUpdate() async {
    final version = state.latestVersion;
    if (version == null) return;

    final now = DateTime.now().millisecondsSinceEpoch.toString();
    await _storage.write(key: _snoozeTimeKey, value: now);
    await _storage.write(key: _snoozeVersionKey, value: version);

    state = state.copyWith(isSnoozed: true);
  }

  Future<bool> _checkIfSnoozed(String version) async {
    final snoozedVersion = await _storage.read(key: _snoozeVersionKey);
    if (snoozedVersion != version) return false;

    final snoozedTimeStr = await _storage.read(key: _snoozeTimeKey);
    if (snoozedTimeStr == null) return false;

    final snoozedTimeMs = int.tryParse(snoozedTimeStr);
    if (snoozedTimeMs == null) return false;

    final snoozeTime = DateTime.fromMillisecondsSinceEpoch(snoozedTimeMs);
    final now = DateTime.now();

    // Snooze lasts 24 hours
    return now.difference(snoozeTime).inHours < 24;
  }

  bool isNewerVersion(String current, String latest) {
    final currentParts = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final latestParts = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    for (var i = 0; i < latestParts.length; i++) {
      final currentVal = i < currentParts.length ? currentParts[i] : 0;
      final latestVal = latestParts[i];
      if (latestVal > currentVal) return true;
      if (latestVal < currentVal) return false;
    }
    return false;
  }

  bool isMajorUpdate(String current, String latest) {
    final currentParts = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final latestParts = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final currentMajor = currentParts.isNotEmpty ? currentParts[0] : 0;
    final latestMajor = latestParts.isNotEmpty ? latestParts[0] : 0;

    return latestMajor > currentMajor;
  }

  static Future<void> launchUpdateUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        await launchUrl(uri);
      } catch (_) {}
    }
  }
}
