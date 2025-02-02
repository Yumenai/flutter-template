import 'package:shared_preferences/shared_preferences.dart';

class DataStorageService {
  static DataStorageService? _instance;
  static DataStorageService get instance => _instance!;

  static Future<DataStorageService> initialise() async {
    return _instance ??= DataStorageService._(
      await SharedPreferences.getInstance(),
    );
  }

  DataStorageService._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<bool> setInt(final String key, final int value) {
    return _sharedPreferences.setInt(key, value);
  }

  Future<bool> setBool(final String key, final bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(final String key, final double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  Future<bool> setString(final String key, final String value) {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> setStringList(final String key, final List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  int? getInt(final String key) {
    return _sharedPreferences.getInt(key);
  }

  bool? getBool(final String key) {
    return _sharedPreferences.getBool(key);
  }

  double? getDouble(final String key) {
    return _sharedPreferences.getDouble(key);
  }

  String? getString(final String key) {
    return _sharedPreferences.getString(key);
  }

  List<String>? getStringList(final String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<bool> remove(final String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
