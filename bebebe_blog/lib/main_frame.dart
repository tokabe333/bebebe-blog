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
  double main_content_width = 1800;

  /// 初期の大きさを保存しておく
  double _main_content_width = 0;

  /// constructor (初期の大きさを保存しておく)
  MainFrameView() {
    this._main_content_width = this.main_content_width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Topbar(height: 70, contentWidth: this.main_content_width),
      body: this._createAutoFillBody(),
    );
  } // end of build

  /// 画面サイズに応じて自動的にパディングをつくるボディー
  Widget _createAutoFillBody() {
    double display_width = MediaQuery.of(context).size.width;
    double padding_width = (display_width - this.main_content_width) / 2;

    if (padding_width < 0) {
      this.main_content_width = display_width;
      padding_width = 0;
    } else {
      this.main_content_width = this._main_content_width;
    }

    return Container(
        width: this.main_content_width,
        margin: EdgeInsets.only(left: padding_width, right: padding_width),
        child: widget.page);
  } // end of  method
} // end of class
