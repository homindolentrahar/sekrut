import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/domain/models/sub_criteria.dart';
import 'package:sekrut/generated/assets.gen.dart';

class AddSubCriteriaSheet extends StatelessWidget {
  final List<SubCriteria> subCriterias;
  final List<SubCriteria> selectedSubCriterias;

  const AddSubCriteriaSheet({
    super.key,
    required this.subCriterias,
    required this.selectedSubCriterias,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimarySubtitle(text: "Tambah Sub-Kriteria"),
          const SizedBox(height: 32),
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              3,
              (index) => _SelectableSubCriteriaItem(
                data: null,
                isSelected: index % 2 == 0,
                onItemPressed: (value) {},
              ),
            ).toList(),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            title: "Tambah",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SelectableSubCriteriaItem extends StatelessWidget {
  final SubCriteria? data;
  final bool isSelected;
  final ValueChanged<SubCriteria?> onItemPressed;

  const _SelectableSubCriteriaItem({
    this.data,
    this.isSelected = false,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? Get.theme.colorScheme.onSurface
          : Get.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Get.theme.colorScheme.outline,
          width: isSelected ? 0 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          onItemPressed(data);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isSelected,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.icSelected,
                          width: 20,
                          height: 20,
                          color: Get.theme.colorScheme.surface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Terpilih",
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: 12,
                            color: Get.theme.colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Text(
                "Skill",
                style: Get.textTheme.headlineSmall?.copyWith(
                  color: isSelected
                      ? Get.theme.colorScheme.surface
                      : Get.theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Lorem ipsum dolor sit amet",
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Get.theme.colorScheme.tertiary
                      : Get.theme.colorScheme.background,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
