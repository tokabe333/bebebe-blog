/// -------------------------------------------
///    main_frameで使用するdrawerの実装
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import 'topbar/topbar_hover_text.dart';
import 'main_frame.dart';

/// 実際に表示を記述する
extension MainFrameDrawer on MainFrameView {
  /// Drawerメニュー作成
  Drawer createDrawerMenu() {
    // アクセス一覧
    List<Widget> access = [
      // this._createDrawerText("トップ", 15, "/", textAlignment: Alignment.centerLeft),
      // this._createDrawerText("ポートフォリオ", 15, "/github", textAlignment: Alignment.centerLeft),
      HyperLinkText(text: "トップ", fontSize: 15, route: "/top", textAlignment: Alignment.center),
      HyperLinkText(text: "ポートフォリオ", fontSize: 15, route: "/github", textAlignment: Alignment.center),
    ];

    return Drawer(
        child: ListView(
      children: access,
    ));
  } // end of method

  /// DrawerにHyperLinkText
  Widget _createDrawerText(String text, double fontSize, String route, {Alignment textAlignment = Alignment.center}) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: HyperLinkText(
          text: text,
          fontSize: fontSize,
          route: route,
          textAlignment: textAlignment,
        ));
  } // end of method
} // end of class
