import 'package:flutter/material.dart';
import 'package:flyful_farms/app/app.dart';
import 'package:flyful_farms/config/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const App());
}
