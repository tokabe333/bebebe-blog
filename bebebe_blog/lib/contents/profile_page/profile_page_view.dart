/// -------------------------------------------
///         自己紹介とスキルセットとか
/// -------------------------------------------

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
    double contentWidth = math.min(displayWidth * 0.95, 700);

    return Container(
      color: Color.fromARGB(255, 244, 255, 237),
      height: contentHeight,
      child: Column(
        children: [
          SizedBox(height: 60),
          this.createIntroduce(context, contentWidth),
          Center(
            child: SkilsetBadge(
              text: "Github",
              fontSize: 20,
              hyperLink: "https://github.com/tokabe333",
              borderColor: Color.fromARGB(255, 0, 112, 19),
              hoverBackgroundColor: Color.fromARGB(255, 159, 203, 166),
            ),
          ),
        ],
      ),
    );
  }
} // end of class


