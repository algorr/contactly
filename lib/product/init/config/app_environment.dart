import 'package:contactly/product/init/config/app_config.dart';
import 'package:contactly/product/init/config/env_prod.dart';

/// App Environment Manager Class
final class AppEnvironment {
  /// The `AppEnvironment.setup` constructor is assigning the `config` parameter to the private variable
  /// `_config`. This allows the `AppEnvironment` class to store and access the `AppConfiguration` object
  /// that is passed in during initialization.
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  /// General Usage of Application Environment
  AppEnvironment.general() {
    _config = ProdEnv();
  }

  static late final AppConfiguration _config;
}

/// Get Application Items
enum AppEnvironmentItems {
  baseUrl,
  apiKey,
  deleteUrl;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.baseUrl;
        case AppEnvironmentItems.apiKey:
          return AppEnvironment._config.apiKey;
        case AppEnvironmentItems.deleteUrl:
          return AppEnvironment._config.deleteUrl;
      }
    } catch (e) {
      throw Exception('App Environment items are not initialized');
    }
  }
}
