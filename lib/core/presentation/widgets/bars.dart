import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/generated/assets.gen.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? leadingIcon;
  final String title;
  final Widget? action;
  final VoidCallback? onLeadingPressed;

  const PrimaryAppBar({
    super.key,
    this.showLeading = true,
    this.leadingIcon,
    required this.title,
    this.action,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: showLeading,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leadingIcon != null
                      ? GestureDetector(
                          onTap: onLeadingPressed,
                          child: leadingIcon,
                        )
                      : GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Get.back();
                            }
                          },
                          child: SvgPicture.asset(
                            Assets.icons.icBack,
                            width: 24,
                            height: 24,
                          ),
                        ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Visibility(
              visible: action != null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16),
                  action ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
