/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

import '../../site_frames/main_frame.dart';

class DemoPageWidget {
  // Riveアニメーション
  RiveAnimationController _controller = SimpleAnimation("demo2");

  RiveAnimationController _stopContoller = OneShotAnimation("text2");

  /// デモ再生する？
  bool isPlayDemo;

  /// デモファイル本体
  late Widget demo;

  DemoPageWidget(bool this.isPlayDemo) {
    this.demo = this.isPlayDemo ? _playDemo() : _noPlayDemo();
  }

  /// 色々あったけどmain_page側で大きさや配置をいじるのが一番だった
  Widget createDemoWidget(BuildContext context) {
    return demo;
  } // end of method

  /// デモを再生するだけ
  Widget _playDemo() {
    return RiveAnimation.asset(
      // "assets/animations/maindemo_nologo.riv",
      "assets/animations/maindemo.riv",
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
