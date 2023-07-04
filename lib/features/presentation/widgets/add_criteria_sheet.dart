import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/generated/assets.gen.dart';

class AddCriteriaSheet extends StatelessWidget {
  final List<Criteria> criterias;
  final List<String> selectedCriterias;

  AddCriteriaSheet({
    super.key,
    required this.criterias,
    required this.selectedCriterias,
  });

  final RxList<Criteria> selected = RxList.empty();

  bool isSelected(String slug) {
    return selected.map((element) => element.slug).contains(slug);
  }

  void toggleSelected(Criteria value) {
    if (selected.map((element) => element.slug).contains(value.slug)) {
      selected.removeWhere(
        (element) => element.slug == value.slug,
      );
      return;
    }

    selected.add(value);
  }

  @override
  Widget build(BuildContext context) {
    selected.addAll(
      criterias.where(
        (element) => selectedCriterias.contains(element.slug),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Obx(
        () {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: PrimarySubtitle(
                  text: "Tambah Kriteria",
                  actionText:
                      selected.isEmpty ? null : "${selected.length} terpilih",
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: criterias.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (ctx, index) => _SelectableCriteriaItem(
                    data: criterias[index],
                    isSelected: isSelected(criterias[index].slug),
                    onItemPressed: toggleSelected,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                title: "Tambah",
                onPressed: () {
                  Get.back(result: selected);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SelectableCriteriaItem extends StatelessWidget {
  final Criteria data;
  final bool isSelected;
  final ValueChanged<Criteria> onItemPressed;

  const _SelectableCriteriaItem({
    required this.data,
    this.isSelected = false,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? Get.theme.colorScheme.onSurface
            : Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
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
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSelected ? 1 : 0,
                curve: Curves.easeInOut,
                child: isSelected
                    ? Column(
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
                              const SizedBox(width: 4),
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
                      )
                    : const SizedBox.shrink(),
              ),
              Text(
                data.title,
                style: Get.textTheme.headlineSmall?.copyWith(
                  color: isSelected
                      ? Get.theme.colorScheme.surface
                      : Get.theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.description,
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Get.theme.colorScheme.background
                      : Get.theme.colorScheme.onBackground,
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
                  const SizedBox(width: 4),
                  Text(
                    "${data.subCriterias.length} sub-kriteria",
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
