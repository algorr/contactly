import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/app_environment.dart';

/// This class is for app initialize functions
final class AppInitialize {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    AppEnvironment.general();
  }
}

/// The `MyHttpOverrides` class overrides the default behavior of HTTP client creation in Dart to allow
/// accepting all certificates.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
