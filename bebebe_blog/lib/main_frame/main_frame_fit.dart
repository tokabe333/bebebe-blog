/// -------------------------------------------
///    main_frameのサイズ調整機能
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import 'main_frame.dart';

/// 画面サイズ調整機能群
extension MainFrameFit on MainFrameView {
  void updateSize() {
    // 画面が更新されるタイミングで横幅も調整
    this.displayWidth = MediaQuery.of(context).size.width;
    this.mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    this.paddingWidth = (this.displayWidth - this.mainContentWidth) / 2;

    if (this.paddingWidth < 0) {
      this.mainContentWidth = this.displayWidth;
      this.paddingWidth = 0;
    } else {
      this.mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    }
  }

  /// 画面サイズに応じて自動的にパディングをつくるボディー
  Widget createAutoFillBody(Widget page) {
    // メイン画面はスクロール可能なバーで
    return Scrollbar(
      controller: this.mainContentScrollController,
      child: SingleChildScrollView(
        controller: this.mainContentScrollController,
        child: Container(
            width: mainContentWidth,
            margin: EdgeInsets.only(left: this.paddingWidth, right: this.paddingWidth),
            child: page),
      ),
    );
  } // end of method
} // end of class
