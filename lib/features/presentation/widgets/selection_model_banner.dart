import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/presentation/widgets/criteria_percentage.dart';
import 'package:sekrut/generated/assets.gen.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';
import 'package:sekrut/util/helpers/log_helper.dart';

class SelectionModelBanner extends StatelessWidget {
  final AHPModel? data;
  final Map<String, List<IntensityValue>>? intensities;
  final String? title;
  final bool showPercentageOnly;
  final VoidCallback? onProceedPressed;

  const SelectionModelBanner({
    super.key,
    this.data,
    this.intensities,
    this.title,
    this.showPercentageOnly = false,
    this.onProceedPressed,
  });

  @override
  Widget build(BuildContext context) {
    final calculation =
        AHPCalculation(list: [], intensities: intensities ?? {});

    LogHelper.instance.debug(
      message: "First Matrix: ${calculation.firstMatrixAlt}\n"
          "Total First: ${calculation.totalFirstMatrixAlt}\n"
          "Second Matrix: ${calculation.secondMatrixAlt}\n"
          "Total Second: ${calculation.totalSecondMatrixAlt}\n"
          "Priorities: ${calculation.prioritiesAlt}",
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Model Seleksi",
            style: Get.textTheme.titleSmall?.copyWith(
              color: Get.theme.colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: !showPercentageOnly,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            data?.title ?? "",
                            style: Get.textTheme.headlineSmall?.copyWith(
                              color: Get.theme.colorScheme.surface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data?.description ?? "",
                            style: Get.textTheme.titleSmall?.copyWith(
                              color: Get.theme.colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: onProceedPressed != null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 16),
                          PrimaryIconButton(
                            icon: SvgPicture.asset(
                              Assets.icons.icProceed,
                              width: 16,
                              height: 16,
                              color: Get.theme.colorScheme.surface,
                            ),
                            backgroundColor: Get.theme.colorScheme.onBackground,
                            onPressed: onProceedPressed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CriteriaPercentage(
            criterias: data?.criterias ?? [],
            percentage: calculation.prioritiesAlt,
          ),
        ],
      ),
    );
  }
}
