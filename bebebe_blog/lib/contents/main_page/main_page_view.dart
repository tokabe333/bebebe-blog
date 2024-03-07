/// -------------------------------------------
///         メインページ(自己紹介)
/// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../site_frames/main_frame.dart';
import './demo_page_view.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key? key, bool this.isPlayDemo = true, required double this.topbarHeight}) : super(key: key);
  final String title = "べーやん's Site";
  bool isPlayDemo = true;
  double topbarHeight;
  State<MainPageWidget> createState() => MainPageView(isPlayDemo, topbarHeight);
} // end of class

class MainPageView extends State<MainPageWidget> {
  /// デモ画面再生フラグ
  bool _isPlayDemo;

  /// デモを再生するだけのページ
  late DemoPageWidget _demoPage;

  /// 画面切り替え用
  bool _isFinishedDemo = false;

  /// トップバーの高さ
  double topbarHeight;

  /// デモからメイン画面に移るディレイ
  int delaySwitchTime = 0;

  /// 画面切り替えのためにディレイして状態を変化させる
  MainPageView(this._isPlayDemo, this.topbarHeight) {
    // デモをするときはディレイをつける
    if (this._isPlayDemo) this.delaySwitchTime = 5300;

    // デモページを作成
    this._demoPage = DemoPageWidget(this._isPlayDemo);

    // 時間が来たら紹介文を表示する
    Future.delayed(Duration(milliseconds: this.delaySwitchTime), () {
      setState(() {
        this._isFinishedDemo = true;
      });
    });
  } // end of constructor

  @override
  void initState() {}

  @override

  /// メインコンテンツ(デモとサイト紹介)を作成
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    double mainContentHeight = displayHeight - this.topbarHeight;
    double introduceHeight = mainContentHeight * 0.3;

    // stackで重ねるデモの位置
    double demoHeight = displayHeight * 0.6;
    double demoWidth = 0;
    if (displayHeight <= displayWidth) {
      demoWidth = demoHeight / 340 * 500;
    } else {
      demoWidth = displayWidth;
      demoHeight = demoWidth / 500 * 340;
    }
    double demoPadding = (displayWidth - demoWidth) / 2;

    // 背景をつけて、Stackで位置を決めていく
    return Container(
      width: displayWidth,
      height: mainContentHeight,
      color: const Color.fromARGB(255, 137, 194, 240),
      child: Stack(
        children: [
          // デモ動画
          Positioned(
            left: demoPadding,
            right: demoPadding,
            child: Container(height: demoHeight, width: demoWidth, child: this._demoPage.createDemoWidget(context)),
          ),
          // ポートフォリオサイトです
          Positioned(
            left: demoPadding,
            right: demoPadding,
            top: demoHeight + 30,
            child: this._createIntroduce(introduceHeight),
          ),
        ],
      ),
    );
  } // end of build

  /// 画面下部の紹介文を作成
  Widget _createIntroduce(double height) {
    // デモ終了後に表示する紹介文
    Widget introduceColumn = Column(children: [
      this._createIntroduceText("べーやんのポートフォリオサイトです"),
      this._createIntroduceText("ゆっくりしていってね！"),
    ]);

    // 表示用コンテナ
    Widget introduceContainer = SizedBox(
      height: height,
      child: this._isFinishedDemo ? introduceColumn : SizedBox(),
    );

    // フェードインアニメーション
    return FadeInAnimation(
      animateDirection: AnimateDirection.top,
      moveAmount: 10,
      delay: Duration(milliseconds: this.delaySwitchTime + 1000),
      child: Container(
        color: const Color.fromARGB(255, 137, 194, 240),
        child: introduceContainer,
      ),
    );
  } // end of method

  /// 紹介文用テキストを作成
  Widget _createIntroduceText(String text, {double fontSize = 18, Color color = Colors.white}) {
    return SizedBox(
      height: fontSize + 10,
      child: Center(
        child: Text(
          text,
          // style: TextStyle(
          //   color: color,
          //   fontSize: fontSize,
          //   fontFamily: "noto",
          //   fontWeight: FontWeight.w500,
          // ),
          style: GoogleFonts.notoSansJp(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  } // end of method
} // end of class


