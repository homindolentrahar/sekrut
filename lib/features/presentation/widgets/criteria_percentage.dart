import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_color.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/util/extensions/double_extensions.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';

final colors = {
  'skill': AppColor.skill,
  'sikap': AppColor.sikap,
  'portfolio': AppColor.portfolio,
  '': Colors.transparent,
};

class CriteriaPercentage extends StatelessWidget {
  final List<Criteria>? criterias;

  const CriteriaPercentage({
    super.key,
    this.criterias,
  });

  @override
  Widget build(BuildContext context) {
    final ahpHelper = AHPCalculation(list: criterias ?? []);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            criterias?.length ?? 0,
            (index) => Expanded(
              flex: ahpHelper.priorities[index].toPercent().floor(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors[criterias?[index].slug],
                  borderRadius: index == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )
                      : index == (criterias?.length ?? 1) - 1
                          ? const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            )
                          : null,
                ),
                child: Text(
                  "${ahpHelper.priorities[index].toPercent().toStringAsFixed(1)}%",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            criterias?.length ?? 0,
            (index) => Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colors[criterias?[index].slug],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${criterias?[index].title}",
                    style: Get.textTheme.headlineSmall?.copyWith(
                      color: Get.theme.colorScheme.surface,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
