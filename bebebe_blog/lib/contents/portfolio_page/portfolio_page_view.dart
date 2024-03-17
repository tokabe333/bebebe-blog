// -------------------------------------------
//    ポートフォリオ一覧を出せるように頑張る
// -------------------------------------------

import 'package:flutter/material.dart';
import 'dart:math' as math;

import './portfolio_content_view.dart';
import './dialog_beyan-connect.dart';

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
    double contentWidth = math.max(displayWidth * 0.4, 400);
    double contentHeight = contentWidth / 3.0 * 2;

    print("portfolio build width:${displayWidth}");

    return Container(
      constraints: BoxConstraints(minHeight: this.mainContentHeight),
      color: const Color.fromARGB(255, 222, 250, 243),
      alignment: Alignment.center,
      child: Wrap(
        spacing: contentWidth * 0.05,
        runSpacing: contentWidth * 0.05,
        children: [
          PortFolioContentWidget(
            containerHeight: contentHeight,
            containerWidth: contentWidth,
            imagePath: "assets/images/portfolio/beyan-connect.png",
            caption: "beyan-connect.net",
            dialogWidget: const BeyanConnectDialogWidget(),
          ),
          PortFolioContentWidget(
            containerHeight: contentHeight,
            containerWidth: contentWidth,
            imagePath: "assets/images/portfolio/beyan-connect.png",
            caption: "beyan-connect.net",
            dialogWidget: const BeyanConnectDialogWidget(),
          )
        ],
      ),
    );
  } // end of method
} // end of class


