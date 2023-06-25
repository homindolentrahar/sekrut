import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';
import 'package:sekrut/generated/assets.gen.dart';

class AddCriteriaSheet extends StatelessWidget {
  final List<Criteria> criterias;
  final List<Criteria> selectedCriterias;

  const AddCriteriaSheet({
    super.key,
    required this.criterias,
    required this.selectedCriterias,
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
          const PrimarySubtitle(text: "Tambah Kriteria"),
          const SizedBox(height: 32),
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              3,
              (index) => _SelectableCriteriaItem(
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

class _SelectableCriteriaItem extends StatelessWidget {
  final Criteria? data;
  final bool isSelected;
  final ValueChanged<Criteria?> onItemPressed;

  const _SelectableCriteriaItem({
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
                    const SizedBox(height: 16),
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
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.icSubCriteria,
                    width: 20,
                    height: 20,
                    color: isSelected
                        ? Get.theme.colorScheme.surface
                        : Get.theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "3 sub-kriteria",
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Get.theme.colorScheme.surface
                          : Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
