/// -------------------------------------------
///    ポートフォリオ一覧を出せるように頑張る
/// -------------------------------------------

import 'package:flutter/material.dart';

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
    return Container(
      constraints: BoxConstraints(minHeight: this.mainContentHeight),
      color: Colors.lightBlue,
    );
  } // end of method
} // end of class


