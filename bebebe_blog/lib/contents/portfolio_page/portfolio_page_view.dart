/// -------------------------------------------
///    ポートフォリオ一覧を出せるように頑張る
/// -------------------------------------------

import 'package:bebebe_blog/contents/profile_page/skilset_list.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PortfolioPageWidget extends StatefulWidget {
  const PortfolioPageWidget({Key? key, required double this.topbarHeight}) : super(key: key);

  /// トップバーの高さは毎回与えられる
  final double topbarHeight;

  @override
  State<PortfolioPageWidget> createState() => PortfolioPageView();
} // end of class

class PortfolioPageView extends State<PortfolioPageWidget> {
  @override
  void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayHeight = MediaQuery.of(context).size.height;
    double contentHeight = displayHeight - widget.topbarHeight;
    return Container(
      constraints: BoxConstraints(minHeight: contentHeight),
      color: Colors.lightBlue,
    );
  } // end of method
} // end of class


