import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

import '../utils/constant.dart';
/// The outcome of an update check.
enum UpdateStatus {
  /// Installed version is current.
  upToDate,

  /// A newer version exists; the user can choose to install it.
  updateAvailable,

  /// A newer version exists and the app refuses to run without it.
  forceUpdate,

  /// The manifest could not be reached or was malformed.
  failed,
}

class UpdateInfo {
  const UpdateInfo({
    required this.status,
    required this.currentVersion,
    this.latestVersion,
    this.notes,
    this.error,
  });

  final UpdateStatus status;
  final String currentVersion;
  final String? latestVersion;
  final String? notes;
  final String? error;

  bool get isNewer =>
      status == UpdateStatus.updateAvailable ||
      status == UpdateStatus.forceUpdate;
}

/// Checks for app updates over plain HTTPS.
///
/// This replaced a Firestore collection, which meant the app no longer needs
/// `firebase_core` or `cloud_firestore`. The manifest is a tiny JSON document
/// (see [updateManifestUrl]).
class AppVersionService {
  AppVersionService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                // The manifest lives on raw.githubusercontent.com which does not
                // send redirects for this path, but be lenient anyway.
                followRedirects: true,
              ),
            );

  final Dio _dio;

  /// The version currently installed, as reported by the platform.
  ///
  /// Returns an empty string when the platform channel is unavailable (e.g.
  /// in a widget test) rather than throwing.
  static Future<String> installedVersion() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      return info.version;
    } catch (_) {
      return '';
    }
  }

  /// Fetches the manifest and compares it with the installed version.
  ///
  /// Never throws; network and parsing problems surface as
  /// [UpdateStatus.failed] with a readable [UpdateInfo.error].
  Future<UpdateInfo> check({String? currentVersion}) async {
    final String installed =
        currentVersion ?? await AppVersionService.installedVersion();

    try {
      final Response<dynamic> response = await _dio.get<dynamic>(updateManifestUrl);
      final dynamic body = response.data;

      final Map<String, dynamic> json = switch (body) {
        final String s => jsonDecode(s) as Map<String, dynamic>,
        final Map<String, dynamic> m => m,
        _ => throw const FormatException('Unexpected manifest format'),
      };

      final String latestRaw = (json['version'] ?? '').toString().trim();
      if (latestRaw.isEmpty) {
        throw const FormatException('Manifest has no "version" field');
      }
      final bool forceUpdate = json['forceUpdate'] == true;
      final String? notes = json['notes']?.toString();

      final Version latest = Version.parse(latestRaw);
      final Version current = installed.isEmpty
          ? Version.parse(latestRaw)
          : Version.parse(installed);

      final UpdateStatus status = latest > current
          ? (forceUpdate ? UpdateStatus.forceUpdate : UpdateStatus.updateAvailable)
          : UpdateStatus.upToDate;

      return UpdateInfo(
        status: status,
        currentVersion: installed.isEmpty ? latestRaw : installed,
        latestVersion: latestRaw,
        notes: notes,
      );
    } on FormatException catch (e) {
      return UpdateInfo(
        status: UpdateStatus.failed,
        currentVersion: installed,
        error: e.message,
      );
    } on DioException catch (e) {
      return UpdateInfo(
        status: UpdateStatus.failed,
        currentVersion: installed,
        error: e.type == DioExceptionType.connectionError
            ? 'No internet connection.'
            : (e.message ?? 'Could not reach the update server.'),
      );
    } catch (e) {
      return UpdateInfo(
        status: UpdateStatus.failed,
        currentVersion: installed,
        error: '$e',
      );
    }
  }
}
