import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/presentation/pages/model/crud_model_controller.dart';
import 'package:sekrut/features/presentation/widgets/criteria_item.dart';
import 'package:sekrut/features/presentation/widgets/selection_model_banner.dart';

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
              onPressed: controller.isEdit
                  ? controller.updateModel
                  : controller.saveModel,
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
                            title: "Persentase",
                            showPercentageOnly: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    PrimarySubtitle(
                      text: "Prioritas Kriteria",
                      subText:
                          "Drag kriteria dan sub-kriteria untuk menentukan prioritas. Semakin awal urutan, semakin tinggi prioritas",
                      onActionPressed: () async {},
                    ),
                    const SizedBox(height: 16),
                    ReorderableListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.criterias.length,
                      itemBuilder: (ctx, index) => CriteriaItem(
                        key: ValueKey(index.toString()),
                        data: controller.criterias[index],
                        onSubCriteriaReordered:
                            controller.onSubCriteriaReordered,
                      ),
                      proxyDecorator: (child, index, animation) {
                        return AnimatedScale(
                          scale: 1.1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: child,
                        );
                      },
                      onReorder: controller.onCriteriaReordered,
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
