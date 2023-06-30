import 'package:dotted_border/dotted_border.dart';
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

class PrimaryIconButton extends StatelessWidget {
  final Widget icon;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const PrimaryIconButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: icon,
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final double fontSize;
  final VoidCallback onPressed;

  const PrimaryTextButton({
    super.key,
    this.icon,
    required this.text,
    this.fontSize = 16,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Text(
              text,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryDashedButton extends StatelessWidget {
  final Widget? icon;
  final String title;
  final double? width;
  final VoidCallback onPressed;

  const PrimaryDashedButton({
    super.key,
    this.icon,
    required this.title,
    this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Get.theme.colorScheme.tertiary,
      radius: const Radius.circular(8),
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      borderPadding: EdgeInsets.zero,
      strokeCap: StrokeCap.round,
      dashPattern: const [8, 8, 8, 8],
      child: Material(
        color: Get.theme.colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon ?? const SizedBox.shrink(),
                      const SizedBox(width: 8),
                    ],
                  ),
                Text(
                  title,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: Get.theme.colorScheme.tertiary,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
