import 'package:flutter/material.dart';

/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'topbar.dart';

/// Webサイトの構成を決めるフレーム
/// 各ページはこれに自身を渡すことで画面を表示する
class MainFrame extends StatefulWidget {
  MainFrame({Key? key, String this.title = "beyan's page", required Widget this.page}) : super(key: key);

  /// 各種表示したいページ
  /// これを引数で受け取って右側に表示する
  Widget page;

  // タブに表示されるタイトル
  String title;

  State<MainFrame> createState() => MainFrameView();
} // end of class

/// 実際に表示を記述する
class MainFrameView extends State<MainFrame> {
  /// 利用する領域 % (左右はパディング)
  double mainContentWidthRatio = 1.0;

  /// 実際のメインコンテンツの大きさ
  static double mainContentWidth = 0;

  // 現在の画面サイズ
  double displayWidth = 0;

  // 画面サイズに応じてパディングサイズを決める
  double paddingWidth = 0;

  // スクロールバーのコントローラー
  ScrollController mainContentScrollController = ScrollController();

  /// constructor (初期の大きさを保存しておく)
  MainFrameView() {}

  @override
  Widget build(BuildContext context) {
    // 画面が更新されるタイミングで横幅も調整
    this.displayWidth = MediaQuery.of(context).size.width;
    mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    this.paddingWidth = (this.displayWidth - mainContentWidth) / 2;

    if (this.paddingWidth < 0) {
      mainContentWidth = this.displayWidth;
      this.paddingWidth = 0;
    } else {
      mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    }

    return Title(
      color: Colors.black,
      title: widget.title,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          appBar: Topbar(height: 60),
          body: this._createAutoFillBody(),
          // bottomNavigationBar: this._createBottomIconBar(),
        ),
      ),
    );
  } // end of build

  /// 画面サイズに応じて自動的にパディングをつくるボディー
  Widget _createAutoFillBody() {
    // メイン画面はスクロール可能なバーで
    return Scrollbar(
        controller: this.mainContentScrollController,
        child: SingleChildScrollView(
            controller: this.mainContentScrollController,
            child: Container(
                width: mainContentWidth,
                margin: EdgeInsets.only(left: this.paddingWidth, right: this.paddingWidth),
                child: widget.page)));
  } // end of method

  Widget _createBottomIconBar() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5),
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this._createBottomIcon(path: "images/twitter_blue.png", hyperLink: "https://twitter.com/tokabe333"),
          this._createBottomIcon(
              path: "images/youtube_red.png", hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w"),
          this._createBottomIcon(path: "images/qiita.png", hyperLink: "https://qiita.com/tokabe333"),
          this._createBottomIcon(path: "images/github.png", hyperLink: "https://github.com/tokabe333/"),
          this._createBottomIcon(path: "images/atcoder.png", hyperLink: "https://atcoder.jp/users/tokabe333"),
        ],
      ),
    );
  } // end of method

  Widget _createBottomIcon({required String path, String hyperLink = ""}) {
    return Container(
        height: 20,
        width: 20,
        margin: EdgeInsets.only(left: 7, right: 7),
        child: InkWell(
          child: Image.asset(path),
          onTap: () async {
            final url = Uri.parse(hyperLink);
            if (await canLaunchUrl(url)) {
              launchUrl(url);
            }
          },
        ));
  } // end of method
} // end of class
