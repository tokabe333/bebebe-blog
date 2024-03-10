/// -------------------------------------------
///       自己紹介とスキルセットとか(スマホ版)
/// -------------------------------------------

import 'package:bebebe_blog/contents/profile_page/skilset_list.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';
import './profile_introduce.dart';

extension ProfilePageViewSmartPhone on ProfilePageView {
  /// メインコンテンツ(デモとサイト紹介)を作成
  Widget createSmartPhonePage(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayHeight = MediaQuery.of(context).size.height;
    double contentHeight = displayHeight - widget.topbarHeight;
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.9;

    // パディングは画面サイズ依存で
    double paddingTop = contentHeight * 0.1;
    double paddingMiddle = contentHeight * 0.05;

    // バッジの大きさは紹介Containerに収まるサイズ
    double badgeWidth = contentWidth / 4.5;
    double badgeFontSize = 20;
    if (badgeWidth < 100) badgeFontSize = 15;
    if (badgeWidth < 80) badgeFontSize = 13;

    return Container(
      constraints: BoxConstraints(minHeight: contentHeight),
      color: Color.fromARGB(255, 249, 255, 246),
      // height: contentHeight,
      child: Column(
        children: [
          SizedBox(height: paddingTop),
          this.createIntroduceSmartphone(context, contentWidth),
          SizedBox(height: paddingMiddle),
          this.createSkilsetList(context, contentWidth, badgeWidth, badgeFontSize),
        ],
      ),
    );
  } // end of method
} // end of class


