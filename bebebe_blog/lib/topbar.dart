/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 画面上部に表示するバー
class Topbar extends StatelessWidget implements PreferredSizeWidget {
  /// タブバーのheight default=50px
  double height;

  /// タブバーのwidth default=700px
  double contentWidth;

  /// デフォルトの横幅を記憶しておく
  double _contentWidth = 0;

  /// 画面上部への余白
  double padding_top = 20;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("images/fox_logo_alpha.png");

  /// Constructor
  Topbar({double this.height = 70, double this.contentWidth = 700}) {
    this._contentWidth = this.contentWidth;

    this.tabs.add(this._createTabContainer("home", fontSize: 20));
    this.tabs.add(this._createTabContainer("qiita", fontSize: 20));
  } // end of constructor

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(this.height + this.padding_top);

  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じたコンテンツサイズ変更
    double displayWidth = MediaQuery.of(context).size.width;
    double paddingWidth = (displayWidth - this.contentWidth) / 2;
    if (paddingWidth < 0) {
      paddingWidth = 0;
      this.contentWidth = displayWidth;
    } else {
      this.contentWidth = this._contentWidth;
    }

    return Container(
        width: this.contentWidth,
        margin:
            EdgeInsets.only(top: 20, left: paddingWidth, right: paddingWidth),
        // color: const Color.fromARGB(255, 184, 184, 184),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.only(left: 20), child: this.iconImage),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: this
                    ._createTextDancingScript("Beyan's Site", fontSize: 20)),
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
            textStyle: TextStyle(
                color: Colors.black, letterSpacing: 0.5, fontSize: fontSize)));
  } // end of method

  Widget _createTextAiharaFont(String text, {double fontSize = 15}) {
    return Text(
      text,
      style: TextStyle(fontFamily: "Otsutome", fontSize: fontSize),
    );
  }

  Widget _createTabContainer(String text, {double fontSize = 15}) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 10),
        child: this._createTextDancingScript(
          text,
          fontSize: fontSize,
        ));
  }
} // end of class
