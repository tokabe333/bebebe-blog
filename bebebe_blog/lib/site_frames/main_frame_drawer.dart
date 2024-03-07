/// -------------------------------------------
///    main_frameで使用するdrawerの実装
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrouter/vrouter.dart';

import './topbar/topbar_hover_text.dart';
import './main_frame.dart';

/// 実際に表示を記述する
extension MainFrameDrawer on MainFrameView {
  /// Drawerメニュー作成
  Drawer createDrawerMenu() {
    // アクセス一覧
    List<Widget> access = [
      HyperLinkText(text: "トップ", fontSize: 15, route: "/top", textAlignment: Alignment.center),
      HyperLinkText(text: "ポートフォリオ", fontSize: 15, route: "/github", textAlignment: Alignment.center),
    ];

    return Drawer(
        child: ListView(
      children: access,
    ));
  } // end of method
} // end of class
