import 'package:flutter/material.dart';
import 'package:sekrut/app.dart';
import 'package:sekrut/app_config.dart';
import 'package:sekrut/di/app_module.dart';

void main() {
  AppConfig.init();
  AppModule.inject();

  runApp(const SekrutApp());
}
