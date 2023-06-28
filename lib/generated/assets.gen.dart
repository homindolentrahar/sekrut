/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/HKGrotesk-Bold.ttf
  String get hKGroteskBold => 'assets/fonts/HKGrotesk-Bold.ttf';

  /// File path: assets/fonts/HKGrotesk-Medium.ttf
  String get hKGroteskMedium => 'assets/fonts/HKGrotesk-Medium.ttf';

  /// File path: assets/fonts/HKGrotesk-Regular.ttf
  String get hKGroteskRegular => 'assets/fonts/HKGrotesk-Regular.ttf';

  /// File path: assets/fonts/HKGrotesk-SemiBold.ttf
  String get hKGroteskSemiBold => 'assets/fonts/HKGrotesk-SemiBold.ttf';

  /// List of all assets
  List<String> get values =>
      [hKGroteskBold, hKGroteskMedium, hKGroteskRegular, hKGroteskSemiBold];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_add.svg
  String get icAdd => 'assets/icons/ic_add.svg';

  /// File path: assets/icons/ic_back.svg
  String get icBack => 'assets/icons/ic_back.svg';

  /// File path: assets/icons/ic_collapsed.svg
  String get icCollapsed => 'assets/icons/ic_collapsed.svg';

  /// File path: assets/icons/ic_date.svg
  String get icDate => 'assets/icons/ic_date.svg';

  /// File path: assets/icons/ic_delete.svg
  String get icDelete => 'assets/icons/ic_delete.svg';

  /// File path: assets/icons/ic_down.svg
  String get icDown => 'assets/icons/ic_down.svg';

  /// File path: assets/icons/ic_drag.svg
  String get icDrag => 'assets/icons/ic_drag.svg';

  /// File path: assets/icons/ic_drag_fill.svg
  String get icDragFill => 'assets/icons/ic_drag_fill.svg';

  /// File path: assets/icons/ic_expanded.svg
  String get icExpanded => 'assets/icons/ic_expanded.svg';

  /// File path: assets/icons/ic_group.svg
  String get icGroup => 'assets/icons/ic_group.svg';

  /// File path: assets/icons/ic_model.svg
  String get icModel => 'assets/icons/ic_model.svg';

  /// File path: assets/icons/ic_proceed.svg
  String get icProceed => 'assets/icons/ic_proceed.svg';

  /// File path: assets/icons/ic_selected.svg
  String get icSelected => 'assets/icons/ic_selected.svg';

  /// File path: assets/icons/ic_sub_criteria.svg
  String get icSubCriteria => 'assets/icons/ic_sub_criteria.svg';

  /// File path: assets/icons/ic_user.svg
  String get icUser => 'assets/icons/ic_user.svg';

  /// List of all assets
  List<String> get values => [
        icAdd,
        icBack,
        icCollapsed,
        icDate,
        icDelete,
        icDown,
        icDrag,
        icDragFill,
        icExpanded,
        icGroup,
        icModel,
        icProceed,
        icSelected,
        icSubCriteria,
        icUser
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
