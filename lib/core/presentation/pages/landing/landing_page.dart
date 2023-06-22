import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/pages/landing/landing_controller.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo, Selamat Datang...",
                    style: Get.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 32),
                  FormBuilder(
                    key: controller.formKey,
                    child: UnderlinedTextField(
                      name: "username",
                      hint: "Masukkan Username",
                      hintStyle: Get.textTheme.bodyLarge?.copyWith(
                        color: Get.theme.colorScheme.tertiary,
                        fontSize: 24,
                      ),
                      textStyle: Get.textTheme.titleLarge?.copyWith(
                        color: Get.theme.colorScheme.onSurface,
                        fontSize: 24,
                      ),
                      validators: FormBuilderValidators.required(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    title: "Mulai",
                    onPressed: () {
                      controller.saveUsername();

                      // Get.offAllNamed(Routes.home);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
