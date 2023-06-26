import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/presentation/widgets/selection_item.dart';
import 'package:sekrut/features/selection/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: Get.theme.colorScheme.primary,
        child: SvgPicture.asset(
          Assets.icons.icAdd,
          color: Get.theme.colorScheme.surface,
        ),
        onPressed: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang,",
                    style: Get.textTheme.titleSmall?.copyWith(
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Jonas Khanwald",
                    style: Get.textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const SelectionModelBanner(),
              const SizedBox(height: 32),
              const PrimarySubtitle(
                text: "Hasil Seleksi",
                actionText: "5 hasil",
              ),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (ctx, index) => const SelectionItem(),
                separatorBuilder: (ctx, index) => const SizedBox(height: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
