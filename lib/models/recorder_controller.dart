import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'frame.dart';
import 'package:image/image.dart' as image;

class RecorderController {
  final GlobalKey? globalKey;
  final List<Frame>? frames;
  RecorderController({
    this.globalKey,
    this.frames,
  });

  Future<Uint8List> convertImageToUint8List(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  Future<List<int>?> export() async {
    List<RawFrame> bytes = [];
    for (final frame in frames!) {
      final i = await frame.frame!.toByteData(format: ui.ImageByteFormat.png);
      if (i != null) {
        bytes.add(RawFrame(32, i));
      } else {
        print('Skipped frame while enconding');
      }
    }
    final result = compute(_export, bytes);
    frames!.clear();
    return result;
  }

  static Future<List<int>?> _export(List<RawFrame> frames) async {
    final animation = image.Animation();
    animation.backgroundColor = Colors.transparent.value;
    for (final frame in frames) {
      final iAsBytes = frame.image.buffer.asUint8List();
      final decodedImage = image.decodePng(iAsBytes);

      if (decodedImage == null) {
        print('Skipped frame while enconding');
        continue;
      }
      decodedImage.duration = frame.durationInMillis;
      animation.addFrame(decodedImage);
    }
    return image.encodeGifAnimation(animation);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecorderController &&
        other.globalKey == globalKey &&
        listEquals(other.frames, frames);
  }

  @override
  int get hashCode => globalKey.hashCode ^ frames.hashCode;

  @override
  String toString() =>
      'RecorderController(globalKey: $globalKey, frames: $frames)';

  RecorderController copyWith({
    GlobalKey? globalKey,
    List<Frame>? frames,
  }) {
    return RecorderController(
      globalKey: globalKey ?? this.globalKey,
      frames: frames ?? this.frames,
    );
  }
}

class RawFrame {
  RawFrame(this.durationInMillis, this.image);

  final int durationInMillis;
  final ByteData image;
}
