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
  double width;

  /// 画面上部への余白
  double padding_top = 20;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [
    Container(width: 50, color: Color.fromARGB(255, 167, 159, 159))
  ];

  /// 画面左上に表示するアイコン画像
  Widget iconImage = Image.asset("assets/fox_logo_alpha.png");

  /// Constructor
  Topbar({double this.height = 70, double this.width = 700}) {}

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(this.height + this.padding_top);

  @override
  Widget build(BuildContext context) {
    double display_width = MediaQuery.of(context).size.width;
    double padding_width = (display_width - this.width) / 2;

    return Container(
        padding: EdgeInsets.only(left: padding_width, right: padding_width),
        margin: EdgeInsets.only(top: this.padding_top),
        color: const Color.fromARGB(255, 184, 184, 184),
        child: Row(
          children: [
            this.iconImage!,
            Row(children: this.tabs),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  } // end of build
} // end of class