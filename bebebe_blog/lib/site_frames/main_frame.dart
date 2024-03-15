/// -------------------------------------------
///         全部のページで共通する基本構造
///        これのchildに各ページを表示する
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:html' as html;

import './topbar/topbar.dart';
import './main_frame_drawer.dart';
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
  State<MainFrame> createState() => MainFrameView();
} // end of class

/// 実際に表示を記述する
class MainFrameView extends State<MainFrame> {
  /// トップバーのDrawerを取得するためのキー
  GlobalKey<TopbarView>? drawerKey;

  /// Scaffoldのキーを作ってDrawerのON/OFFを切り替える
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// このWebサイトのコンテンツ一覧(ページ一覧)
  late List<Widget> mainContents;

  /// デモを再生済みかどうか
  bool isFinishedDemo = false;

  /// 画面スクロール用コントローラ
  final ItemScrollController mainContentScrollController = ItemScrollController();

  /// 画面スクロール用、書くページのポジション取得
  final ItemPositionsListener mainContentScrollListener = ItemPositionsListener.create();

  /// constructor 各ページを初期化していく
  MainFrameView();

  @override
  void initState() {
    // デモは初回しか読み込まない
    Future.delayed(const Duration(milliseconds: 5500)).then((_) {
      print("finish");
      this.isFinishedDemo = true;
      setState(() {});
    });

    super.initState();
  } // end of constructor

  @override
  Widget build(BuildContext context) {
    // 1ページあたりの高さ
    double displayHeight = MediaQuery.of(context).size.height;
    double mainContentHeight = displayHeight - widget.topbarHeight;
    // ページリスト作成
    // デモ再生は初回のみなのでinitStateじゃなくてbuildで宣言して状態を変える
    this.mainContents = [
      SizedBox(height: displayHeight, child: MainPageWidget(mainContentHeight: displayHeight, isPlayDemo: !this.isFinishedDemo)),
      SizedBox(height: mainContentHeight, child: ProfilePageWidget(mainContentHeight: displayHeight)),
      SizedBox(height: mainContentHeight, child: PortfolioPageWidget(mainContentHeight: displayHeight)),
    ];
    // トップバーを作ってキーを取得する
    return Title(
      color: Colors.black,
      title: widget.title,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // ScaffoldのDrawerの起動をtopbarからできるように
          key: this._scaffoldKey,
          // トップバーくん
          appBar: Topbar(height: widget.topbarHeight, scaffoldKey: this._scaffoldKey, mainContentsScrollControler: this.mainContentScrollController),
          // トップバーがボディを透過するように
          extendBodyBehindAppBar: false,
          // トップバーが作ってくれたDrawerをキーから取得する
          drawer: this.createDrawerMenu(context),
          // メインボディ
          body: this._createScrollableMainContentWithJump(context, this.mainContents),
        ),
      ),
    );
  } // end of build

  /// スクロールバー付きでメインコンテンツを並べていく
  Widget _createScrollableMainContentWithJump(BuildContext context, List<Widget> pages) {
    return RefreshIndicator(
      onRefresh: () async {
        print("onRefresh!");
        html.window.location.reload();
      },
      child: ScrollablePositionedList.builder(
        itemCount: pages.length,
        itemScrollController: this.mainContentScrollController,
        itemPositionsListener: this.mainContentScrollListener,
        itemBuilder: (context, index) => pages[index],
      ),
    );
  } // end of method
} // end of class
