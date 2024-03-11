/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import './topbar/topbar.dart';
import './main_frame_drawer.dart';
import './main_frame_fit.dart';

import '../contents/main_page/main_page_view.dart';
import '../contents/profile_page/profile_page_view.dart';
import '../contents/portfolio_page/portfolio_page_view.dart';

/// Webサイトの構成を決めるフレーム
/// 各ページはこれに自身を渡すことで画面を表示する
class MainFrame extends StatefulWidget {
  const MainFrame({Key? key, String this.title = "beyan's page", required double this.topbarHeight}) : super(key: key);

  // タブに表示されるタイトル
  final String title;

  /// トップバーの高さ
  final double topbarHeight;

  @override
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

  /// デモを再生済みかどうか
  bool isFinishedDemo = false;

  final ItemScrollController mainContentScrollControllerWithJump = ItemScrollController();

  final ItemPositionsListener mainContentScrollListener = ItemPositionsListener.create();

  @override
  void initState() {
    // デモは初回しか読み込まない
    Future.delayed(Duration(milliseconds: 5500)).then((_) {
      setState(() {
        this.isFinishedDemo = true;
      });
    });
  } // end of constructor

  @override
  Widget build(BuildContext context) {
    // ページリスト作成
    // デモ再生は初回のみなのでinitStateじゃなくてbuildで宣言して状態を変える
    this.mainContents = [
      MainPageWidget(topbarHeight: this.topbarHeight, isPlayDemo: !this.isFinishedDemo),
      ProfilePageWidget(topbarHeight: this.topbarHeight),
      PortfolioPageWidget(topbarHeight: topbarHeight),
    ];

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
          appBar: Topbar(
              height: this.topbarHeight,
              scaffoldKey: this._scaffoldKey,
              mainContentsScrollControler: this.mainContentScrollControllerWithJump),
          // トップバーがボディを透過するように
          extendBodyBehindAppBar: true,
          // トップバーが作ってくれたDrawerをキーから取得する
          drawer: this.createDrawerMenu(),
          // メインボディ
          // body: this._createScrollableMainContent(context, this.mainContents),
          body: this._createScrollableMainContentWithJump(context, this.mainContents),
        ),
      ),
    );
  } // end of build

  /// スクロールバー付きでメインコンテンツを並べていく
  Widget _createScrollableMainContent(BuildContext context, List<Widget> pages) {
    // 1ページあたりの高さ
    double mainContentHeight = MediaQuery.of(context).size.height - this.topbarHeight;
    return RefreshIndicator(
      onRefresh: () async {
        print("onRefresh!");
        html.window.location.reload();
      },
      child: Scrollbar(
        controller: this.mainContentScrollController,
        thumbVisibility: true,
        child: ListView(
          controller: this.mainContentScrollController,
          children: pages,
        ),
      ),
    );
  } // end of main

  Widget _createScrollableMainContentWithJump(BuildContext context, List<Widget> pages) {
    // 1ページあたりの高さ
    double mainContentHeight = MediaQuery.of(context).size.height;
    return ScrollablePositionedList.builder(
      itemCount: pages.length,
      itemScrollController: this.mainContentScrollControllerWithJump,
      itemPositionsListener: this.mainContentScrollListener,
      itemBuilder: (context, index) => SizedBox(height: mainContentHeight, child: pages[index]),
    );
  } // end of method
} // end of class
