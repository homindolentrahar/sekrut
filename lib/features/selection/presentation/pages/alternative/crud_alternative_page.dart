import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/bars.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/features/selection/domain/models/sub_criteria.dart';
import 'package:sekrut/features/selection/presentation/pages/alternative/crud_alternative_controller.dart';
import 'package:sekrut/util/extensions/string_extensions.dart';

class CrudAlternativePage extends StatelessWidget {
  const CrudAlternativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CrudAlternativeController>(
      builder: (controller) {
        return Scaffold(
          appBar: const PrimaryAppBar(title: "Tambah Alternatif"),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              title: "Tambah",
              onPressed: () {
                Get.back();
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
                    const BoxTextField(name: "name", hint: "Nama Alternatif"),
                    const SizedBox(height: 16),
                    const BoxTextField(name: "email", hint: "Email Alternatif"),
                    const SizedBox(height: 16),
                    const BoxTextField(
                      name: "contact",
                      hint: "Kontak Alternatif",
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
                            PrimarySubtitle(text: criteria.title),
                            const SizedBox(height: 16),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: criteria.subCriterias.length,
                              itemBuilder: (ctx, index) =>
                                  BoxSelectorField<SubCriteriaOption>(
                                name:
                                    criteria.subCriterias[index].title.toSlug(),
                                title: criteria.subCriterias[index].title,
                                options: criteria.subCriterias[index].options,
                                onOptionSelected: (value) {},
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
