/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_page/main_page_view.dart';

/// 画面上部に表示するバー
class Topbar extends StatelessWidget implements PreferredSizeWidget {
  /// タブバーのheight default=50px
  double height;

  /// 利用する領域 % (左右はパディング)
  double mainContentWidthRatio = 0.95;

  /// 実際のメインコンテンツの大きさ
  double mainContentWidth = 0;

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
  Topbar({double this.height = 70}) {
    this.tabs.add(this._createTabContainerInside("home", fontSize: 20, hyperLink: "https://beyan-connect.net"));
    this.tabs.add(this._createTabContainerOutside("twitter", fontSize: 20));
    this.tabs.add(this._createTabContainerOutside("youtube", fontSize: 20));
    this.tabs.add(this._createTabContainerOutside("qiita", fontSize: 20));
    this.tabs.add(this._createTabContainerOutside("atcoder", fontSize: 20));
    this.tabs.add(this._createTabContainerOutside("github", fontSize: 20));
  } // end of constructor

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(this.height + this.padding_top);

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

    // トップバーの配置
    return Container(
        width: this.mainContentWidth,
        margin: EdgeInsets.only(top: 10, left: paddingWidth, right: paddingWidth),
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
        style: GoogleFonts.getFont("Leckerli One",
            textStyle: TextStyle(color: Colors.black, letterSpacing: 0.5, fontSize: fontSize)));
  } // end of method

  // 右上タブに表示するテキストを作成
  Widget _createTabContainerOutside(String text, {double fontSize = 15, String hyperLink = ""}) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        child: InkWell(
            child: this._createTextDancingScript(
              text,
              fontSize: fontSize,
            ),
            onTap: () {}));
  } // end of method

  Widget _createTabContainerInside(String text, {double fontSize = 15, String hyperLink = ""}) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        child: InkWell(
            child: this._createTextDancingScript(
              text,
              fontSize: fontSize,
            ),
            onTap: () {
              html.window.open(hyperLink, "");
            }));
  }
} // end of class
