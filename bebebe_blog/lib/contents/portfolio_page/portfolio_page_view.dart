// -------------------------------------------
//    ポートフォリオ一覧を出せるように頑張る
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';

import './portfolio_content_view.dart';

class PortfolioPageWidget extends StatefulWidget {
  const PortfolioPageWidget({Key? key, required double this.mainContentHeight}) : super(key: key);

  /// トップバーの高さは毎回与えられる
  final double mainContentHeight;

  @override
  State<PortfolioPageWidget> createState() => PortfolioPageView(this.mainContentHeight);
} // end of class

class PortfolioPageView extends State<PortfolioPageWidget> {
  /// このコンテンツの高さ
  double mainContentHeight;

  PortfolioPageView(double this.mainContentHeight);

  // @override
  // void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じてコンテンツのサイズ決定
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.5;
    double contentHeight = contentWidth / 3.0 * 2;

    return Container(
      constraints: BoxConstraints(minHeight: this.mainContentHeight),
      color: Color.fromARGB(255, 222, 250, 243),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Wrap(
        children: [
          PortFolioContentWidget(
            containerHeight: contentHeight,
            containerWidth: contentWidth,
            imagePath: "assets/images/portfolio/beyan-connect.png",
            caption: "beyan-connect.net",
          )
        ],
      ),
    );
  } // end of method
} // end of class


