import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/buttons.dart';
import 'package:sekrut/core/presentation/widgets/fields.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/domain/models/intensity.dart';

class PrioritySheet extends StatelessWidget {
  final List<Criteria> criterias;
  final List<Intensity> intensitiesData;

  const PrioritySheet({
    super.key,
    required this.criterias,
    required this.intensitiesData,
  });

  @override
  Widget build(BuildContext context) {
    final RxList<IntensityForm> intensities = criterias
        .map(
          (crit) {
            final excludedCrits = criterias
                .where((element) => element.slug != crit.slug)
                .toList();

            return IntensityForm(
              slug: crit.slug,
              values: excludedCrits
                  .map((e) => IntensityValue(slug: e.slug))
                  .toList(),
              subs: crit.subCriterias.map((sub) {
                final excludedSubs = crit.subCriterias
                    .where((element) => element.slug != sub.slug)
                    .toList();

                return SubIntensityForm(
                  slug: sub.slug,
                  values: excludedSubs
                      .map(
                        (e) => IntensityValue(slug: e.slug),
                      )
                      .toList(),
                );
              }).toList(),
            );
          },
        )
        .toList()
        .obs;

    return Obx(() {
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    criterias.length,
                    (index) {
                      final excludedList = criterias
                          .where(
                            (element) => element.slug != criterias[index].slug,
                          )
                          .toList();

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
                              excludedList.length,
                              (excIndex) {
                                final double? title =
                                    intensities[index].values[excIndex].value;

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
                                          name: "value",
                                          title: title?.toString(),
                                          hint: "Nilai",
                                          options: intensitiesData,
                                          onOptionSelected: (value) {
                                            if (value != null) {
                                              final invertedIndex = intensities
                                                  .indexWhere((crit) {
                                                return crit.slug ==
                                                    intensities[index]
                                                        .values[excIndex]
                                                        .slug;
                                              });

                                              intensities[index] =
                                                  intensities[index].copyWith(
                                                values: intensities[index]
                                                    .values
                                                    .map((val) {
                                                  var tempValue = val;

                                                  if (val.slug ==
                                                      intensities[index]
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
                                              intensities[invertedIndex] =
                                                  intensities[invertedIndex]
                                                      .copyWith(
                                                values:
                                                    intensities[invertedIndex]
                                                        .values
                                                        .map((val) {
                                                  var tempValue = val;
                                                  final valueIndex = intensities
                                                      .indexWhere((temp) =>
                                                          temp.slug ==
                                                          intensities[index]
                                                              .slug);

                                                  if (val.slug ==
                                                      intensities[valueIndex]
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
                                          excludedList[excIndex].title,
                                          style: Get.textTheme.titleMedium
                                              ?.copyWith(
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
                                final excludedSubs = criterias[index]
                                    .subCriterias
                                    .where((element) =>
                                        element.slug !=
                                        criterias[index]
                                            .subCriterias[subIndex]
                                            .slug)
                                    .toList();

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
                                          excludedSubs.length,
                                          (excSubIndex) => Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                    name: "value",
                                                    title: intensities[index]
                                                        .subs[subIndex]
                                                        .values[excSubIndex]
                                                        .value
                                                        ?.toString(),
                                                    hint: "Nilai",
                                                    options: intensitiesData,
                                                    onOptionSelected: (value) {
                                                      if (value != null) {
                                                        final invertedSubIndex =
                                                            intensities[index]
                                                                .subs
                                                                .indexWhere(
                                                                    (sub) {
                                                          return sub.slug ==
                                                              intensities[index]
                                                                  .subs[
                                                                      subIndex]
                                                                  .values[
                                                                      excSubIndex]
                                                                  .slug;
                                                        });

                                                        intensities[index] =
                                                            intensities[index]
                                                                .copyWith(
                                                          subs:
                                                              intensities[index]
                                                                  .subs
                                                                  .map((sub) {
                                                            var temp = sub;

                                                            if (sub.slug ==
                                                                intensities[
                                                                        index]
                                                                    .subs[
                                                                        subIndex]
                                                                    .slug) {
                                                              temp =
                                                                  sub.copyWith(
                                                                values: sub
                                                                    .values
                                                                    .map(
                                                                        (subVal) {
                                                                  var tempSubVal =
                                                                      subVal;

                                                                  if (subVal
                                                                          .slug ==
                                                                      intensities[index]
                                                                          .subs[
                                                                              subIndex]
                                                                          .values[
                                                                              excSubIndex]
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

                                                        intensities[index] =
                                                            intensities[index]
                                                                .copyWith(
                                                          subs:
                                                              intensities[index]
                                                                  .subs
                                                                  .map((sub) {
                                                            var temp = sub;

                                                            if (sub.slug ==
                                                                intensities[
                                                                        index]
                                                                    .subs[
                                                                        invertedSubIndex]
                                                                    .slug) {
                                                              temp =
                                                                  sub.copyWith(
                                                                values: sub
                                                                    .values
                                                                    .map(
                                                                        (subVal) {
                                                                  var tempSubVal =
                                                                      subVal;
                                                                  final valueIndex = intensities[
                                                                          index]
                                                                      .subs[
                                                                          invertedSubIndex]
                                                                      .values
                                                                      .indexWhere(
                                                                          (value) {
                                                                    return value
                                                                            .slug ==
                                                                        intensities[index]
                                                                            .subs[subIndex]
                                                                            .slug;
                                                                  });

                                                                  if (subVal
                                                                          .slug ==
                                                                      intensities[index]
                                                                          .subs[
                                                                              invertedSubIndex]
                                                                          .values[
                                                                              valueIndex]
                                                                          .slug) {
                                                                    tempSubVal =
                                                                        tempSubVal
                                                                            .copyWith(
                                                                      value: 1 /
                                                                          value
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
                                                      }
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    excludedSubs[excSubIndex]
                                                        .title,
                                                    style: Get
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
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
            const SizedBox(height: 32),
            PrimaryButton(
              title: "Simpan",
              onPressed: () {
                Get.back(result: intensities);
              },
            ),
          ],
        ),
      );
    });
  }
}
