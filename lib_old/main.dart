import 'dart:async';
import 'dart:typed_data';

import 'doddler.dart';
import 'generated/assets.gen.dart';
import 'models/draw_controller.dart';
import 'pages/about_me_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_event.dart';
import 'firebase_options.dart';
import 'utils/ad_helper.dart';
import 'widgets/tools_widget.dart';



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await MobileAds.instance.initialize();

//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//   // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//   // await Firebase.initializeApp();

//   // Pass all uncaught errors from the framework to Crashlytics.
//   // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     // DeviceOrientation.portraitDown,
//   ]); // To turn off landscape mode
//   try {
//     runApp(const MyApp());
//   } catch (e) {
//     FirebaseCrashlytics.instance.log(e.toString());
//   }
// }

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
  // TODO: Add _bannerAd
  // late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  // bool _isBannerAdReady = false;

  @override
  void initState() {
   
    // TODO: Initialize _bannerAd
    // _bannerAd = BannerAd(
    //   adUnitId: AdHelper.bannerAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       print('Failed to load a banner ad: ${err.message}');
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    // );

    // _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.purple[800],
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
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
                    if (kIsWeb == false)
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
                // TODO: Display a banner when ready
                // if (_isBannerAdReady)
                //   Align(
                //     alignment: Alignment.topCenter,
                //     child: Container(
                //       width: _bannerAd.size.width.toDouble(),
                //       height: _bannerAd.size.height.toDouble(),
                //       child: AdWidget(ad: _bannerAd),
                //     ),
                //   ),
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
