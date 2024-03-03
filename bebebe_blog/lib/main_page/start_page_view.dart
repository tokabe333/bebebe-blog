/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../main_frame.dart';

class StartPageWidget extends StatefulWidget {
  StartPageWidget({Key? key, bool this.isPlayDemo = true}) : super(key: key);
  final String title = "べーやん's Site";
  bool isPlayDemo;
  State<StartPageWidget> createState() => StartPageView(this.isPlayDemo);
}

class StartPageView extends State<StartPageWidget> with TickerProviderStateMixin {
  // Riveアニメーション
  RiveAnimationController _controller = SimpleAnimation("demo");

  RiveAnimationController _stopContoller = OneShotAnimation("text2");

  // デモファイルのアートボード
  Artboard? mainDemoArtboard;

  /// でも再生する？
  bool isPlayDemo = true;

  StartPageView(bool this.isPlayDemo) {}

  @override
  void dispose() {
    this._controller.dispose();
    this._stopContoller.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height - 60,
      width: width,
      color: const Color.fromARGB(255, 137, 194, 240),
      child: this.isPlayDemo ? playDemo() : noPlayDemo(),
    );
  } // end of method

  /// デモを再生するだけ
  Widget playDemo() {
    return RiveAnimation.asset(
      // "assets/animations/laptop_click.riv",
      "assets/animations/maindemo_nologo.riv",
      controllers: [this._controller],
    );
  } // end of method

  /// 最後の終了シーンのみ
  Widget noPlayDemo() {
    return RiveAnimation.asset(
      "assets/animations/maindemo_nologo_textonly.riv",
      controllers: [this._stopContoller],
    );
  } // end of method
} // end of class
