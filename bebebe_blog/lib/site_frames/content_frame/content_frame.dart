/// -------------------------------------------
///          各ページを入れるWidet
/// 縦のサイズを決めたり、クリックしてスクロールする指標
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

/// 各ページを入れるフレーム
/// main_frameはbodyにcontent_frameを並べる
class ContentFrame extends StatefulWidget {
  ContentFrame({Key? key, String this.title = "beyan's page", required double this.topbarHeight}) : super(key: key);

  // タブに表示されるタイトル
  String title;

  /// トップバーの高さ
  double topbarHeight;

  State<ContentFrame> createState() => ContentFrameView();
} // end of class

/// 実際に表示を記述する
class ContentFrameView extends State<ContentFrame> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  } // end of build
} // end of class