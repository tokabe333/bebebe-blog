/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:math' as math;
// import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter/vrouter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_page/main_page_view.dart';
import 'topbar_hover_text.dart';

class Topbar extends StatefulWidget implements PreferredSizeWidget {
  Topbar({Key? key, required double this.height, required GlobalKey<ScaffoldState> this.scaffoldKey}) : super(key: key);

  double height = 0;

  GlobalKey<ScaffoldState> scaffoldKey;

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(height);

  State<Topbar> createState() => TopbarView(height: height, scaffoldKey: scaffoldKey);
}

/// 画面上部に表示するバー
class TopbarView extends State<Topbar> {
  /// タブバーのheight default=50px
  double height;

  /// メインコンテンツサイズ
  double topbarContentWidth = 600;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("images/fox_logo_alpha.png", fit: BoxFit.contain);

  /// 現在のScaffold状態を確認するKey
  GlobalKey<ScaffoldState>? scaffoldKey;

  /// Constructor
  TopbarView({
    double this.height = 60,
    GlobalKey<ScaffoldState>? this.scaffoldKey,
  }) {} // end of constructor

  /// 画面上部のタブバーを作成する
  void _createTopTabs(BuildContext context) {
    this.tabs.add(HyperLinkText(text: "トップ", fontSize: 15, route: "/top"));
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
    double padding = math.max(0, (displayWidth - this.topbarContentWidth) / 2);

    return this._createDefaultTopbar(displayWidth, padding);
  } // end of build

  /// 大きさが足りているときは横長のバー
  Widget _createDefaultTopbar(double displayWidth, double padding) {
    // トップバーの配置
    return Container(
      width: displayWidth,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: padding, right: padding),
      // color: const Color.fromARGB(255, 184, 184, 184),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // アイコン
          InkWell(
              onTap: () => this.scaffoldKey?.currentState?.openDrawer(),
              child: Container(height: this.height, margin: EdgeInsets.only(left: 40), child: this.iconImage)),
          // サイトタイトル
          // Container(
          //     margin: EdgeInsets.only(left: 20), child: this._createTextDancingScript("Beyan's Site", fontSize: 25)),
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
