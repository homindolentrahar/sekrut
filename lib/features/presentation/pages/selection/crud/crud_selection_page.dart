import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/presentation/pages/selection/crud/crud_selection_controller.dart';
import 'package:sekrut/features/presentation/widgets/alternatif_item.dart';
import 'package:sekrut/features/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/generated/assets.gen.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/log_helper.dart';

class CrudSelectionPage extends StatelessWidget {
  const CrudSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CrudSelectionController>(
      builder: (controller) {
        LogHelper.instance
            .warning(message: "Alts: ${controller.sortedAlternatives}");

        return Scaffold(
          appBar: PrimaryAppBar(
            title: controller.isEdit ? "Ubah Seleksi" : "Buat Seleksi",
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              title: controller.isEdit ? "Ubah" : "Buat",
              onPressed: () => controller.isEdit
                  ? controller.updateSelection()
                  : controller.createSelection(),
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
                key: controller.formKey,
                child: Column(
                  children: [
                    BoxTextField(
                      initValue: controller.data.name,
                      name: "name",
                      hint: "Nama Seleksi",
                      action: TextInputAction.next,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    BoxTextField(
                      initValue: controller.data.description,
                      name: "description",
                      hint: "Deskripsi Seleksi",
                      lines: 3,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    BoxTextField(
                      initValue: controller.data.selectedAlternatives == 0
                          ? null
                          : controller.data.selectedAlternatives.toString(),
                      name: "alt_count",
                      hint: "Jumlah Pilihan Alternatif",
                      keyboardType: TextInputType.number,
                      action: TextInputAction.done,
                      suffixIcon: Icon(
                        Icons.group,
                        color: Get.theme.colorScheme.tertiary,
                      ),
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      valueTransformer: (value) => int.tryParse(value ?? "0"),
                    ),
                    const SizedBox(height: 16),
                    SelectionModelBanner(
                      data: controller.model,
                      intensities: controller.intensities,
                    ),
                    const SizedBox(height: 32),
                    FormBuilderField<List<Alternatif>>(
                      name: 'alternatives',
                      initialValue: controller.sortedAlternatives,
                      validator: (values) {
                        if (controller.sortedAlternatives.isEmpty) {
                          return "Alternatives cannot be empty!";
                        }

                        if (controller.sortedAlternatives.length < 3) {
                          return "Alternatives must be at least 3 person";
                        }

                        return null;
                      },
                      valueTransformer: (values) =>
                          values?.map((e) => e.toJson()).toList() ?? [],
                      builder: (field) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const PrimarySubtitle(text: "Alternatif"),
                            const SizedBox(height: 16),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (ctx, index) => AlternatifItem(
                                rank: index + 1,
                                isSelected: index <
                                    controller.data.selectedAlternatives,
                                data: controller.sortedAlternatives[index],
                                onItemPressed: (value) async {
                                  final result = await Get.toNamed(
                                    "${Routes.alternative}/${value.id}",
                                    arguments: value,
                                  );

                                  if (result != null) {
                                    controller.updateAlternative(result);
                                  }
                                },
                              ),
                              separatorBuilder: (ctx, index) => const SizedBox(
                                height: 16,
                              ),
                              itemCount: controller.sortedAlternatives.length,
                            ),
                            const SizedBox(height: 16),
                            PrimaryDashedButton(
                              icon: SvgPicture.asset(
                                Assets.icons.icAdd,
                                color: Get.theme.colorScheme.tertiary,
                                width: 20,
                                height: 20,
                              ),
                              title: "Tambah Alternatif",
                              onPressed: () async {
                                final result = await Get.toNamed(
                                  "${Routes.alternative}/${Routes.crud}",
                                );

                                if (result != null) {
                                  controller.addAlternative(result);
                                }
                              },
                            ),
                            Visibility(
                              visible: field.hasError,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      field.errorText ?? "",
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: Get.theme.colorScheme.error,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
