/// -------------------------------------------
///           main文とStatelessWidget
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import './main_page/main_page_view.dart';

void main() {
  runApp(BebebeApp());
} // end of class

class BebebeApp extends StatelessWidget {
  BebebeApp({super.key}) {}

  /// 画面上部のバーの高さ
  double topbarHeight = 60;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "beyan's home page",
      home: MainPageWidget(topbarHeight: 60),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 216, 243)),
        useMaterial3: true,
      ),
    );
  } // end of build
} // end of class
