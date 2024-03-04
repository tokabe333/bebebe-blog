/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

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

  /// デモのサイズ(元のriveファイル)
  double demoOriginHeight = 340;

  /// でものサイズ(元のriveファイル)
  double demoOriginWidth = 500;

  StartPageView(bool this.isPlayDemo) {}

  @override
  void dispose() {
    this._controller.dispose();
    this._stopContoller.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    // でも画面のサイズを決める
    double demoWidth = 0, demoHeight = 0;
    double leftpadding = 0;
    if (displayWidth <= displayHeight) {
      demoWidth = displayWidth;
      demoHeight = demoWidth / 500 * 340;
    } else {
      demoHeight = displayHeight - 60;
      demoWidth = math.min(displayWidth, demoHeight / 340 * 500);
      leftpadding = (displayWidth - demoWidth) / 2;
    }

    print("display:${displayWidth},${displayHeight}  demo:${demoWidth},${demoHeight}");

    Widget demo = this.isPlayDemo ? playDemo() : noPlayDemo();

    return Container(
      height: displayHeight - 60,
      width: displayWidth,
      color: const Color.fromARGB(255, 137, 194, 240),
      child: Stack(
        children: [
          Positioned(left: leftpadding, top: 0, child: Container(width: demoWidth, height: demoHeight, child: demo))
        ],
      ),
    );
  } // end of method

  /// デモを再生するだけ
  Widget playDemo() {
    return RiveAnimation.asset(
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
