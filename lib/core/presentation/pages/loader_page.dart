import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Sekrut",
            style: Get.textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
