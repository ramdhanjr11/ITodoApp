import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_di.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

FutureOr<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  di.setup();
  runApp(const App());
}
