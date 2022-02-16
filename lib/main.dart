import 'dart:async';
import 'dart:io';

import 'package:doddle/doddler.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/models/recorder_controller.dart';
import 'package:doddle/pages/about_me_page.dart';
import 'package:doddle/recorder_bloc/recorder_bloc.dart';
import 'package:doddle/recorder_bloc/recorder_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_event.dart';
import 'widgets/tools_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]); // To turn off landscape mode
  try {
    runApp(const MyApp());
  } catch (e) {
    FirebaseCrashlytics.instance.log(e.toString());
  }
}

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoddlerBloc(
            drawController: DrawController(
                isPanActive: true,
                penTool: PenTool.glowPen,
                points: [],
                currentColor: Colors.green,
                symmetryLines: 1),
          ),
        ),
        BlocProvider(
          create: (context) => RecorderBloc(
            recorderController: RecorderController(
              frames: [],
              globalKey: GlobalKey(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawController? drawController;
  // Timer? timer;

  // static AdRequest request = const AdRequest(
  //   keywords: <String>['draw', 'painting'],
  //   contentUrl: 'www.nmmsoft.com',
  //   nonPersonalizedAds: false,
  // );
  // RewardedAd? _rewardedAd;
  // int _numRewardedLoadAttempts = 0;

  // void _createRewardedAd() {
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-3940256099942544/5224354917',
  //       request: request,
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         onAdLoaded: (RewardedAd ad) {
  //           print('$ad loaded.');
  //           _rewardedAd = ad;
  //           _numRewardedLoadAttempts = 0;
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('RewardedAd failed to load: $error');
  //           _rewardedAd = null;
  //           _numRewardedLoadAttempts += 1;
  //           if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
  //             _createRewardedAd();
  //           }
  //         },
  //       ));
  // }

  // void _showRewardedAd() {
  //   if (_rewardedAd == null) {
  //     print('Warning: attempt to show rewarded before loaded.');
  //     return;
  //   }
  //   _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (RewardedAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createRewardedAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createRewardedAd();
  //     },
  //   );

  //   _rewardedAd!.setImmersiveMode(true);
  //   _rewardedAd!.show(
  //       onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //     print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
  //   });
  //   _rewardedAd = null;
  // }

  // @override
  // void initState() {
  //   _createRewardedAd();
  //   drawController = context.read<DoddlerBloc>().drawController;
  //   context.read<RecorderBloc>().add(StartRecordingEvent());
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _rewardedAd?.dispose();

  //   timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.purple[800],
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.save_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    // _showRewardedAd();
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(SavePageToGalleryEvent());
                  },
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return const AboutMePage();
                    }));
                  },
                ),
                GestureDetector(
                  child: Assets.svg.share.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(ShareImageEvent(context: context));
                  },
                ),
                const Spacer(),
                GestureDetector(
                  child: Assets.svg.undo.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(UndoStampsEvent());
                  },
                ),
                GestureDetector(
                  child: Assets.svg.redo.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(RedoStampsEvent());
                  },
                ),
                const Spacer(),
                GestureDetector(
                  child: Assets.svg.close.svg(width: 40),
                  onTap: () {
                    // BlocProvider.of<DoddlerBloc>(context)
                    //     .add(ClearStampsEvent());

                    context.read<DoddlerBloc>().add(MessageEvent(
                        "This will case to clear the canvas ,\n are you sure you want to Continue ? ",
                        isClear: true));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.purple[800],
          child: const Doddler(),
        ),
        bottomSheet: const ToolsWidget(),
      ),
    );
  }
}
