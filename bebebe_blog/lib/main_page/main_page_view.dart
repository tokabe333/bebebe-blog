/// -------------------------------------------
///         メインページ(自己紹介)
/// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
/// -------------------------------------------

import 'package:flutter/material.dart';

import '../main_frame.dart';
import './start_page_view.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key? key, bool isDemo = true}) : super(key: key);
  final String title = "べーやん's Site";
  State<MainPageWidget> createState() => MainPageView();
} // end of class

class MainPageView extends State<MainPageWidget> {
  /// 画面切り替え用のフラグ
  bool _isFinishedDemo = false;

  /// 画面切り替えのためにディレイして状態を変化させる
  MainPageView() {
    print("constructor");
    Future.delayed(Duration(milliseconds: 2000), () {
      this._isFinishedDemo = true;
      print("画面チェンジ");
      setState(() {});
    });
  } // end of constructor

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: StartPageWidget(),
        secondChild: MainFrame(title: "beyan's home", page: this._createMainPage(context)),
        crossFadeState: this._isFinishedDemo ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 300));
  } //   end of build

  /// メインページ作成用
  Widget _createMainPage(BuildContext context) {
    return Center(
        child: Container(
      color: const Color.fromARGB(255, 137, 194, 240),
      width: double.infinity,
      height: 2000,
    ));
  } // end of method
} // end of class
