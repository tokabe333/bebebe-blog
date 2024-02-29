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
  bool _isPlayDemo = true;

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
  Widget build(BuildContext context) {
    if (this._isPlayDemo) {
      /// デモ画面と普通の画面を切り替える
      return AnimatedCrossFade(
          firstChild: StartPageWidget(),
          secondChild: MainFrame(
              title: "beyan's home", page: this._createMainPage(context)),
          crossFadeState: this._isFinishedDemo
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 1000));
    } else {
      return MainFrame(
          title: "beyan's home", page: this._createMainPage(context));
    }
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
