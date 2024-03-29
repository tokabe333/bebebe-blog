// -------------------------------------------
//       自己紹介とスキルセットとか(スマホ版)
// -------------------------------------------

import 'package:flutter/material.dart';

import './profile_page_view.dart';
import './skilset_list.dart';
import './profile_introduce.dart';
import './skilset_text.dart';
import '../../site_frames/background_image.dart';

extension ProfilePageViewSmartPhone on ProfilePageView {
  /// メインコンテンツ(デモとサイト紹介)を作成
  Widget createSmartPhonePage(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.9;

    // パディングは画面サイズ依存で
    double paddingTop = widget.mainContentHeight * 0.1;
    double paddingMiddle = widget.mainContentHeight * 0.05;

    // バッジの大きさは紹介Containerに収まるサイズ
    double badgeWidth = contentWidth / 4.5;
    double badgeFontSize = 20;
    if (badgeWidth < 100) badgeFontSize = 15;
    if (badgeWidth < 80) badgeFontSize = 13;

    return Container(
      key: this.profilePageKeySmartphone,
      constraints: BoxConstraints(minHeight: widget.mainContentHeight),
      color: const Color.fromARGB(255, 249, 255, 246),
      // height: contentHeight,
      child: Stack(
        children: [
          // 背景画像を繰り返す
          BackgroundImageWidget(
            imagePath: "assets/images/background/introduction.webp",
            imageHeight: 315,
            imageWidth: 315,
            parentWidgetKey: this.profilePageKeySmartphone,
          ),
          Column(
            children: [
              SizedBox(height: paddingTop),
              Center(child: this.createIntroduceSmartphone(context, contentWidth)),
              SizedBox(height: paddingMiddle / 2),
              Center(child: this.createSkilsetText(context, contentWidth, FontWeight.w500)),
              SizedBox(height: paddingMiddle),
              this.createSkilsetList(context, contentWidth, badgeWidth, badgeFontSize),
            ],
          ),
        ],
      ),
    );
  } // end of method
} // end of class


