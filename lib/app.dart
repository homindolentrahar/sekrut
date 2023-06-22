import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_theme.dart';
import 'package:sekrut/di/app_binding.dart';
import 'package:sekrut/route/app_route.dart';

class SekrutApp extends StatelessWidget {
  const SekrutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: Routes.landing,
      getPages: AppRoute.pages,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
