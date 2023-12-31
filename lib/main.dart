import 'package:flutter/material.dart';
import 'package:sekrut/app.dart';
import 'package:sekrut/app_config.dart';
import 'package:sekrut/di/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.init();
  AppModule.inject();

  runApp(const SekrutApp());
}
