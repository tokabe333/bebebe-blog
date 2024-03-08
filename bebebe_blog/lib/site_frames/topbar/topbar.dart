/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:math' as math;
import 'package:vrouter/vrouter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../contents/main_page/main_page_view.dart';
import './topbar_hover_text.dart';

class Topbar extends StatefulWidget implements PreferredSizeWidget {
  Topbar({Key? key, required double this.height, required GlobalKey<ScaffoldState> this.scaffoldKey}) : super(key: key);

  double height = 0;

  GlobalKey<ScaffoldState> scaffoldKey;

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(height);

  State<Topbar> createState() => TopbarView(height: height, scaffoldKey: scaffoldKey);
} // end of class

/// 画面上部に表示するバー
class TopbarView extends State<Topbar> {
  /// タブバーのheight default=50px
  double height;

  /// メインコンテンツサイズ
  double topbarContentWidth = 600;

  // ハンバーガーメニューを置く場所(左から何割の場所か)
  double hamburgerButtonPlace = 0.1;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("images/fox_logo_alpha.png", fit: BoxFit.contain);

  /// 現在のScaffold状態を確認するKey
  GlobalKey<ScaffoldState>? scaffoldKey;

  /// main_frameからDrawerを呼び出すためのkey
  final GlobalKey<TopbarView> _topbarViewKey = GlobalKey<TopbarView>();

  /// Constructor
  TopbarView({
    double this.height = 0,
    GlobalKey<ScaffoldState>? this.scaffoldKey,
  }) {} // end of constructor

  /// 画面上部のタブバーを作成する
  void _createTopTabs(BuildContext context) {
    this.tabs.add(HyperLinkText(text: "トップ", fontSize: 15, route: "/top"));
    this.tabs.add(HyperLinkText(text: "ポートフォリオ", fontSize: 15, route: "/github"));
    this.tabs.add(SizedBox(width: 20));
    this.tabs.add(this._createBottomIcon(path: "images/twitter_blue.png", hyperLink: "https://twitter.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(
        path: "images/youtube_red.png", hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w"));
    this.tabs.add(this._createBottomIcon(path: "images/qiita.png", hyperLink: "https://qiita.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(path: "images/github.png", hyperLink: "https://github.com/tokabe333/"));
    this.tabs.add(this._createBottomIcon(path: "images/atcoder.png", hyperLink: "https://atcoder.jp/users/tokabe333"));
  }

  @override
  void initState() {
    // 画面上部のバーを作成する
    this._createTopTabs(context);

    this.scaffoldKey?.currentState?.openDrawer();
    print("scaffold key : ${this.scaffoldKey}");
    print("current state : ${this.scaffoldKey?.currentState}");
  }

  @override
  Widget build(BuildContext context) {
    // 左右のパディング
    double displayWidth = MediaQuery.of(context).size.width;
    double padding = (displayWidth - this.topbarContentWidth) / 2;

    if (padding >= 0) {
      return this._createDefaultTopbar(displayWidth, padding);
    } else {
      return this._createDrawerTopBar(context);
    }
  } // end of build

  /// 大きさが足りているときは横長のバー
  Widget _createDefaultTopbar(double displayWidth, double padding) {
    // トップバーの配置
    return Container(
      width: displayWidth,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: padding, right: padding),
      // color: const Color.fromARGB(255, 184, 184, 184),
      color: Colors.white.withOpacity(0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // アイコン
          InkWell(
            onTap: () => this.scaffoldKey?.currentState?.openDrawer(),
            child: Container(height: this.height, margin: EdgeInsets.only(left: 40), child: this.iconImage),
          ),

          // 右上タブ
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this.tabs,
              ),
            ),
          ),
        ],
      ),
    );
  } // end of method

  /// スマホなど幅が小さい画面のときに表示するバー
  Widget _createDrawerTopBar(BuildContext context) {
    // 横幅を計算
    double displayWidth = MediaQuery.of(context).size.width;
    double paddingLeft = displayWidth * this.hamburgerButtonPlace;

    // Drawerを起動するハンバーガーボタン
    Widget hamburgerButton = SizedBox(
      width: this.height * 0.7,
      height: this.height * 0.7,
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.9),
        child: InkWell(
          onTap: () {
            this.scaffoldKey?.currentState?.openDrawer();
          },
          child: Icon(
            Icons.dehaze_rounded,
            color: Color.fromARGB(185, 11, 127, 223),
          ),
        ),
      ),
    );

    // return Padding(padding:EdgeInsets.only(left: paddingLeft), child:Drawer)
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            SizedBox(width: paddingLeft),
            Flexible(child: hamburgerButton),
          ],
        )),
        // アイコン
        InkWell(
          onTap: () => this.scaffoldKey?.currentState?.openDrawer(),
          child: Container(height: this.height, child: this.iconImage),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  /// 外部リンクへのアイコンを作る(BottomではなくTop)
  Widget _createBottomIcon({required String path, String hyperLink = ""}) {
    return Container(
        height: 50,
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
