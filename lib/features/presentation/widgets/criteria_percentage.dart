import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_color.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/util/extensions/double_extensions.dart';

final colors = {
  'skill': AppColor.skill,
  'sikap': AppColor.sikap,
  'portfolio': AppColor.portfolio,
  '': Colors.transparent,
};

class CriteriaPercentage extends StatelessWidget {
  final List<Criteria> criterias;
  final Map<String, double> percentage;

  const CriteriaPercentage({
    super.key,
    required this.criterias,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            criterias.length,
            // percentage.length,
            (index) {
              return Expanded(
                // flex: (criterias[index].value ?? 0).toPercent().floor(),
                flex: (percentage[percentage.keys.toList()[index]] ?? 0)
                    .toPercent()
                    .floor(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors[criterias[index].slug],
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          )
                        : index == criterias.length - 1
                            ? const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              )
                            : null,
                  ),
                  child: Text(
                    // "${criterias[index].value?.toPercent().toStringAsFixed(1)}%",
                    "${percentage[percentage.keys.toList()[index]]?.toStringAsFixed(2)}%",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headlineSmall?.copyWith(
                      color: Get.theme.colorScheme.onSurface,
                      fontSize: 10,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            criterias.length,
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
                      color: colors[criterias[index].slug],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    criterias[index].title,
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
