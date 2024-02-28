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
  bool _isCreatedMain = false;

  /// フェード in out 用
  Widget _mainPage = Container();
  Widget _startPage = Container();
  Widget _fadePage = Container();

  /// 画面切り替えのためにディレイして状態を変化させる
  MainPageView() {
    print("constructor");
    Future.delayed(Duration(milliseconds: 2000), () {
      this._isFinishedDemo = true;
      print("画面チェンジ");
      setState(() {});
    });

    this._startPage = StartPageWidget();

    this._fadePage = AnimatedCrossFade(
        firstChild: this._startPage,
        secondChild: this._mainPage,
        crossFadeState: this._isFinishedDemo ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 2000));
  } // end of constructor

  @override
  Widget build(BuildContext context) {
    if (_isCreatedMain == false) {
      print("hogehoge");
      _isCreatedMain = true;
      this._mainPage = MainFrame(title: "beyan's home", page: this._createMainPage(context));
    }
    return AnimatedCrossFade(
        firstChild: Container(
          width: 1000,
          height: 400,
          color: Colors.blue,
        ),
        secondChild: MainFrame(title: "beyan's home", page: this._createMainPage(context)),
        crossFadeState: this._isFinishedDemo ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 2000));
  } // end of build

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
