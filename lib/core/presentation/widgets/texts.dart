import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimarySubtitle extends StatelessWidget {
  final String text;
  final String? subText;
  final String? actionText;
  final TextStyle? style;
  final TextStyle? subStyle;
  final VoidCallback? onActionPressed;

  const PrimarySubtitle({
    super.key,
    required this.text,
    this.subText,
    this.style,
    this.subStyle,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: style ?? Get.textTheme.titleMedium,
              ),
              if (subText != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      subText ?? "",
                      style: subStyle ?? Get.textTheme.bodyMedium,
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (actionText != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onActionPressed,
                child: Text(
                  actionText ?? "",
                  style: Get.textTheme.headlineSmall?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
