/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:bebebe_blog/main_page/main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

import '../main_frame.dart';

class DemoPageWidget {
  // Riveアニメーション
  RiveAnimationController _controller = SimpleAnimation("demo");

  RiveAnimationController _stopContoller = OneShotAnimation("text2");

  // デモファイルのアートボード
  Artboard? mainDemoArtboard;

  /// でも再生する？
  bool isPlayDemo;

  /// デモのサイズ(元のriveファイル)
  double demoOriginHeight = 340;

  /// でものサイズ(元のriveファイル)
  double demoOriginWidth = 500;

  late Widget demo;

  DemoPageWidget(bool this.isPlayDemo) {
    this.demo = this.isPlayDemo ? _playDemo() : _noPlayDemo();
  }

  Widget createDemoWidget(BuildContext context) {
    return demo;

    // double displayWidth = MediaQuery.of(context).size.width;
    // double displayHeight = MediaQuery.of(context).size.height;

    // // でも画面のサイズを決める
    // double demoWidth = 0, demoHeight = 0;
    // double leftpadding = 0;
    // if (displayWidth <= displayHeight) {
    //   demoWidth = displayWidth;
    //   demoHeight = demoWidth / 500 * 340;
    // } else {
    //   demoHeight = displayHeight - 60;
    //   demoWidth = math.min(displayWidth, demoHeight / 340 * 500);
    //   leftpadding = (displayWidth - demoWidth) / 2;
    // }

    // return Container(
    //   height: demoHeight,
    //   width: demoWidth,
    //   child: demo,
    // );
  } // end of method

  /// デモを再生するだけ
  Widget _playDemo() {
    return RiveAnimation.asset(
      "assets/animations/maindemo_nologo.riv",
      controllers: [this._controller],
    );
  } // end of method

  /// 最後の終了シーンのみ
  Widget _noPlayDemo() {
    return RiveAnimation.asset(
      "assets/animations/maindemo_nologo_textonly.riv",
      controllers: [this._stopContoller],
    );
  } // end of method
} // end of class
