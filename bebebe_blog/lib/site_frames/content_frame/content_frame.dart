// -------------------------------------------
//          各ページを入れるWidet
// 縦のサイズを決めたり、クリックしてスクロールする指標
// -------------------------------------------

import 'package:flutter/material.dart';

/// 各ページを入れるフレーム
/// main_frameはbodyにcontent_frameを並べる
class ContentFrame extends StatefulWidget {
  const ContentFrame({
    Key? key,
    String this.title = "beyan's page",
    required double this.topbarHeight,
  }) : super(key: key);

  // タブに表示されるタイトル
  final String title;

  /// トップバーの高さ
  final double topbarHeight;

  @override
  State<ContentFrame> createState() => ContentFrameView();
} // end of class

/// 実際に表示を記述する
class ContentFrameView extends State<ContentFrame> {
  @override
  Widget build(BuildContext context) {
    return Container();
  } // end of build
} // end of class
