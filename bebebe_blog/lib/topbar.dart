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

/// 画面上部に表示するバー
class Topbar extends StatelessWidget implements PreferredSizeWidget {
  /// タブバーのheight default=50px
  double height;

  /// 利用する領域 % (左右はパディング)
  double mainContentWidthRatio = 0.6;

  /// 最小のメインコンテンツサイズ
  double minMainContentWidth = 300;

  /// 実際のメインコンテンツの大きさ
  double mainContentWidth = 300;

  // 現在の画面サイズ
  double displayWidth = 0;

  // 画面サイズに応じてパディングサイズを決める
  double paddingWidth = 0;

  /// 画面上部への余白
  double padding_top = 20;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("images/fox_logo_alpha.png");

  /// Constructor
  Topbar({double this.height = 70}) {} // end of constructor

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(this.height + this.padding_top);

  /// 画面上部のタブバーを作成する
  void _createTopTabs(BuildContext context) {
    // this.tabs.add(this._createTabContainerInside(context, "home", fontSize: 20, route: "/home"));
    // this.tabs.add(this._createTabContainer("twitter", fontSize: 20, hyperLink: "https://twitter.com/home"));
    // this.tabs.add(this._createTabContainer("youtube",
    //     fontSize: 20, hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w"));
    // this.tabs.add(this._createTabContainer("qiita", fontSize: 20, hyperLink: "https://qiita.com/tokabe333"));
    // this.tabs.add(this._createTabContainer("atcoder", fontSize: 20, hyperLink: "https://atcoder.jp/users/tokabe333"));
    this.tabs.add(this._createTabContainer("github", fontSize: 20, hyperLink: "https://github.com/tokabe333"));
    // this.tabs.add(this._createTabContainerInside(context, "github", fontSize: 20, route: "/github"));
    // this.tabs.add(this._createTabContainerInside(context, "contact", fontSize: 20, route: "/contact"));
    this.tabs.add(this._createBottomIcon(path: "images/twitter_blue.png", hyperLink: "https://twitter.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(
        path: "images/youtube_red.png", hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w"));
    this.tabs.add(this._createBottomIcon(path: "images/qiita.png", hyperLink: "https://qiita.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(path: "images/github.png", hyperLink: "https://github.com/tokabe333/"));
    this.tabs.add(this._createBottomIcon(path: "images/atcoder.png", hyperLink: "https://atcoder.jp/users/tokabe333"));
  }

  @override
  Widget build(BuildContext context) {
    // 画面上部のバーを作成する
    this._createTopTabs(context);

    // // 画面が更新されるタイミングで横幅も調整
    // this.displayWidth = MediaQuery.of(context).size.width;
    // this.mainContentWidth = this.displayWidth * this.mainContentWidthRatio;
    // this.mainContentWidth = math.max(this.mainContentWidth, this.minMainContentWidth);

    // this.paddingWidth = (this.displayWidth - this.mainContentWidth) / 2;

    // if (this.paddingWidth < 0) {
    //   this.mainContentWidth = this.displayWidth;
    //   this.paddingWidth = 0;
    // } else {
    //   this.mainContentWidth = this.displayWidth * this.mainContentWidth;
    // }
    // 画面サイズはいじらない

    // トップバーの配置
    return Container(
        width: this.mainContentWidth,
        margin: EdgeInsets.only(top: 20, bottom: 20, left: paddingWidth, right: paddingWidth),
        // color: const Color.fromARGB(255, 184, 184, 184),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // アイコン
            Container(margin: EdgeInsets.only(left: 40), child: this.iconImage),
            // サイトタイトル
            Container(
                margin: EdgeInsets.only(left: 20), child: this._createTextDancingScript("Beyan's Site", fontSize: 25)),
            // 右上タブ
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: this.tabs,
              ),
            )),
          ],
        ));
  } // end of build

  // GoogleFontsのdancingScriptで作ったtextを返す
  Widget _createTextDancingScript(String text, {double fontSize = 15}) {
    return Text(text,
        // style: GoogleFonts.getFont("Leckerli One",
        //     textStyle: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: fontSize)));
        style: TextStyle(fontFamily: "noto", color: Colors.black, letterSpacing: 0.5, fontSize: fontSize));
  } // end of method

  // 右上タブに表示するテキストを作成
  Widget _createTabContainer(String text, {double fontSize = 15, String hyperLink = "", bool currentTab = false}) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        child: InkWell(
            child: this._createTextDancingScript(
              text,
              fontSize: fontSize,
            ),
            onTap: () {
              html.window.open(hyperLink, "_blank");
            }));
  } // end of method

  /// サイト内で遷移する際のタブテキストを作成
  Widget _createTabContainerInside(BuildContext context, String text,
      {double fontSize = 15, String route = "", bool currentTab = false}) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        child: InkWell(
            child: this._createTextDancingScript(
              text,
              fontSize: fontSize,
            ),
            onTap: () {
              // 別のページなら遷移する(現在のページには遷移しない)
              if (context.vRouter.path != route) {
                context.vRouter.to(route);
              }
            }));
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
