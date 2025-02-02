import 'package:package_info_plus/package_info_plus.dart';

class InfoService {
  static InfoService? _instance;
  static InfoService get instance => _instance!;

  static Future<InfoService> initialise() async {
    return _instance ??= InfoService._(await PackageInfo.fromPlatform());
  }

  const InfoService._(this._packageInfo);

  final PackageInfo _packageInfo;
  String get appName => _packageInfo.appName;
  String get appVersionCode => _packageInfo.buildNumber;
  String get appVersionName => _packageInfo.version;

  String get displayVersion {
    return '$appVersionName ($appVersionCode)';
  }
}
