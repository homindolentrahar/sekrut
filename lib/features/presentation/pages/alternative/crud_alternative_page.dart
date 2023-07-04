import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/domain/models/sub_criteria.dart';
import 'package:sekrut/features/presentation/pages/alternative/crud_alternative_controller.dart';
import 'package:sekrut/features/presentation/pages/selection/crud/crud_selection_controller.dart';
import 'package:sekrut/generated/assets.gen.dart';

class CrudAlternativePage extends StatelessWidget {
  const CrudAlternativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CrudAlternativeController>(
      builder: (controller) {
        return Scaffold(
          appBar: PrimaryAppBar(
            title: controller.isEdit ? "Ubah Alternatif" : "Tambah Alternatif",
            action: controller.isEdit
                ? GestureDetector(
                    onTap: () {
                      Get.find<CrudSelectionController>().removeAlternative(
                        controller.alternative.value,
                      );

                      Get.back();
                    },
                    child: SvgPicture.asset(
                      Assets.icons.icDelete,
                      width: 20,
                      height: 20,
                      color: Get.theme.colorScheme.error,
                    ),
                  )
                : null,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              title: controller.isEdit ? "Ubah" : "Tambah",
              onPressed: () {
                controller.isEdit ? controller.save() : controller.add();
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
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxTextField(
                      name: "name",
                      hint: "Nama Alternatif",
                      initValue: controller.alternative.value.name,
                      action: TextInputAction.next,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    BoxTextField(
                      name: "email",
                      hint: "Email Alternatif",
                      initValue: controller.alternative.value.email,
                      keyboardType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    BoxTextField(
                      name: "contact",
                      hint: "Kontak Alternatif",
                      initValue: controller.alternative.value.contact,
                      keyboardType: TextInputType.phone,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    const SizedBox(height: 32),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.criterias.length,
                      itemBuilder: (ctx, index) {
                        final criteria = controller.criterias[index];

                        return Column(
                          children: [
                            PrimarySubtitle(
                              text: criteria.title,
                              subText: criteria.description,
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: criteria.subCriterias.length,
                              itemBuilder: (ctx, index) =>
                                  BoxSelectorField<SubCriteriaOption>(
                                initialValue:
                                    controller.alternative.value.criterias
                                        .firstWhere(
                                          (element) =>
                                              element.slug == criteria.slug,
                                        )
                                        .subCriterias[index]
                                        .value,
                                name: criteria.subCriterias[index].slug,
                                hint: criteria.subCriterias[index].title,
                                title: controller.alternative.value.criterias
                                    .firstWhere(
                                      (element) =>
                                          element.slug == criteria.slug,
                                    )
                                    .subCriterias[index]
                                    .value
                                    ?.title,
                                options: criteria.subCriterias[index].options,
                                onOptionSelected: (value) {
                                  if (value != null) {
                                    controller.alternative.value =
                                        controller.alternative.value.copyWith(
                                      criterias: controller
                                          .alternative.value.criterias
                                          .map(
                                        (critForm) {
                                          var temp = critForm;

                                          if (critForm.slug == criteria.slug) {
                                            temp = temp.copyWith(
                                              subCriterias:
                                                  temp.subCriterias.map((sub) {
                                                var subTemp = sub;

                                                if (sub.slug ==
                                                    criteria.subCriterias[index]
                                                        .slug) {
                                                  subTemp = subTemp.copyWith(
                                                    value: value,
                                                  );
                                                }

                                                return subTemp;
                                              }).toList(),
                                            );
                                          }

                                          return temp;
                                        },
                                      ).toList(),
                                    );

                                    controller.update();
                                  }
                                },
                              ),
                              separatorBuilder: (ctx, index) =>
                                  const SizedBox(height: 16),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 32),
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
