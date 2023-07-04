import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/presentation/widgets/sub_criteria_item.dart';
import 'package:sekrut/generated/assets.gen.dart';

class CriteriaItem extends StatelessWidget {
  final Criteria data;
  final Function(int oldIndex, int newIndex, Criteria criteria)
      onSubCriteriaReordered;

  const CriteriaItem({
    super.key,
    required this.data,
    required this.onSubCriteriaReordered,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: Get.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.description,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Get.theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                Assets.icons.icDrag,
                width: 20,
                height: 20,
                color: Get.theme.colorScheme.onBackground,
              )
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
              data: data.subCriterias[index],
            ),
            itemCount: data.subCriterias.length,
            onReorder: (oldIndex, newIndex) =>
                onSubCriteriaReordered(oldIndex, newIndex, data),
          ),
        ],
      ),
    );
  }
}
