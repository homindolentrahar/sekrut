import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/presentation/pages/selection/detail/detail_selection_controller.dart';
import 'package:sekrut/features/presentation/widgets/alternatif_item.dart';
import 'package:sekrut/features/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';
import 'package:sekrut/route/app_route.dart';

class DetailSelectionPage extends StatelessWidget {
  const DetailSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailSelectionController>(
      builder: (controller) {
        return Scaffold(
          appBar: PrimaryAppBar(
            title: "Detail Seleksi",
            action: GestureDetector(
              child: Text(
                "Edit",
                style: Get.textTheme.headlineSmall,
              ),
              onTap: () {
                Get.toNamed(
                  "${Routes.selection}/${Routes.crud}",
                  arguments: {
                    "data": controller.data,
                  },
                );
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.data?.name ?? "",
                    style: Get.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.data?.description ?? "",
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: Get.theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
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
                          const SizedBox(width: 8),
                          Text(
                            "${controller.data?.alternatives.length} partisipan",
                            style: Get.textTheme.headlineSmall?.copyWith(
                              color: Get.theme.colorScheme.tertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
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
                          const SizedBox(width: 8),
                          Text(
                            DateFormat("dd MMM yyyy, HH:mm").format(
                              controller.data?.dateTime ?? DateTime.now(),
                            ),
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
                  const SizedBox(height: 32),
                  SelectionModelBanner(
                    data: controller.data?.model,
                    intensities: controller.mappedIntensities,
                  ),
                  const SizedBox(height: 32),
                  const PrimarySubtitle(text: "Hasil Seleksi"),
                  const SizedBox(height: 16),
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.sortedAlternatives.length,
                    itemBuilder: (ctx, index) => AlternatifItem(
                      rank: index + 1,
                      isSelected:
                          index < (controller.data?.selectedAlternatives ?? 0),
                      data: controller.sortedAlternatives[index],
                      onItemPressed: (value) {},
                    ),
                    separatorBuilder: (ctx, index) =>
                        const SizedBox(height: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
