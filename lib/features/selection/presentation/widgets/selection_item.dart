import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sekrut/features/selection/domain/models/selection.dart';
import 'package:sekrut/generated/assets.gen.dart';

class SelectionItem extends StatelessWidget {
  final Selection? data;
  final ValueChanged<Selection?>? onPressed;

  const SelectionItem({
    super.key,
    this.data,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Get.theme.colorScheme.outline),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          onPressed?.call(null);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seleksi Web Developer",
                style: Get.textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                "Seleksi Web Developer untuk project SMK 1 Imogiri",
                style: Get.textTheme.titleSmall?.copyWith(
                  color: Get.theme.colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icUser,
                        color: Get.theme.colorScheme.tertiary,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "8 Alternatif",
                        style: Get.textTheme.headlineSmall?.copyWith(
                          color: Get.theme.colorScheme.tertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icModel,
                        color: Get.theme.colorScheme.tertiary,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "AHP Model",
                        style: Get.textTheme.headlineSmall?.copyWith(
                          color: Get.theme.colorScheme.tertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icDate,
                        color: Get.theme.colorScheme.tertiary,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat("dd MMM yyyy, HH:mm").format(DateTime.now()),
                        style: Get.textTheme.headlineSmall?.copyWith(
                          color: Get.theme.colorScheme.tertiary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DottedLine(
                dashColor: Get.theme.colorScheme.outline,
                dashLength: 8,
                dashGapLength: 8,
              ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Get.theme.colorScheme.onSurface,
                          ),
                          child: Text(
                            "${index + 1}",
                            style: Get.textTheme.headlineSmall?.copyWith(
                              color: Get.theme.colorScheme.surface,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Agus Priyatno",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headlineSmall?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "34,55",
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
