/// -------------------------------------------
///         メインページ(自己紹介)
/// -------------------------------------------

import 'package:flutter/material.dart';

import '../main_frame.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key? key}) : super(key: key);
  final String title = "べーやん's Site";
  State<MainPageWidget> createState() => MainPageView();
} // end of class

class MainPageView extends State<MainPageWidget> {
  @override
  Widget build(BuildContext context) {
    return MainFrame(title: "beyan's home", page: this._createMainPage(context));
  } // end of build

  Widget _createMainPage(BuildContext context) {
    return Center(
        child: Container(
      color: const Color.fromARGB(255, 137, 194, 240),
      width: double.infinity,
      height: 2000,
      // child: Image.asset(
      //   "images/test_body.jpg",
      // ),
    ));
  }
} // end of class
