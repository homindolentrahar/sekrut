import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';
import 'package:sekrut/features/selection/presentation/widgets/add_sub_criteria_sheet.dart';
import 'package:sekrut/features/selection/presentation/widgets/sub_criteria_item.dart';
import 'package:sekrut/generated/assets.gen.dart';

class CriteriaItem extends StatelessWidget {
  final Criteria? data;
  final ValueChanged<Criteria?> onPressed;

  const CriteriaItem({
    super.key,
    this.data,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Get.theme.colorScheme.outline,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Skill",
                    style: Get.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Lorem ipsum dolor sit amet",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: Get.theme.colorScheme.background,
                    ),
                  ),
                ],
              ),
              PrimaryIconButton(
                icon: SvgPicture.asset(
                  Assets.icons.icDelete,
                  color: Get.theme.colorScheme.error,
                  width: 16,
                  height: 16,
                ),
                backgroundColor: Get.theme.colorScheme.error.withOpacity(0.25),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          ReorderableListView.builder(
            shrinkWrap: true,
            proxyDecorator: (child, index, animation) => AnimatedScale(
              scale: 1.125,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: child,
            ),
            itemBuilder: (ctx, index) => SubCriteriaItem(
              key: ValueKey(index.toString()),
            ),
            itemCount: 2,
            onReorder: (oldIndex, newIndex) {},
          ),
          PrimaryTextButton(
            icon: SvgPicture.asset(
              Assets.icons.icAdd,
              color: Get.theme.colorScheme.onSurface,
              width: 20,
              height: 20,
            ),
            text: "Tambah Sub-Kriteria",
            fontSize: 14,
            onPressed: () {
              Get.bottomSheet(
                const AddSubCriteriaSheet(
                  subCriterias: [],
                  selectedSubCriterias: [],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
