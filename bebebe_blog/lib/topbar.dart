/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';

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
  final List<Widget> tabs = [
    Container(width: 50, color: Color.fromARGB(255, 167, 159, 159))
  ];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("assets/fox_logo_alpha.png");

  /// Constructor
  Topbar({double this.height = 70, double this.contentWidth = 700}) {
    this._contentWidth = this.contentWidth;
  }

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(this.height + this.padding_top);

  @override
  Widget build(BuildContext context) {
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
        color: const Color.fromARGB(255, 184, 184, 184),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(margin: EdgeInsets.only(left: 20), child: this.iconImage),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(children: this.tabs)),
          ],
        ));
  } // end of build
} // end of class