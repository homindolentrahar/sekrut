import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_color.dart';

class UnderlinedTextField extends StatelessWidget {
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? Function(String?)? validators;

  const UnderlinedTextField({
    super.key,
    required this.name,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    this.textStyle,
    this.hintStyle,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      validator: validators,
      keyboardType: keyboardType,
      textInputAction: action,
      style: textStyle ?? Get.textTheme.titleMedium,
      decoration: InputDecoration(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: hint,
        hintStyle: hintStyle ??
            Get.textTheme.bodyLarge?.copyWith(color: AppColor.gray),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 4),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 4),
        ),
      ),
    );
  }
}
