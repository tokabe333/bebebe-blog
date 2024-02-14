import 'package:flutter/material.dart';

/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';

import './sidebar.dart';

class MainFrame extends StatefulWidget {
  MainFrame({Key? key, required Widget this.page}) : super(key: key);
  Widget page;

  State<MainFrame> createState() => MainFrameView();
}

class MainFrameView extends State<MainFrame> {
  /// 想定する画面サイズ
  double display_width = 1980;

  /// 画面左部のバーの横幅
  double sidebar_width = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Container(
                width: this.sidebar_width,
                child: Container(width: double.infinity, child: SideBar())),
            Container(
                width: MediaQuery.of(context).size.width - this.sidebar_width,
                child: widget.page),
          ],
        ));
  }
} // end of class