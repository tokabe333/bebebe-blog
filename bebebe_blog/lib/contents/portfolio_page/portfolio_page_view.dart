// -------------------------------------------
//    ポートフォリオ一覧を出せるように頑張る
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import './portfolio_content_view.dart';
import './dialog_beyan-connect.dart';

class PortfolioPageWidget extends StatefulWidget {
  const PortfolioPageWidget({Key? key, required double this.mainContentHeight}) : super(key: key);

  /// トップバーの高さは毎回与えられる
  final double mainContentHeight;

  @override
  State<PortfolioPageWidget> createState() => PortfolioPageView();
} // end of class

class PortfolioPageView extends State<PortfolioPageWidget> {
  // @override
  // void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じてコンテンツのサイズ決定
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth;
    if (displayWidth < 640) {
      contentWidth = math.max(displayWidth * 0.8, 400);
    } else if (displayWidth < 1000) {
      contentWidth = displayWidth * 0.52;
    } else {
      contentWidth = displayWidth * 0.4;
    }
    double contentHeight = contentWidth / 3.0 * 2;

    return Container(
      constraints: BoxConstraints(minHeight: widget.mainContentHeight),
      color: const Color.fromARGB(255, 222, 250, 243),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(flex: 1),
          Text("Works", style: GoogleFonts.kosugiMaru(fontSize: 50, fontWeight: FontWeight.w600, letterSpacing: 1.5, color: const Color.fromARGB(255, 102, 102, 102))),
          const Spacer(flex: 1),
          Wrap(
            spacing: contentWidth * 0.05,
            runSpacing: contentWidth * 0.05,
            alignment: WrapAlignment.center,
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
          const Spacer(flex: 3),
        ],
      ),
    );
  } // end of method
} // end of class


