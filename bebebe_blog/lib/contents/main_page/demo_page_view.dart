/// -------------------------------------------
///        一番最初の画面で表示するでも
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DemoPageWidget {
  /// デモ再生用コントローラー
  final RiveAnimationController _controller = SimpleAnimation("demo2");
  // RiveAnimationController _controller = OneShotAnimation("demo2");

  /// デモ終了後の表示用コントローラー
  final RiveAnimationController _stopContoller = OneShotAnimation("text2");

  /// デモページは最初に作っておく
  late final Widget _demoPage = this._playDemo();

  /// デモページは最初に作っておく
  late final Widget _noDemoPage = this._noPlayDemo();

  /// 色々あったけどmain_page側で大きさや配置をいじるのが一番だった
  Widget createDemoWidget(BuildContext context, bool isPlayDemo) {
    return isPlayDemo ? this._demoPage : this._noDemoPage;
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
