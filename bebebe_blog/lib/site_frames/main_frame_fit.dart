/// -------------------------------------------
///    main_frameのサイズ調整機能
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import './main_frame.dart';

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
} // end of class
