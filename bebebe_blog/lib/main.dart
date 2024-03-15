/// -------------------------------------------
///           main文とStatelessWidget
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

import './site_frames/main_frame.dart';

void main() {
  if (js_util.hasProperty(html.window, "flutterReady")) {
    js_util.callMethod(html.window, "flutterReady", []);
  }
  runApp(const BebebeApp());
} // end of class

class BebebeApp extends StatelessWidget {
  const BebebeApp({super.key});

  /// 画面上部のバーの高さ
  final double topbarHeight = 60;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "beyan's page!",
      home: MainFrame(topbarHeight: this.topbarHeight),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 226, 216, 243)),
        useMaterial3: true,
      ),
    );
  } // end of build
} // end of class
