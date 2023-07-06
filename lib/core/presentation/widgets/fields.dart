import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/presentation/widgets/texts.dart';
import 'package:sekrut/core/ui/app_color.dart';
import 'package:sekrut/generated/assets.gen.dart';

class UnderlinedTextField extends StatelessWidget {
  final String? initValue;
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? Function(String?)? validators;

  const UnderlinedTextField({
    super.key,
    this.initValue,
    required this.name,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    this.textStyle,
    this.hintStyle,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initValue,
      name: name,
      validator: validators,
      keyboardType: keyboardType,
      textInputAction: action,
      style: textStyle ?? Get.textTheme.titleMedium,
      decoration: InputDecoration(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: hint,
        hintStyle: hintStyle ??
            Get.textTheme.bodyLarge?.copyWith(color: AppColor.gray),
        errorStyle: Get.textTheme.titleSmall?.copyWith(
          color: Get.theme.colorScheme.error,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 4),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 4),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 4),
        ),
      ),
    );
  }
}

class BoxTextField<T> extends StatelessWidget {
  final String? initValue;
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int lines;
  final Widget? suffixIcon;
  final ValueTransformer<String?>? valueTransformer;
  final String? Function(String?)? validators;

  const BoxTextField({
    super.key,
    this.initValue,
    required this.name,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.done,
    this.textStyle,
    this.hintStyle,
    this.lines = 1,
    this.suffixIcon,
    this.valueTransformer,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initValue,
      name: name,
      validator: validators,
      keyboardType: keyboardType,
      textInputAction: action,
      style: textStyle ?? Get.textTheme.titleMedium,
      maxLines: lines,
      minLines: lines,
      valueTransformer: valueTransformer,
      decoration: InputDecoration(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintText: hint,
        hintStyle: hintStyle ??
            Get.textTheme.titleMedium?.copyWith(
              color: AppColor.gray,
            ),
        errorStyle: Get.textTheme.titleSmall?.copyWith(
          color: Get.theme.colorScheme.error,
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.outline,
            width: 1.25,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.primaryColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.outline,
            width: 1.25,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1.25,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class BoxSelectorField<T> extends StatelessWidget {
  final String name;
  final String? title;
  final String hint;
  final T? initialValue;
  final List options;
  final ValueChanged<T?> onOptionSelected;

  const BoxSelectorField({
    super.key,
    required this.name,
    required this.title,
    required this.hint,
    this.initialValue,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      initialValue: initialValue,
      validator: (value) {
        if (value == null) {
          return "Item cannot be empty";
        }

        return null;
      },
      onChanged: (value) {
        onOptionSelected(value);
      },
      builder: (field) {
        final TextEditingController controller = TextEditingController(
          text: title,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderTextField(
              name: "",
              controller: controller,
              readOnly: true,
              onTap: () async {
                final T? result = await Get.bottomSheet(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 24,
                          bottom: 16,
                        ),
                        child: PrimarySubtitle(text: hint),
                      ),
                      ...List.generate(
                        options.length,
                        (index) => Material(
                          color: initialValue != options[index]
                              ? Get.theme.colorScheme.surface
                              : Get.theme.colorScheme.onSurface,
                          child: InkWell(
                            onTap: () {
                              Get.back(result: options[index]);
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (options[index] as dynamic)
                                        .title
                                        .toString(),
                                    style:
                                        Get.textTheme.headlineSmall?.copyWith(
                                      color: initialValue != options[index]
                                          ? Get.theme.colorScheme.onSurface
                                          : Get.theme.colorScheme.surface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    (options[index] as dynamic)
                                        .description
                                        .toString(),
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                      color: initialValue != options[index]
                                          ? Get.theme.colorScheme.onBackground
                                          : Get.theme.colorScheme.background,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ],
                  ),
                  isScrollControlled: true,
                  backgroundColor: Get.theme.colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                );

                if (result != null) {
                  field.didChange(result);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Get.theme.colorScheme.background.withOpacity(0.5),
                hintText: hint,
                hintStyle: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: SvgPicture.asset(
                  Assets.icons.icDown,
                  color: Get.theme.colorScheme.tertiary,
                  width: 16,
                  height: 16,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Get.theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Get.theme.colorScheme.outline),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Get.theme.colorScheme.outline),
                ),
              ),
            ),
            Visibility(
              visible: field.hasError,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      field.errorText ?? "",
                      style: Get.textTheme.titleSmall?.copyWith(
                        color: Get.theme.colorScheme.error,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      // child: Container(
      //   padding: const EdgeInsets.all(16),
      //   decoration: BoxDecoration(
      //     color: Get.theme.colorScheme.background.withOpacity(0.5),
      //     borderRadius: BorderRadius.circular(8),
      //     border: Border.all(color: Get.theme.colorScheme.outline),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         hint,
      //         style: Get.textTheme.titleMedium?.copyWith(
      //           color: Get.theme.colorScheme.tertiary,
      //         ),
      //       ),
      //       SvgPicture.asset(
      //         Assets.icons.icDown,
      //         color: Get.theme.colorScheme.tertiary,
      //         width: 16,
      //         height: 16,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// class GroupBoxSelectorField<A, B, C> extends StatelessWidget {
//   final String name;
//   final String title;
//   final List<Map<B, List<C>>> selectors;

//   const GroupBoxSelectorField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderField(
//       name: name,
//       valueTransformer: (value) {},
//       builder: (field) => Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           PrimarySubtitle(text: title),
//           const SizedBox(height: 16),
//           Wrap(
//             direction: Axis.vertical,
//             spacing: 16,
//             children: selectors
//                 .map(
//                   (map) => BoxSelectorField(
//                     name: name,
//                     title: title,
//                     options: options,
//                     onOptionSelected: onOptionSelected,
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ListItemField<T> extends StatelessWidget {
  final String name;
  final Widget listItem;
  final Widget addItem;
  final ValueChanged<T?> onItemAdded;

  const ListItemField({
    super.key,
    required this.name,
    required this.listItem,
    required this.addItem,
    required this.onItemAdded,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
