import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/ui/app_color.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';

final colors = {
  'skill': AppColor.skill,
  'sikap': AppColor.sikap,
  'portfolio': AppColor.portfolio,
};

class CriteriaPercentage extends StatelessWidget {
  final List<Criteria>? criterias;

  const CriteriaPercentage({
    super.key,
    this.criterias,
  });

  @override
  Widget build(BuildContext context) {
    final dummies = [
      {
        "color": AppColor.skill,
        "value": 40,
      },
      {
        "color": AppColor.sikap,
        "value": 35,
      },
      {
        "color": AppColor.portfolio,
        "value": 25,
      }
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            dummies.length,
            (index) => Expanded(
              flex: ((dummies[index]['value'] as int) / 10).ceil(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: dummies[index]['color'] as Color,
                  borderRadius: index == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )
                      : index == dummies.length - 1
                          ? const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            )
                          : null,
                ),
                child: Text(
                  "$index%",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: index == 1
                        ? Get.theme.colorScheme.onSurface
                        : Get.theme.colorScheme.surface,
                    fontSize: 12,
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
            dummies.length,
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
                      color: dummies[index]['color'] as Color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${dummies[index]['value'] as int}",
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
