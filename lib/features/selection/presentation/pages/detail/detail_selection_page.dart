import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/presentation/widgets/alternatif_item.dart';
import 'package:sekrut/features/selection/presentation/widgets/criteria_percentage.dart';
import 'package:sekrut/features/selection/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';

class DetailSelectionPage extends StatelessWidget {
  const DetailSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(title: "Detail Seleksi"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seleksi Web Developer",
                style: Get.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Seleksi Web Developer untuk project SMK 1 Imogiri",
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
                        "6 partisipan",
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
              const SizedBox(height: 32),
              const SelectionModelBanner(),
              const SizedBox(height: 32),
              const PrimarySubtitle(text: "Hasil Seleksi"),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (ctx, index) => AlternatifItem(
                  rank: index,
                ),
                separatorBuilder: (ctx, index) => const SizedBox(height: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
