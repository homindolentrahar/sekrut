import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final double? width;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    this.backgroundColor,
    this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? Get.width,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      padding: const EdgeInsets.all(16),
      color: backgroundColor ?? Get.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Get.textTheme.headlineSmall?.copyWith(
          color: Get.theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
