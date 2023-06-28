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

class BoxTextField extends StatelessWidget {
  final String? initValue;
  final String name;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final int lines;
  final Widget? suffixIcon;
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
  final String title;
  final List<T> options;
  final ValueChanged<T?> onOptionSelected;

  const BoxSelectorField({
    super.key,
    required this.name,
    required this.title,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      onChanged: (value) {
        onOptionSelected(value);
      },
      builder: (field) => GestureDetector(
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
                  child: PrimarySubtitle(text: title),
                ),
                ...List.generate(
                  options.length,
                  (index) => Material(
                    color: Get.theme.colorScheme.surface,
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
                              (options[index] as dynamic).title.toString(),
                              style: Get.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (options[index] as dynamic)
                                  .description
                                  .toString(),
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.colorScheme.onBackground,
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
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.background.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Get.theme.colorScheme.outline),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.tertiary,
                ),
              ),
              SvgPicture.asset(
                Assets.icons.icDown,
                color: Get.theme.colorScheme.tertiary,
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
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
