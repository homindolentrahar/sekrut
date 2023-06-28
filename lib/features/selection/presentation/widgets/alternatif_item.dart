import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/selection/domain/models/alternatif.dart';
import 'package:sekrut/generated/assets.gen.dart';

class AlternatifItem extends StatelessWidget {
  final Alternatif? data;
  final int? rank;

  const AlternatifItem({
    super.key,
    this.data,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Get.theme.colorScheme.outline),
      ),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconPadding: EdgeInsets.zero,
          iconColor: Get.theme.colorScheme.tertiary,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
        ),
        header: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onSurface,
                borderRadius: BorderRadius.circular(360),
              ),
              child: SvgPicture.asset(
                Assets.icons.icUser,
                color: Get.theme.colorScheme.surface,
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: rank != null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Text(
                          "Peringkat #$rank",
                          style: Get.textTheme.headlineSmall
                              ?.copyWith(fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Text(
                  "Jonas Khanwald",
                  style: Get.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  "jonaskhanw@gmail.com",
                  style: Get.textTheme.titleSmall?.copyWith(
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            DottedLine(
              dashColor: Get.theme.colorScheme.outline,
              dashGapLength: 8,
              dashLength: 8,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 16,
                children: List.generate(
                  3,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skill",
                        style: Get.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 16,
                        children: List.generate(
                          3,
                          (index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pengalaman",
                                style: Get.textTheme.titleSmall?.copyWith(
                                  color: Get.theme.colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "> 5 tahun",
                                style: Get.textTheme.headlineSmall?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
