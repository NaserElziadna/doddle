import 'package:doddle/application/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref);
});

class NavigationService {
  final Ref ref;

  NavigationService(this.ref);

  void goToTools(BuildContext context) {
    context.pushNamed(RouteNames.tools.name);
  }

  void goHome(BuildContext context) {
    context.goNamed(RouteNames.home.name);
  }

  // Add more navigation methods
}
