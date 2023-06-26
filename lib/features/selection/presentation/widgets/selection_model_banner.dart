import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/features/selection/presentation/widgets/criteria_percentage.dart';
import 'package:sekrut/generated/assets.gen.dart';

class SelectionModelBanner extends StatelessWidget {
  const SelectionModelBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(
              color: Get.theme.colorScheme.outline,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Model Seleksi",
                style: Get.textTheme.titleSmall?.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AHP Developer",
                          style: Get.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Digunakan untuk seleksi Developer menggunakan tiga kriteria utama",
                          style: Get.textTheme.titleSmall?.copyWith(
                            color: Get.theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  PrimaryIconButton(
                    icon: SvgPicture.asset(
                      Assets.icons.icProceed,
                      width: 16,
                      height: 16,
                      color: Get.theme.colorScheme.surface,
                    ),
                    backgroundColor: Get.theme.colorScheme.onSurface,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.onSurface,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: const CriteriaPercentage(),
        ),
      ],
    );
  }
}
