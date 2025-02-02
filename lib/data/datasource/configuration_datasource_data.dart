import '../../service/data_storage_service.dart';

const _dataKey = 'configuration';

const _keyAccessToken = '$_dataKey.access_token';

class ConfigurationDatasourceData {
  DataStorageService get _dataStorage => DataStorageService.instance;

  bool get hasAccessToken {
    return _dataStorage.getString(_keyAccessToken)?.isNotEmpty ?? false;
  }

  String get accessToken => _dataStorage.getString(_keyAccessToken) ?? '';

  Future<bool> setAccessToken(final String token) {
    return _dataStorage.setString(_keyAccessToken, token);
  }

  Future<void> clearSession() async {
    setAccessToken('');
  }
}
