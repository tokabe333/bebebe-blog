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

class StartPageView extends State<StartPageWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller1 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300))
    ..repeat(reverse: true);

  late final Animation<double> _animation1 =
      CurvedAnimation(parent: this._controller1, curve: Curves.easeIn);

  // Riveアニメーション
  RiveAnimationController _controller = SimpleAnimation("thumpnail");

  // @override
  // void dispose() {
  //   this._controller1.dispose();
  //   // super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 1000,
    //   height: 500,
    //   alignment: Alignment.center,
    //   color: Colors.blue,
    // );

    return Container(
        height: 500,
        width: 1000,
        color: Colors.blue,
        child: RiveAnimation.asset(
          "assets/animations/liquid_fox.riv",
          controllers: [this._controller],
        ));
    // return Container(
    //     height: MediaQuery.of(context).size.height,
    //     color: Colors.white,
    //     child: FadeTransition(
    //         opacity: this._animation1, child: const Padding(padding: EdgeInsets.all(8), child: FlutterLogo())));
  }
}
