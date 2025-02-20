import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_di.dart' as di;

FutureOr<void> main() async {
  di.setup();
  runApp(const App());
}
