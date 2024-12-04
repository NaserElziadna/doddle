import 'package:doddle/presentation/screens/canvas_screen/canvas_screen.dart';
import 'package:doddle/presentation/screens/common/screens/error_screen.dart';
import 'package:doddle/presentation/screens/about_me_screen/about_me_page.dart';
import 'package:doddle/presentation/screens/home_screen/home_screen.dart';
import 'package:doddle/presentation/screens/preview_screen/preview_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.home.path,
        name: RouteNames.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: RouteNames.canvas.path,
            name: RouteNames.canvas.name,
            builder: (context, state) => const CanvasScreen(),
          ),
          GoRoute(
            path: RouteNames.aboutMe.path,
            name: RouteNames.aboutMe.name,
            builder: (context, state) => const AboutMeScreen(),
          ),
          GoRoute(
            path: RouteNames.preview.path,
            name: RouteNames.preview.name,
            builder: (context, state) => const PreviewScreen(),
          ),
          // GoRoute(
          //   path: 'tools',
          //   name: 'tools',
          //   builder: (context, state) => const ToolsScreen(),
          // ),
          // Add more nested routes here
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
});

// Optional: Create route names as constants
class RouteNames {
  //use recored to store two values
  static const NavInfo home = NavInfo('home', '/');
  static const NavInfo tools = NavInfo('tools', '/tools');
  static const NavInfo canvas = NavInfo('canvas', '/canvas');
  static const NavInfo aboutMe = NavInfo('aboutMe', '/aboutMe');
  static const NavInfo preview = NavInfo('preview', '/preview');

  // Add more route names
}

// Optional: Create route paths as constants
class NavInfo {
  final String name;
  final String path;
  const NavInfo(this.name, this.path);
}
