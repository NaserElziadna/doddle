import 'package:doddle/application/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  //go to canvas screen
                  context.pushNamed(RouteNames.canvas.name);
                },
                child: const Text('New Drawing')),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteNames.aboutMe.name);
              },
              child: const Text('About Me'),
            ),
          ],
        ),
      ),
    );
  }
}
