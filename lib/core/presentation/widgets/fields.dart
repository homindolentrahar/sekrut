import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_color.dart';

class UnderlinedTextField extends StatelessWidget {
  final String? initValue;
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? Function(String?)? validators;

  const UnderlinedTextField({
    super.key,
    this.initValue,
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
      initialValue: initValue,
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

class BoxTextField extends StatelessWidget {
  final String? initValue;
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int lines;
  final String? Function(String?)? validators;

  const BoxTextField({
    super.key,
    this.initValue,
    required this.name,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    this.textStyle,
    this.hintStyle,
    this.lines = 1,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initValue,
      name: name,
      validator: validators,
      keyboardType: keyboardType,
      textInputAction: action,
      style: textStyle ?? Get.textTheme.titleMedium,
      maxLines: lines,
      minLines: lines,
      decoration: InputDecoration(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintText: hint,
        hintStyle: hintStyle ??
            Get.textTheme.titleMedium?.copyWith(color: AppColor.gray),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.outline,
            width: 1.25,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.primaryColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.outline,
            width: 1.25,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1.25,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
