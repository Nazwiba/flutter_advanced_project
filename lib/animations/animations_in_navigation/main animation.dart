import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/animations/animations_in_navigation/second_page_animation.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
    home: Main_animation(),
  ));
}

class Main_animation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondary_animation) {
                            return SecondPageAnimation();
                          },
                          transitionsBuilder:
                              (context, animation, animation2, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration:
                              const Duration(milliseconds: 1000)));
                },
                child: const Text("Fade Animation")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return SecondPageAnimation();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.fastOutSlowIn,
                              )),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(microseconds: 600)));
                },
                child: const Text("Scale Animation")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondary_animation) {
                        return SecondPageAnimation();
                      }, transitionsBuilder:
                          (context, animation, secondaryanimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1.0, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(animation),
                          child: child,
                        );
                      }));
                },
                child: const Text("Slide Animation")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(seconds: 1),
                          child: SecondPageAnimation(),
                          type: PageTransitionType.bottomToTop,
                          childCurrent: this));
                },
                child: const Text("Using Package"))
          ],
        ),
      ),
    );
  }
}
