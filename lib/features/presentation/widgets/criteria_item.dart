import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/presentation/widgets/sub_criteria_item.dart';

class CriteriaItem extends StatelessWidget {
  final Criteria data;

  const CriteriaItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
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
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            // proxyDecorator: (child, index, animation) => AnimatedScale(
            //   scale: 1.125,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.easeInOut,
            //   child: child,
            // ),
            separatorBuilder: (ctx, index) => const SizedBox(height: 8),
            itemBuilder: (ctx, index) => SubCriteriaItem(
              key: ValueKey(index.toString()),
              data: data.subCriterias[index],
            ),
            itemCount: data.subCriterias.length,
          ),
        ],
      ),
    );
  }
}
