import 'package:contactly/product/init/config/app_config.dart';
import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(obfuscate: true, path: 'assets/env/.prod.env')
final class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnv._baseUrl;

  @EnviedField(varName: 'DELETE_URL')
  static final String _deleteUrl = _ProdEnv._deleteUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _ProdEnv._apiKey;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get deleteUrl => _deleteUrl;
}
