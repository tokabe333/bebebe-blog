/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../main_frame.dart';

class StartPageWidget extends StatefulWidget {
  StartPageWidget({Key? key}) : super(key: key);
  final String title = "べーやん's Site";
  State<StartPageWidget> createState() => StartPageView();
}

class StartPageView extends State<StartPageWidget> with TickerProviderStateMixin {
  late final AnimationController _controller1 =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..repeat(reverse: true);

  late final Animation<double> _animation1 = CurvedAnimation(parent: this._controller1, curve: Curves.easeIn);

  // Riveアニメーション
  RiveAnimationController _controller = SimpleAnimation("demo");
  // RiveAnimationController _controller = SimpleAnimation("Idle");

  // @override
  // void dispose() {
  //   this._controller1.dispose();
  //   // super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height,
        width: width,
        color: const Color.fromARGB(255, 137, 194, 240),
        child: RiveAnimation.asset(
          // "assets/animations/laptop_click.riv",
          "assets/animations/maindemo_nologo.riv",
          controllers: [this._controller],
        ));
  } // end of method
} // end of class
