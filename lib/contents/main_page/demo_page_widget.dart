// -------------------------------------------
//        一番最初の画面で表示するでも
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DemoPageWidget extends StatelessWidget {
  /// デモ再生用コントローラー
  final RiveAnimationController _controller = SimpleAnimation("demo2");

  /// デモページは最初に作っておく
  late final Widget _demoPage;

  DemoPageWidget({Key? key}) : super(key: key) {
    this._demoPage = RiveAnimation.asset(
      "assets/animations/maindemo.riv",
      controllers: [this._controller],
    );
  }

  @override
  Widget build(BuildContext context) {
    return this._demoPage;
  }
} // end of class

class NoDemoPageWidget extends StatelessWidget {
  /// デモ再生用コントローラー
  final RiveAnimationController _controller = OneShotAnimation("text2");

  /// デモページは最初に作っておく
  late final Widget _demoPage;

  NoDemoPageWidget({Key? key}) : super(key: key) {
    this._demoPage = RiveAnimation.asset(
      // "assets/animations/maindemo_nologo_textonly.riv",
      "assets/animations/maindemo.riv",
      controllers: [this._controller],
    );
  }

  @override
  Widget build(BuildContext context) {
    return this._demoPage;
  }
} // end of class
