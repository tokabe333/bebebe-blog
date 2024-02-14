import 'package:flutter/material.dart';

/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';

import 'topbar.dart';

/// Webサイトの構成を決めるフレーム
/// 各ページはこれに自身を渡すことで画面を表示する
class MainFrame extends StatefulWidget {
  MainFrame({Key? key, required Widget this.page}) : super(key: key);

  /// 各種表示したいページ
  /// これを引数で受け取って右側に表示する
  Widget page;

  State<MainFrame> createState() => MainFrameView();
} // end of class

/// 実際に表示を記述する
class MainFrameView extends State<MainFrame> {
  /// 想定する画面サイズ
  double display_width = 1980;

  /// 利用する領域(左右はパディング)
  double main_contet_width = 900;

  /// 画面左部のバーの横幅
  double sidebar_width = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(),
      body: widget.page,
    );
  }
} // end of class