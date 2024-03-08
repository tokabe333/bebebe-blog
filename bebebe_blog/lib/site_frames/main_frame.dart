/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import './topbar/topbar.dart';
import './main_frame_drawer.dart';
import './main_frame_fit.dart';

import '../contents/main_page/main_page_view.dart';
import '../contents/profile_page/profile_page_view.dart';

/// Webサイトの構成を決めるフレーム
/// 各ページはこれに自身を渡すことで画面を表示する
class MainFrame extends StatefulWidget {
  MainFrame({Key? key, String this.title = "beyan's page", required double this.topbarHeight}) : super(key: key);

  // タブに表示されるタイトル
  String title;

  /// トップバーの高さ
  double topbarHeight;

  State<MainFrame> createState() => MainFrameView(topbarHeight);
} // end of class

/// 実際に表示を記述する
class MainFrameView extends State<MainFrame> {
  /// 利用する領域 % (左右はパディング)
  double mainContentWidthRatio = 1.0;

  /// 実際のメインコンテンツの大きさ
  double mainContentWidth = 0;

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

  /// Scaffoldのキーを作ってDrawerのON/OFFを切り替える
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// このWebサイトのコンテンツ一覧(ページ一覧)
  late List<Widget> mainContents;

  /// constructor 各ページを初期化していく
  MainFrameView(double this.topbarHeight) {}

  @override
  void initState() {
    this.mainContents = [
      MainPageWidget(topbarHeight: this.topbarHeight),
      ProfilePageWidget(topbarHeight: this.topbarHeight),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 画面が更新されるタイミングで横幅も調整
    this.updateSize();

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
          // トップバーがボディを透過するように
          extendBodyBehindAppBar: true,
          // トップバーが作ってくれたDrawerをキーから取得する
          drawer: this.createDrawerMenu(),
          // メインボディ
          // body: this.createAutoFillBody(this.mainContents[0]),
          body: this._createScrollableMainContent(context, this.mainContents),

          // bottomNavigationBar: this._createBottomIconBar(),
        ),
      ),
    );
  } // end of build

  /// スクロールバー付きでメインコンテンツを並べていく
  Widget _createScrollableMainContent(BuildContext context, List<Widget> pages) {
    // 1ページあたりの高さ
    double mainContentHeight = MediaQuery.of(context).size.height - this.topbarHeight;
    return Scrollbar(
      controller: this.mainContentScrollController,
      thumbVisibility: true,
      // child: SingleChildScrollView(
      //   controller: this.mainContentScrollController,
      child: SizedBox(
        height: mainContentHeight * pages.length,
        child: ListView(
          controller: this.mainContentScrollController,
          children: pages,
        ),
      ),
      // ),
    );
  } // end of main
} // end of class
