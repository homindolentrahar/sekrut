import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/presentation/widgets/alternatif_item.dart';
import 'package:sekrut/features/selection/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';
import 'package:sekrut/route/app_route.dart';

class CrudSelectionPage extends StatelessWidget {
  const CrudSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(title: "Buat Seleksi"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: FormBuilder(
            child: Column(
              children: [
                const BoxTextField(
                  name: "name",
                  hint: "Nama Seleksi",
                ),
                const SizedBox(height: 16),
                const BoxTextField(
                  name: "description",
                  hint: "Deskripsi Seleksi",
                  lines: 3,
                ),
                const SizedBox(height: 16),
                BoxTextField(
                  name: "alternatif_count",
                  hint: "Jumlah Pilihan Alternatif",
                  suffixIcon: Icon(
                    Icons.group,
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 16),
                SelectionModelBanner(
                  onProceedPressed: () {
                    Get.toNamed("${Routes.model}/1");
                  },
                ),
                const SizedBox(height: 32),
                const PrimarySubtitle(text: "Alternatif"),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) => const AlternatifItem(),
                  separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                  itemCount: 3,
                ),
                const SizedBox(height: 16),
                PrimaryDottedButton(
                  icon: SvgPicture.asset(
                    Assets.icons.icAdd,
                    color: Get.theme.colorScheme.tertiary,
                    width: 20,
                    height: 20,
                  ),
                  title: "Tambah Alternatif",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
