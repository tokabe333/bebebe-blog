// -------------------------------------------
//    main_frameで使用するdrawerの実装
// -------------------------------------------

import 'package:flutter/material.dart';

import './topbar/topbar_hover_text.dart';
import './main_frame.dart';

/// 実際に表示を記述する
extension MainFrameDrawer on MainFrameView {
  /// Drawerメニュー作成
  Drawer createDrawerMenu(BuildContext context) {
    // アクセス一覧
    List<Widget> access = [
      InkWell(
        onTap: () => this.scrollOnTap(context, 0),
        child: HyperLinkText(
          text: "トップ",
          fontSize: 15,
          textAlignment: Alignment.center,
          onTap: () => this.scrollOnTap(context, 0),
        ),
      ),
      InkWell(
        onTap: () => this.scrollOnTap(context, 1),
        child: HyperLinkText(
          text: "プロフィール",
          fontSize: 15,
          textAlignment: Alignment.center,
          onTap: () => this.scrollOnTap(context, 1),
        ),
      ),
      InkWell(
        onTap: () => this.scrollOnTap(context, 2),
        child: HyperLinkText(
          text: "制作物",
          fontSize: 15,
          textAlignment: Alignment.center,
          onTap: () => this.scrollOnTap(context, 2),
        ),
      ),
    ];

    return Drawer(
        child: ListView(
      children: access,
    ));
  } // end of method

  /// フォントをタップした際のスクロール処理
  void scrollOnTap(BuildContext context, int index) {
    this.mainContentScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
    Navigator.pop(context);
  } // end of method
} // end of class
