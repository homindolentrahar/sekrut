import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/sheets.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/presentation/pages/model/crud_model_controller.dart';
import 'package:sekrut/features/presentation/widgets/criteria_item.dart';
import 'package:sekrut/features/presentation/widgets/selection_model_banner.dart';
import 'package:sekrut/util/helpers/log_helper.dart';

class CrudModelPage extends StatelessWidget {
  const CrudModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CrudModelController>(
      builder: (controller) {
        return Scaffold(
          appBar: PrimaryAppBar(
            title:
                controller.isEdit ? "Edit Model Seleksi" : "Buat Model Seleksi",
            showLeading: controller.isEdit,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              title: "Simpan",
              onPressed: () async {
                if (controller.intensities.isNotEmpty) {
                  LogHelper.instance.debug(
                    message:
                        "Intensity: ${controller.intensities.map((e) => e.toJson()).toList()}",
                  );

                  controller.saveIntensities(controller.intensities);

                  controller.isEdit
                      ? controller.updateModel()
                      : controller.saveModel();
                }
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BoxTextField(
                      initValue: controller.data.title,
                      name: "name",
                      hint: "Nama Model",
                      action: TextInputAction.next,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    BoxTextField(
                      initValue: controller.data.description,
                      name: "desc",
                      hint: "Deskripsi Model",
                      lines: 3,
                      action: TextInputAction.done,
                    ),
                    Visibility(
                      visible: Get.parameters['id'] != null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          SelectionModelBanner(
                            data: controller.data,
                            intensities: controller.mappedIntensities,
                            title: "Persentase",
                            showPercentageOnly: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    PrimarySubtitle(
                      text: "Prioritas Kriteria",
                      actionText: "Ubah",
                      onActionPressed: () async {
                        final List<IntensityForm>? intensities =
                            await Get.bottomSheet(
                          PrioritySheet(
                            criterias: controller.criterias,
                            intensitiesData: controller.intensitiesData,
                          ),
                        );

                        if (intensities != null) {
                          controller.intensities = intensities;

                          controller.update();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.criterias.length,
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (ctx, index) => CriteriaItem(
                        key: ValueKey(index.toString()),
                        data: controller.criterias[index],
                        // onSubCriteriaReordered: controller.onSubCriteriaReordered,
                      ),
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
