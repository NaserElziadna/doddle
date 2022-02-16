// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// // © Cosmos Software | Ali Yigit Bireroglu                                                                                                           /
// // All material used in the making of this code, project, program, application, software et cetera (the "Intellectual Property")                     /
// // belongs completely and solely to Ali Yigit Bireroglu. This includes but is not limited to the source code, the multimedia and                     /
// // other asset files. If you were granted this Intellectual Property for personal use, you are obligated to include this copyright                   /
// // text at all times.                                                                                                                                /
// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// //@formatter:off

// import 'dart:async';

// import 'package:flutter/material.dart';

// import 'package:cached_network_image/cached_network_image.dart';

// typedef CacheProgressIndicatorBuilder = Widget Function(
//     BuildContext context, double progress);
// typedef ImageSequenceProcessCallback = void Function(
//     ImageSequenceAnimatorState _imageSequenceAnimator);

// class ImageSequenceAnimator extends StatefulWidget {
//   ///The directory of your image sequence.
//   ///If [isOnline] is set to false and, for example, if you add your image sequence to
//   ///'assets/ImageSequences/MyImageSequence'
//   ///then the [folderName] should be 'assets/ImageSequences/MyImageSequence'.
//   ///If [isOnline] is set to true and, for example, if you add your image sequence to
//   ///'https://www.domain.com/ImageSequences/MyImageSequence'
//   ///then the [folderName] should be 'https://www.domain.com/ImageSequences/MyImageSequence'.
//   ///[folderName] should be the same for all the images in your image sequence.
//   final String folderName;

//   ///The file name for each image in your image sequence excluding the suffix. For example, if the images in your image sequence are named as
//   ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
//   ///then the [fileName] should be 'Frame_'. This should be the same for all the images in your image sequence.
//   final String fileName;

//   ///The suffix for the first image in your image sequence. For example, if the first image in your image sequence is named as
//   ///'Frame_00001.png'
//   ///then [suffixStart] should be 1.
//   final int suffixStart;

//   ///The suffix length for each image in your image sequence. Most software such as Adobe After Effects export image sequences with a suffix. For
//   ///example, if the images in your image sequence are named as
//   ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
//   ///then the [suffixCount] should be 5. This should be the same for all the images in your image sequence.
//   final int suffixCount;

//   ///The file format for each image in your image sequence. For example, if the images in your image sequence are named as
//   ///'Frame_00000.png', 'Frame_00001.png', 'Frame_00002.png', 'Frame_00003.png' ...
//   ///then the [fileFormat] should be 'png'. This should be the same for all the images in your image sequence.
//   final String fileFormat;

//   ///The total number of images in your image sequence.
//   final double frameCount;

//   ///Use this value if you would like to specify a list of endpoints for the frames in your image sequence animator. If set, values for [folderName],
//   ///[fileName], [suffixStart], [suffixCount], [fileFormat] and [frameCount] will be ignored.
//   final List<String>? fullPaths;

//   ///The FPS for your image sequence. For example, if your [frameCount] is 60 and the animation is meant to run in 1 second, then your [fps] should
//   /// be 60.
//   final double fps;

//   ///Use this value to determine whether your image sequence should loop or not. This will override [isBoomerang] if both are set to true.
//   final bool isLooping;

//   ///Use this value to determine whether your image sequence should boomerang or not.
//   final bool isBoomerang;

//   ///Use this value to determine whether your image sequence should start playing immediately or not.
//   final bool isAutoPlay;

//   ///Use this value to determine the color for your image sequence.
//   final Color? color;

//   ///Set this value to true if your [folderName] is an online path.
//   final bool isOnline;

//   ///Set this value to true if you want the [ImageSequenceAnimator] to wait until the entire image sequence is cached. Otherwise, the [ImageSequenceAnimator]
//   ///will invoke [onReadyToPlay] and start playing if [isAutoPlay] is set to true when it approximates that the remaining caching can be completed without
//   ///causing stutters. This value is only used if [isOnline] is set to true.
//   final bool waitUntilCacheIsComplete;

//   ///Use this function to display a widget until the [ImageSequenceAnimator] is ready to be played. This value is only used if [isOnline] is set to true.
//   final CacheProgressIndicatorBuilder? cacheProgressIndicatorBuilder;

//   ///The callback for when the [ImageSequenceAnimator] is ready to start playing.
//   final ImageSequenceProcessCallback? onReadyToPlay;

//   ///The callback for when the [ImageSequenceAnimator] starts playing.
//   final ImageSequenceProcessCallback? onStartPlaying;

//   ///The callback for when the [ImageSequenceAnimator] is playing. This callback is continuously through the entire process.
//   final ImageSequenceProcessCallback? onPlaying;

//   ///The callback for when the [ImageSequenceAnimator] finishes playing.
//   final ImageSequenceProcessCallback? onFinishPlaying;

//   const ImageSequenceAnimator(
//     this.folderName,
//     this.fileName,
//     this.suffixStart,
//     this.suffixCount,
//     this.fileFormat,
//     this.frameCount, {
//     Key? key,
//     this.fullPaths,
//     this.fps: 60,
//     this.isLooping: false,
//     this.isBoomerang: false,
//     this.isAutoPlay: true,
//     this.color,
//     this.isOnline: false,
//     this.waitUntilCacheIsComplete: false,
//     this.cacheProgressIndicatorBuilder,
//     this.onReadyToPlay,
//     this.onStartPlaying,
//     this.onPlaying,
//     this.onFinishPlaying,
//   }) : super(key: key);

//   @override
//   ImageSequenceAnimatorState createState() {
//     return ImageSequenceAnimatorState(
//       folderName,
//       fileName,
//       fileFormat,
//       isLooping,
//       isBoomerang,
//       color,
//     );
//   }
// }

// class ImageSequenceAnimatorState extends State<ImageSequenceAnimator>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//   final ValueNotifier<int> _changeNotifier = ValueNotifier<int>(0);

//   String _folderName;
//   String _fileName;
//   String _fileFormat;
//   double get _frameCount =>
//       _useFullPaths ? widget.fullPaths!.length * 1.0 : widget.frameCount;
//   bool get _useFullPaths =>
//       widget.fullPaths != null && widget.fullPaths!.isNotEmpty;

//   ///Use this value to check if this [ImageSequenceAnimator] is currently looping.
//   bool get isLooping => _isLooping;
//   bool _isLooping;

//   ///Use this value to check if this [ImageSequenceAnimator] is currently boomeranging.
//   bool get isBoomerang => _isBoomerang;
//   bool _isBoomerang;

//   ///Use this value to check the current color of this [ImageSequenceAnimator].
//   Color? color;

//   bool _isReadyToPlay = false;
//   bool _isCacheComplete = false;
//   bool _colorChanged = false;

//   int _previousFrame = 0;
//   int get _newFrame => _animationController!.value.floor();
//   int _previousCacheFrame = 0;
//   int? _newCacheFrame;

//   Widget? _currentOfflineFrame;
//   Widget? _currentCachedOnlineFrame;
//   Widget? _currentDisplayedOnlineFrame;

//   Timer? _cacheTimer;
//   DateTime? _cacheStartDateTime;
//   int get _cacheMillisProgressed =>
//       DateTime.now().difference(_cacheStartDateTime!).inMilliseconds;
//   double get _cacheMillisRemaining =>
//       _cacheMillisProgressed.toDouble() /
//       _previousCacheFrame.toDouble() *
//       (_frameCount - _previousCacheFrame).toDouble();
//   double get _cacheMillisTotal =>
//       _cacheMillisProgressed + _cacheMillisRemaining;

//   bool get isPlaying =>
//       _animationController != null && _animationController!.isAnimating;
//   int get _fpsInMilliseconds => (1.0 / widget.fps * 1000.0).floor();

//   ///Use this value to get the current time of the animation in frames.
//   double get currentProgress =>
//       _animationController == null ? 0.0 : _animationController!.value;

//   ///Use this value to get the total time of the animation in frames.
//   double get totalProgress =>
//       _animationController == null ? 0.0 : _animationController!.upperBound;

//   ///Use this value to get the current time of the animation in milliseconds.
//   double get currentTime => currentProgress * _fpsInMilliseconds;

//   ///Use this value to get the total time of the animation in milliseconds.
//   double get totalTime => totalProgress * _fpsInMilliseconds;

//   ImageSequenceAnimatorState(
//     this._folderName,
//     this._fileName,
//     this._fileFormat,
//     this._isLooping,
//     this._isBoomerang,
//     this.color,
//   );

//   void animationListener() {
//     _changeNotifier.value++;

//     if (widget.onPlaying != null) widget.onPlaying!(this);
//   }

//   void animationStatusListener(AnimationStatus animationStatus) {
//     switch (animationStatus) {
//       case AnimationStatus.completed:
//         if (widget.onFinishPlaying != null) widget.onFinishPlaying!(this);

//         if (isLooping) restart();
//         if (isBoomerang) rewind();
//         break;
//       case AnimationStatus.dismissed:
//         if (widget.onFinishPlaying != null) widget.onFinishPlaying!(this);

//         if (isLooping || isBoomerang) play();
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       lowerBound: 0,
//       upperBound: _frameCount,
//       duration: Duration(milliseconds: _frameCount.ceil() * _fpsInMilliseconds),
//     )
//       ..addListener(animationListener)
//       ..addStatusListener(animationStatusListener);

//     if (isLooping) _isBoomerang = false;

//     if (_folderName.endsWith("/"))
//       _folderName = _folderName.substring(0, _folderName.indexOf(("/")));
//     if (_fileFormat.startsWith(".")) _fileFormat = _fileFormat.substring(1);

//     if (!widget.isOnline) {
//       _isReadyToPlay = true;
//       if (widget.onReadyToPlay != null) widget.onReadyToPlay!(this);
//       if (widget.isAutoPlay) play();
//     }
//   }

//   @override
//   void dispose() {
//     _reset();

//     _animationController!.removeListener(animationListener);
//     _animationController!.removeStatusListener(animationStatusListener);
//     _animationController!.dispose();

//     super.dispose();
//   }

//   ///Use this function to set the value for [ImageSequenceAnimatorState.isLooping] at runtime.
//   void setIsLooping(bool isLooping) {
//     if (!_isReadyToPlay) return;

//     this._isLooping = isLooping;
//     if (this.isLooping) {
//       _isBoomerang = false;
//       if (!_animationController!.isAnimating) restart();
//     }
//   }

//   ///Use this function to set the value for [ImageSequenceAnimatorState.isBoomerang] at runtime.
//   void setIsBoomerang(bool isBoomerang) {
//     if (!_isReadyToPlay) return;

//     this._isBoomerang = isBoomerang;
//     if (this.isBoomerang) {
//       _isLooping = false;
//       if (!_animationController!.isAnimating) restart();
//     }
//   }

//   ///Use this function to set the value for [ImageSequenceAnimatorState.color] at runtime.
//   void changeColor(Color color) {
//     if (!_isReadyToPlay) return;

//     this.color = color;
//     _colorChanged = true;
//     _changeNotifier.value++;
//   }

//   ///Use this function to play this [ImageSequenceAnimator].
//   void play({double from: -1.0}) {
//     if (!_isReadyToPlay) return;

//     if (!_animationController!.isAnimating && widget.onStartPlaying != null)
//       widget.onStartPlaying!(this);

//     if (from == -1.0)
//       _animationController!.forward();
//     else
//       _animationController!.forward(from: from);
//   }

//   ///Use this function to rewind this [ImageSequenceAnimator].
//   void rewind({double from: -1.0}) {
//     if (!_isReadyToPlay) return;

//     if (!_animationController!.isAnimating && widget.onStartPlaying != null)
//       widget.onStartPlaying!(this);

//     if (from == -1.0)
//       _animationController!.reverse();
//     else
//       _animationController!.reverse(from: from);
//   }

//   ///Use this function to pause this [ImageSequenceAnimator].
//   void pause() {
//     if (!_isReadyToPlay) return;

//     _animationController!.stop();
//   }

//   ///Only use either value or percentage.
//   void skip(double value, {double percentage: -1.0}) {
//     if (!_isReadyToPlay) return;

//     if (percentage != -1.0)
//       _animationController!.value = totalTime * percentage;
//     else
//       _animationController!.value = value;
//   }

//   ///Use this function to restart this [ImageSequenceAnimator].
//   void restart() {
//     if (!_isReadyToPlay) return;

//     stop();
//     play();
//   }

//   ///Use this function to stop this [ImageSequenceAnimator].
//   void stop() {
//     if (!_isReadyToPlay) return;

//     _reset();
//   }

//   void _reset() {
//     _animationController!.value = 0;
//     _animationController!.stop(canceled: true);
//     _previousFrame = 0;
//     _currentOfflineFrame = null;
//   }

//   void _cache() {
//     int _value = _previousCacheFrame;
//     _value++;

//     if (_value < _frameCount) {
//       _previousCacheFrame = _value;
//       _changeNotifier.value++;
//     } else
//       _isCacheComplete = true;

//     if (!_isReadyToPlay) {
//       if ((widget.waitUntilCacheIsComplete && _isCacheComplete) ||
//           (!widget.waitUntilCacheIsComplete &&
//               _cacheMillisRemaining * 0.85 < totalTime)) {
//         _isReadyToPlay = true;
//         if (widget.onReadyToPlay != null) widget.onReadyToPlay!(this);
//         if (widget.isAutoPlay) play(from: 0.0);
//       }
//     }
//   }

//   String _getSuffix(String value) {
//     while (value.length < widget.suffixCount) value = "0" + value;
//     return value;
//   }

//   String _getCurrentFrame() {
//     if (_useFullPaths) {
//       return widget.fullPaths![_previousFrame];
//     }
//     return _folderName +
//         "/" +
//         _fileName +
//         _getSuffix((widget.suffixStart + _previousFrame).toString()) +
//         "." +
//         _fileFormat;
//   }

//   String _getCacheDirectory() {
//     if (_useFullPaths) {
//       return widget.fullPaths![_previousCacheFrame];
//     }
//     return _folderName +
//         "/" +
//         _fileName +
//         _getSuffix((widget.suffixStart + _previousCacheFrame).toString()) +
//         "." +
//         _fileFormat;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!widget.isOnline) {
//       return ValueListenableBuilder(
//         builder: (BuildContext context, int change, Widget? cachedChild) {
//           if (_currentOfflineFrame == null ||
//               _animationController!.value.floor() != _previousFrame ||
//               _colorChanged) {
//             _colorChanged = false;
//             _previousFrame = _animationController!.value.floor();
//             if (_previousFrame < _frameCount) {
//               // _currentOfflineFrame = Image.asset(
//               //   _getDirectory(),
//               //   color: color,
//               //   gaplessPlayback: true,
//               // );
//               _currentOfflineFrame = Image.memory(
//                 bytes,
//                 color: color,
//                 gaplessPlayback: true,
//               );
//             }
//           }

//           return _currentOfflineFrame!;
//         },
//         valueListenable: _changeNotifier,
//       );
//     } else
//       return ValueListenableBuilder(
//         builder: (BuildContext context, int change, Widget? cachedChild) {
//           if (!_isCacheComplete) {
//             if (_currentCachedOnlineFrame == null ||
//                 _newCacheFrame != _previousCacheFrame) {
//               _newCacheFrame = _previousCacheFrame;
//               if (_cacheStartDateTime == null)
//                 _cacheStartDateTime = DateTime.now();
//               _currentCachedOnlineFrame = CachedNetworkImage(
//                 imageUrl: _getCacheDirectory(),
//                 progressIndicatorBuilder: (context, url, downloadProgress) {
//                   if (downloadProgress.progress == null) {
//                     _cacheTimer?.cancel();
//                     _cacheTimer =
//                         Timer(const Duration(milliseconds: 25), () => _cache());
//                   } else {
//                     _cacheTimer?.cancel();
//                     if (downloadProgress.progress == 1.0) _cache();
//                   }
//                   if (!_isReadyToPlay &&
//                       widget.cacheProgressIndicatorBuilder != null)
//                     return widget.cacheProgressIndicatorBuilder!(context,
//                         1.0 - _cacheMillisRemaining / _cacheMillisTotal);
//                   else
//                     return Container();
//                 },
//                 color: Colors.transparent,
//               );
//             }
//           } else
//             _currentCachedOnlineFrame = Container();
//           if (_isReadyToPlay) {
//             if (_currentDisplayedOnlineFrame == null ||
//                 _newFrame != _previousFrame ||
//                 _colorChanged) {
//               _colorChanged = false;
//               _previousFrame = _animationController!.value.floor();
//               if (_previousFrame < _frameCount) {
//                 _currentDisplayedOnlineFrame = CachedNetworkImage(
//                   imageUrl: _getDirectory(),
//                   color: color,
//                   useOldImageOnUrlChange: _isCacheComplete,
//                   fadeOutDuration: const Duration(milliseconds: 0),
//                   fadeInDuration: const Duration(milliseconds: 0),
//                 );
//               }
//             }
//           } else
//             _currentDisplayedOnlineFrame = Container();

//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               _currentCachedOnlineFrame!,
//               _currentDisplayedOnlineFrame!,
//             ],
//           );
//         },
//         valueListenable: _changeNotifier,
//       );
//   }
// }
