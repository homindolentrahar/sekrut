import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';
import 'package:sekrut/util/helpers/log_helper.dart';

class PrioritySheet extends StatelessWidget {
  final List<Criteria> criterias;
  final List<IntensityForm> initialData;
  final List<Intensity> intensitiesData;

  const PrioritySheet({
    super.key,
    required this.criterias,
    this.initialData = const [],
    required this.intensitiesData,
  });

  @override
  Widget build(BuildContext context) {
    final RxList<IntensityForm> datas = (initialData.isEmpty
            ? criterias.map(
                (crit) {
                  // final excludedCrits = criterias
                  //     .where((element) => element.slug != crit.slug)
                  //     .toList();

                  return IntensityForm(
                    slug: crit.slug,
                    values: criterias
                        .map(
                          (e) => IntensityValue(
                            slug: e.slug,
                            value: e.slug == crit.slug ? 1 : null,
                          ),
                        )
                        .toList(),
                    subs: crit.subCriterias.map((sub) {
                      final excludedSubs = crit.subCriterias
                          .where((element) => element.slug != sub.slug)
                          .toList();

                      return SubIntensityForm(
                        slug: sub.slug,
                        values: crit.subCriterias
                            .map(
                              (e) => IntensityValue(
                                slug: e.slug,
                                value: e.slug == sub.slug ? 1 : null,
                              ),
                            )
                            .toList(),
                      );
                    }).toList(),
                  );
                },
              ).toList()
            : initialData)
        .obs;
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

    return Obx(() {
      final calculation = AHPCalculation(
        list: [],
        intensities: datas.asMap().map(
              (key, value) => MapEntry(value.slug, value.values),
            ),
      );

      LogHelper.instance.debug(
        message: "First Matrix: ${calculation.firstMatrixAlt}",
      );

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ubah Prioritas",
              style: Get.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            FormBuilder(
              key: formKey,
              child: Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      criterias.length,
                      (index) {
                        // final excludedList = criterias
                        //     .where(
                        //       (element) => element.slug != criterias[index].slug,
                        //     )
                        //     .toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: ExpandablePanel(
                            header: Text(
                              criterias[index].title,
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            collapsed: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                criterias.length,
                                (excIndex) {
                                  final double? title =
                                      datas[index].values[excIndex].value;

                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: BoxSelectorField<Intensity>(
                                            initialValue: Intensity(
                                              value: title ?? 0,
                                              title: title.toString(),
                                              description: "",
                                            ),
                                            enabled: datas[index]
                                                    .values[excIndex]
                                                    .slug !=
                                                datas[index].slug,
                                            name: datas[index]
                                                .values[excIndex]
                                                .slug,
                                            title: title?.toString(),
                                            hint: "Nilai",
                                            options: intensitiesData,
                                            onOptionSelected: (value) {
                                              if (value != null) {
                                                final invertedIndex =
                                                    datas.indexWhere((crit) {
                                                  return crit.slug ==
                                                      datas[index]
                                                          .values[excIndex]
                                                          .slug;
                                                });

                                                datas[index] =
                                                    datas[index].copyWith(
                                                  values: datas[index]
                                                      .values
                                                      .map((val) {
                                                    var tempValue = val;

                                                    if (val.slug ==
                                                        datas[index]
                                                            .values[excIndex]
                                                            .slug) {
                                                      tempValue =
                                                          tempValue.copyWith(
                                                        value: value.value,
                                                      );
                                                    }

                                                    return tempValue;
                                                  }).toList(),
                                                );
                                                datas[invertedIndex] =
                                                    datas[invertedIndex]
                                                        .copyWith(
                                                  values: datas[invertedIndex]
                                                      .values
                                                      .map((val) {
                                                    var tempValue = val;
                                                    final valueIndex = datas
                                                        .indexWhere((temp) =>
                                                            temp.slug ==
                                                            datas[index].slug);

                                                    if (val.slug ==
                                                        datas[valueIndex]
                                                            .slug) {
                                                      tempValue =
                                                          tempValue.copyWith(
                                                        value: 1 / value.value,
                                                      );
                                                    }

                                                    return tempValue;
                                                  }).toList(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          flex: 6,
                                          child: Text(
                                            criterias[excIndex].title,
                                            style: Get.textTheme.titleMedium
                                                ?.copyWith(
                                              color: datas[index]
                                                          .values[excIndex]
                                                          .slug !=
                                                      datas[index].slug
                                                  ? Get
                                                      .theme.colorScheme.primary
                                                  : Get.theme.colorScheme
                                                      .tertiary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            expanded: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                criterias[index].subCriterias.length,
                                (subIndex) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          criterias[index]
                                              .subCriterias[subIndex]
                                              .title,
                                          style: Get.textTheme.bodySmall,
                                        ),
                                        const SizedBox(height: 8),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                            criterias[index]
                                                .subCriterias
                                                .length,
                                            (excSubIndex) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: BoxSelectorField<
                                                        Intensity>(
                                                      initialValue: Intensity(
                                                        value: datas[index]
                                                                .subs[subIndex]
                                                                .values[
                                                                    excSubIndex]
                                                                .value ??
                                                            0,
                                                        title: datas[index]
                                                            .subs[subIndex]
                                                            .values[excSubIndex]
                                                            .value
                                                            .toString(),
                                                        description: "",
                                                      ),
                                                      enabled: datas[index]
                                                              .subs[subIndex]
                                                              .values[
                                                                  excSubIndex]
                                                              .slug !=
                                                          datas[index]
                                                              .subs[subIndex]
                                                              .slug,
                                                      name: criterias[index]
                                                          .subCriterias[
                                                              excSubIndex]
                                                          .slug,
                                                      title: datas[index]
                                                          .subs[subIndex]
                                                          .values[excSubIndex]
                                                          .value
                                                          ?.toString(),
                                                      hint: "Nilai",
                                                      options: intensitiesData,
                                                      onOptionSelected:
                                                          (value) {
                                                        if (value != null) {
                                                          final invertedSubIndex =
                                                              datas[index]
                                                                  .subs
                                                                  .indexWhere(
                                                                      (sub) {
                                                            return sub.slug ==
                                                                datas[index]
                                                                    .subs[
                                                                        subIndex]
                                                                    .values[
                                                                        excSubIndex]
                                                                    .slug;
                                                          });

                                                          datas[index] =
                                                              datas[index]
                                                                  .copyWith(
                                                            subs: datas[index]
                                                                .subs
                                                                .map((sub) {
                                                              var temp = sub;

                                                              if (sub.slug ==
                                                                  datas[index]
                                                                      .subs[
                                                                          subIndex]
                                                                      .slug) {
                                                                temp = sub
                                                                    .copyWith(
                                                                  values: sub
                                                                      .values
                                                                      .map(
                                                                          (subVal) {
                                                                    var tempSubVal =
                                                                        subVal;

                                                                    if (subVal
                                                                            .slug ==
                                                                        datas[index]
                                                                            .subs[subIndex]
                                                                            .values[excSubIndex]
                                                                            .slug) {
                                                                      tempSubVal =
                                                                          tempSubVal
                                                                              .copyWith(
                                                                        value: value
                                                                            .value,
                                                                      );
                                                                    }

                                                                    return tempSubVal;
                                                                  }).toList(),
                                                                );
                                                              }

                                                              return temp;
                                                            }).toList(),
                                                          );

                                                          datas[index] =
                                                              datas[index]
                                                                  .copyWith(
                                                            subs: datas[index]
                                                                .subs
                                                                .map((sub) {
                                                              var temp = sub;

                                                              if (sub.slug ==
                                                                  datas[index]
                                                                      .subs[
                                                                          invertedSubIndex]
                                                                      .slug) {
                                                                temp = sub
                                                                    .copyWith(
                                                                  values: sub
                                                                      .values
                                                                      .map(
                                                                          (subVal) {
                                                                    var tempSubVal =
                                                                        subVal;
                                                                    final valueIndex = datas[
                                                                            index]
                                                                        .subs[
                                                                            invertedSubIndex]
                                                                        .values
                                                                        .indexWhere(
                                                                            (value) {
                                                                      return value
                                                                              .slug ==
                                                                          datas[index]
                                                                              .subs[subIndex]
                                                                              .slug;
                                                                    });

                                                                    if (subVal
                                                                            .slug ==
                                                                        datas[index]
                                                                            .subs[invertedSubIndex]
                                                                            .values[valueIndex]
                                                                            .slug) {
                                                                      tempSubVal =
                                                                          tempSubVal
                                                                              .copyWith(
                                                                        value: 1 /
                                                                            value.value,
                                                                      );
                                                                    }

                                                                    return tempSubVal;
                                                                  }).toList(),
                                                                );
                                                              }

                                                              return temp;
                                                            }).toList(),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text(
                                                      criterias[index]
                                                          .subCriterias[
                                                              excSubIndex]
                                                          .title,
                                                      style: Get
                                                          .textTheme.titleMedium
                                                          ?.copyWith(
                                                        color: datas[index]
                                                                    .subs[
                                                                        subIndex]
                                                                    .values[
                                                                        excSubIndex]
                                                                    .slug !=
                                                                datas[index]
                                                                    .subs[
                                                                        subIndex]
                                                                    .slug
                                                            ? Get
                                                                .theme
                                                                .colorScheme
                                                                .primary
                                                            : Get
                                                                .theme
                                                                .colorScheme
                                                                .tertiary,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ).toList(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: "Simpan",
              onPressed: () {
                Get.back(result: datas);
              },
            ),
          ],
        ),
      );
    });
  }
}
