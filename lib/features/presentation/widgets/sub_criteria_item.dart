import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/domain/models/sub_criteria.dart';
import 'package:sekrut/generated/assets.gen.dart';

class SubCriteriaItem extends StatelessWidget {
  final SubCriteria data;

  const SubCriteriaItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.onSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              Assets.icons.icSubCriteria,
              width: 16,
              height: 16,
              color: Get.theme.colorScheme.surface,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              data.title,
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
