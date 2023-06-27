import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/presentation/widgets/add_criteria_sheet.dart';
import 'package:sekrut/features/selection/presentation/widgets/criteria_item.dart';
import 'package:sekrut/features/selection/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';
import 'package:sekrut/route/app_route.dart';

class CrudSelectionModelPage extends StatelessWidget {
  const CrudSelectionModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Get.parameters['id'] != null
            ? "Edit Model Seleksi"
            : "Buat Model Seleksi",
        showLeading: Get.parameters['id'] != null,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          title: "Simpan",
          onPressed: () {
            Get.toNamed(Routes.selection);
          },
        ),
      ),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BoxTextField(
                  name: "name",
                  hint: "Nama Model",
                ),
                const SizedBox(height: 16),
                const BoxTextField(
                  name: "desc",
                  hint: "Deskripsi Model",
                ),
                Visibility(
                  visible: Get.parameters['id'] != null,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      SelectionModelBanner(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                PrimarySubtitle(
                  text: "Prioritas Kriteria",
                  subText: "Drag kriteria untuk menentukan prioritas",
                  actionText: "Ubah",
                  onActionPressed: () {
                    Get.bottomSheet(
                      const AddCriteriaSheet(
                        criterias: [],
                        selectedCriterias: [],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ReorderableListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (ctx, index) => CriteriaItem(
                    key: ValueKey(index.toString()),
                    onPressed: (value) {},
                  ),
                  proxyDecorator: (child, index, animation) {
                    return AnimatedScale(
                      scale: 1.1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: child,
                    );
                  },
                  onReorder: (oldIndex, newIndex) {},
                ),
                const SizedBox(height: 16),
                PrimaryTextButton(
                  icon: SvgPicture.asset(
                    Assets.icons.icAdd,
                    color: Get.theme.colorScheme.onSurface,
                    width: 20,
                    height: 20,
                  ),
                  text: "Tambah Kriteria",
                  onPressed: () {
                    Get.bottomSheet(
                      const AddCriteriaSheet(
                        criterias: [],
                        selectedCriterias: [],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
