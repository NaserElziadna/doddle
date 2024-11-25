/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/color_border.svg
  SvgGenImage get colorBorder =>
      const SvgGenImage('assets/svg/color_border.svg');

  /// File path: assets/svg/random_color.svg
  SvgGenImage get randomColor =>
      const SvgGenImage('assets/svg/random_color.svg');

  SvgGenImage get symmtricalLine1 =>
      const SvgGenImage('assets/svg/symmetricalLine1.svg');

  SvgGenImage get symmtricalLine2 =>
      const SvgGenImage('assets/svg/symmetricalLine2.svg');

  SvgGenImage get symmtricalLine3 =>
      const SvgGenImage('assets/svg/symmetricalLine3.svg');

  SvgGenImage get symmtricalLine4 =>
      const SvgGenImage('assets/svg/symmetricalLine4.svg');

  SvgGenImage get symmtricalLine5 =>
      const SvgGenImage('assets/svg/symmetricalLine5.svg');

  SvgGenImage get symmtricalLine6 =>
      const SvgGenImage('assets/svg/symmetricalLine6.svg');

  SvgGenImage get symmtricalLine7 =>
      const SvgGenImage('assets/svg/symmetricalLine7.svg');

  SvgGenImage get symmtricalLine8 =>
      const SvgGenImage('assets/svg/symmetricalLine8.svg');

  SvgGenImage get symmtricalLine =>
      const SvgGenImage('assets/svg/symmetricalLine.svg');

  SvgGenImage get symmtricalLine9 =>
      const SvgGenImage('assets/svg/symmetricalLine9.svg');

  SvgGenImage get symmtricalLine10 =>
      const SvgGenImage('assets/svg/symmetricalLine10.svg');

  SvgGenImage get symmtricalLine11 =>
      const SvgGenImage('assets/svg/symmetricalLine11.svg');

  SvgGenImage get symmtricalLine12 =>
      const SvgGenImage('assets/svg/symmetricalLine12.svg');

  SvgGenImage get symmtricalLine13 =>
      const SvgGenImage('assets/svg/symmetricalLine13.svg');

  SvgGenImage get symmtricalLine14 =>
      const SvgGenImage('assets/svg/symmetricalLine14.svg');

  SvgGenImage get symmtricalLine15 =>
      const SvgGenImage('assets/svg/symmetricalLine15.svg');

  SvgGenImage get symmtricalLine16 =>
      const SvgGenImage('assets/svg/symmetricalLine16.svg');

  SvgGenImage get shareImg => const SvgGenImage('assets/svg/shareImg.svg');
  SvgGenImage get pen => const SvgGenImage('assets/svg/pen.svg');
  SvgGenImage get symmetricalLineBg =>
      const SvgGenImage('assets/svg/symmetricalLineBg.svg');
  SvgGenImage get redo => const SvgGenImage('assets/svg/redo.svg');
  SvgGenImage get workDone => const SvgGenImage('assets/svg/workDone.svg');

  SvgGenImage get undo => const SvgGenImage('assets/svg/undo.svg');
  SvgGenImage get close => const SvgGenImage('assets/svg/close.svg');
  SvgGenImage get eraser => const SvgGenImage('assets/svg/eraser.svg');
  SvgGenImage get share => const SvgGenImage('assets/svg/share.svg');
  SvgGenImage get profileImage =>
      const SvgGenImage('assets/svg/profileImage.svg');

  SvgGenImage get penOff => const SvgGenImage('assets/svg/pen_off.svg');
  SvgGenImage get pen2Preview =>
      const SvgGenImage('assets/svg/pen2_preview.svg');
  SvgGenImage get pen1Preview =>
      const SvgGenImage('assets/svg/pen1_preview.svg');
  SvgGenImage get pen3Preview =>
      const SvgGenImage('assets/svg/pen3_preview.svg');
  SvgGenImage get pen5Preview =>
      const SvgGenImage('assets/svg/pen5_preview.svg');
  SvgGenImage get pen4Preview =>
      const SvgGenImage('assets/svg/pen4_preview.svg');
  SvgGenImage get pen6Preview =>
      const SvgGenImage('assets/svg/pen6_preview.svg');
  SvgGenImage get pen3Preview2 =>
      const SvgGenImage('assets/svg/pen3_preview2.svg');
  SvgGenImage get pen2Preview2 =>
      const SvgGenImage('assets/svg/pen2_preview2.svg');
  SvgGenImage get pen1Preview2 =>
      const SvgGenImage('assets/svg/pen1_preview2.svg');
  SvgGenImage get pen4Preview2 =>
      const SvgGenImage('assets/svg/pen4_preview2.svg');
  SvgGenImage get pen6Preview2 =>
      const SvgGenImage('assets/svg/pen6_preview2.svg');
  SvgGenImage get pen5Preview2 =>
      const SvgGenImage('assets/svg/pen5_preview2.svg');
}

class Assets {
  Assets._();

  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
