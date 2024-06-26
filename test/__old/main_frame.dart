import 'package:flutter/material.dart';

/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import 'topbar.dart';
import 'topbar_hover_text.dart';

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

  // トップバーの高さ
  double topbarHeight = 60;

  // スクロールバーのコントローラー
  ScrollController mainContentScrollController = ScrollController();

  /// トップバーのDrawerを取得するためのキー
  GlobalKey<TopbarView>? drawerKey;

  // /// トップバーくん
  // late Topbar topbar;

  /// Scaffoldのキーを作ってDrawerのON/OFFを切り替える
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// constructor (初期の大きさを保存しておく)
  MainFrameView() {}

  @override
  void initState() {}

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

    // トップバーを作ってキーを取得する
    return Title(
      color: Colors.black,
      title: widget.title,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // ScaffoldのDrawerの起動をtopbarからできるように
          key: this._scaffoldKey,
          // トップバーくん
          appBar: Topbar(height: this.topbarHeight, scaffoldKey: this._scaffoldKey),
          // トップバーが作ってくれたDrawerをキーから取得する
          drawer: this._createDrawerMenu(),
          // メインボディ
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
            child: widget.page),
      ),
    );
  } // end of method

  /// Drawerメニュー作成
  Drawer _createDrawerMenu() {
    // アクセス一覧
    List<Widget> access = [
      // this._createDrawerText("トップ", 15, "/", textAlignment: Alignment.centerLeft),
      // this._createDrawerText("ポートフォリオ", 15, "/github", textAlignment: Alignment.centerLeft),
      HyperLinkText(text: "トップ", fontSize: 15, route: "/top", textAlignment: Alignment.center),
      HyperLinkText(text: "ポートフォリオ", fontSize: 15, route: "/github", textAlignment: Alignment.center),
    ];

    return Drawer(
        child: ListView(
      children: access,
    ));
  } // end of method

  /// DrawerにHyperLinkText
  Widget _createDrawerText(String text, double fontSize, String route, {Alignment textAlignment = Alignment.center}) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: HyperLinkText(
          text: text,
          fontSize: fontSize,
          route: route,
          textAlignment: textAlignment,
        ));
  } // end of method
} // end of class
