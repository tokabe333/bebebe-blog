/// -------------------------------------------
///         メインページ(自己紹介)
/// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
/// -------------------------------------------

import 'package:flutter/material.dart';

import '../main_frame.dart';
import './start_page_view.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key? key, bool this.isPlayDemo = true}) : super(key: key);
  final String title = "べーやん's Site";
  bool isPlayDemo = true;
  State<MainPageWidget> createState() => MainPageView(isPlayDemo);
} // end of class

class MainPageView extends State<MainPageWidget> {
  /// 画面切り替え用のフラグ
  bool _isFinishedDemo = false;

  /// デモ画面再生フラグ
  bool _isPlayDemo;

  /// デモを再生するだけのページ
  Widget demoPage = Container();

  /// 画面切り替えのためにディレイして状態を変化させる
  MainPageView(this._isPlayDemo) {
    if (this._isPlayDemo) {
      Future.delayed(Duration(milliseconds: 6000), () {
        this._isFinishedDemo = true;
        print("画面チェンジ");
        setState(() {});
      });
    }
  } // end of constructor

  @override
  void initState() {
    this.demoPage = StartPageWidget(isPlayDemo: true);
  }

  @override
  Widget build(BuildContext context) {
    // if (this._isPlayDemo) {
    //   /// デモ画面と普通の画面を切り替える
    //   return AnimatedCrossFade(
    //       firstChild: this.demoPage,
    //       secondChild: MainFrame(title: "beyan's home", page: this._createMainPage(context)),
    //       crossFadeState: this._isFinishedDemo ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    //       duration: Duration(milliseconds: 1000));
    // } else {
    //   return MainFrame(title: "beyan's home", page: this._createMainPage(context));
    // }
    return MainFrame(title: "beyan's home", page: StartPageWidget(isPlayDemo: this._isPlayDemo));
  } //   end of build

  /// メインページ作成用
  Widget _createMainPage(BuildContext context) {
    return StartPageWidget(isPlayDemo: false);
  } // end of method
} // end of class
