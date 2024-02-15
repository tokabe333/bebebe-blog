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
  /// 利用する領域 % (左右はパディング)
  double mainContentWidthRatio = 0.95;

  /// 実際のメインコンテンツの大きさ
  double mainContentWidth = 0;

  // 現在の画面サイズ
  double displayWidth = 0;

  // 画面サイズに応じてパディングサイズを決める
  double paddingWidth = 0;

  /// constructor (初期の大きさを保存しておく)
  MainFrameView() {}

  @override
  Widget build(BuildContext context) {
    // 画面が更新されるタイミングで横幅も調整
    this.displayWidth = MediaQuery.of(context).size.width;
    this.mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    this.paddingWidth = (this.displayWidth - this.mainContentWidth) / 2;

    if (this.paddingWidth < 0) {
      this.mainContentWidth = this.displayWidth;
      this.paddingWidth = 0;
    } else {
      this.mainContentWidth = this.displayWidth * this.mainContentWidth;
    }

    return Scaffold(
        appBar: Topbar(height: 70),
        body: this._createAutoFillBody(),
        bottomNavigationBar: this._createBottomIconBar());
  } // end of build

  /// 画面サイズに応じて自動的にパディングをつくるボディー
  Widget _createAutoFillBody() {
    // メイン画面はスクロール可能なバーで
    return Scrollbar(
        child: SingleChildScrollView(
            child: Container(
                width: mainContentWidth,
                margin: EdgeInsets.only(
                    left: this.paddingWidth, right: this.paddingWidth),
                child: widget.page)));
  } // end of method

  Widget _createBottomIconBar() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5),
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this._createBottomIcon(path: "images/twitter.png"),
          this._createBottomIcon(path: "images/youtube.png"),
          this._createBottomIcon(path: "images/qiita_gray.png"),
        ],
      ),
    );
  } // end of method

  Widget _createBottomIcon({required String path, String hyperLink = ""}) {
    return Container(
        height: 20,
        width: 20,
        margin: EdgeInsets.only(left: 7, right: 7),
        child: Image.asset(path));
  } // end of method
} // end of class
