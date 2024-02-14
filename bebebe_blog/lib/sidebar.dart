/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';

/// 画面上部に表示するバー
class SideBar extends StatelessWidget {
  final List<Widget> tabs = [
    Container(width: 50, color: Color.fromARGB(255, 126, 126, 126))
  ];

  Widget? iconImage;

  /// 画面左上に表示する狐アイコンのheight
  double main_icon_height = 150;

  SideBar() {
    this.iconImage = Image.asset("assets/fox_logo.png");
  }

  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 184, 184, 184),
        child: Column(
          children: [
            this.iconImage!,
            Column(children: this.tabs),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ));
  } // end of build
} // end of class