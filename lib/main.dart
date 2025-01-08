import 'package:doddle/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/providers/config/config_provider.dart';
import 'application/providers/theme/theme_providers.dart';
import 'application/providers/router/router_provider.dart';

// Create a global variable for SharedPreferences
late SharedPreferences prefs;
WidgetRef? _globalRef;
WidgetRef get globalRef => _globalRef!;

void initializeGlobalRef(WidgetRef ref) {
  _globalRef = ref;
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
}

void main() async {
  await initializeApp();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Update SharedPreferences provider to use the global instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => prefs);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeGlobalRef(ref);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: ref.watch(configProvider).appName,
          debugShowCheckedModeBanner: false,
          themeMode: ref.watch(themeModeProvider),
          theme: appTheme,
          darkTheme: appTheme,
          routerConfig: ref.watch(routerProvider),
          builder: (context, child) {
            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
