/// -------------------------------------------
///         自己紹介とスキルセットとか
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';
import './skilset_list.dart';
import './profile_introduce.dart';
import './profile_page_smartphone.dart';
import '../../site_frames/background_image.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key, required double this.topbarHeight}) : super(key: key);

  /// トップバーの高さは毎回与えられる
  final double topbarHeight;

  @override
  State<ProfilePageWidget> createState() => ProfilePageView();
} // end of class

class ProfilePageView extends State<ProfilePageWidget> {
  @override
  void initState() {}

  /// このウィジェットの大きさを調べるためのキー
  GlobalKey profilePageKey = GlobalKey();

  /// このウィジェットの大きさを調べるためのキー(スマートフォンページ)
  GlobalKey profilePageKeySmartphone = GlobalKey();

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じて画面を切り替え
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    // 横幅で対応
    if (displayWidth < 640) {
      return this.createSmartPhonePage(context);
    } else {
      return this.createPcPage(context);
    }
  } // end of build

  Widget createPcPage(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayHeight = MediaQuery.of(context).size.height;
    double contentHeight = displayHeight - widget.topbarHeight;
    double displayWidth = MediaQuery.of(context).size.width;
    double defaultContentWidth = 700;
    double contentWidth = math.min(displayWidth * 0.9, defaultContentWidth);

    // パディングは画面サイズ依存で
    double paddingTop = contentHeight * 0.2;
    double paddingMiddle = math.max(30, contentHeight * 0.05);

    // バッジの大きさは紹介Containerに収まるサイズ
    double badgeWidth = contentWidth / 4.5;
    double badgeFontSize = 20;

    // メインのコンテンツ
    return Container(
      key: this.profilePageKey,
      constraints: BoxConstraints(minHeight: contentHeight),
      child: Stack(
        children: [
          // 背景画像を繰り返す
          BackgroundImageWidget(
            contentHeight: displayHeight,
            imagePath: "assets/images/background/introduction.webp",
            imageHeight: 315,
            imageWidth: 315,
            parentWidgetKey: this.profilePageKey,
          ),

          Column(
            children: [
              SizedBox(height: paddingTop),
              this.createIntroduce(context, contentWidth),
              SizedBox(height: paddingMiddle),
              this.createSkilsetList(context, contentWidth, badgeWidth, badgeFontSize),
            ],
          ),
        ],
      ),
    );
  } // end of method
} // end of class


