/// -------------------------------------------
///         自己紹介とスキルセットとか
/// -------------------------------------------

import 'package:bebebe_blog/contents/profile_page/skilset_list.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';
import './profile_introduce.dart';

class ProfilePageWidget extends StatefulWidget {
  ProfilePageWidget({Key? key, required double this.topbarHeight}) : super(key: key);
  double topbarHeight;
  State<ProfilePageWidget> createState() => ProfilePageView();
} // end of class

class ProfilePageView extends State<ProfilePageWidget> {
  final GlobalKey profileKey = GlobalKey();
  @override
  void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayHeight = MediaQuery.of(context).size.height;
    double contentHeight = displayHeight - widget.topbarHeight;
    double displayWidth = MediaQuery.of(context).size.width;
    double defaultContentWidth = 700;
    double contentWidth = math.min(displayWidth * 0.9, defaultContentWidth);

    // 小さい画面のときは紹介文が上下にずれる、その時の横幅
    RenderObject? rendobj = this.profileKey.currentContext?.findRenderObject();
    RenderBox? render = rendobj == null ? null : rendobj as RenderBox;
    double listWidth = render == null ? contentWidth : render!.size.width;

    // パディングは画面サイズ依存で
    double paddingTop = contentHeight * 0.2;
    double paddingMiddle = math.max(30, contentHeight * 0.05);

    // バッジの大きさは紹介Containerに収まるサイズ
    double badgeWidth = listWidth / 4.5;
    double badgeFontSize = 20;
    if (badgeWidth < 100) badgeFontSize = 15;
    if (badgeWidth < 80) badgeFontSize = 13;
    print("badgeWidth:${badgeWidth} badgeFontsize:${badgeFontSize}");

    return Container(
      constraints: BoxConstraints(minHeight: contentHeight),
      color: Color.fromARGB(255, 249, 255, 246),
      // height: contentHeight,
      child: Column(
        children: [
          SizedBox(height: paddingTop),
          this.createIntroduce(context, contentWidth),
          SizedBox(height: paddingMiddle),
          this.createSkilsetList(context, listWidth, badgeWidth, badgeFontSize),
        ],
      ),
    );
  }
} // end of class


