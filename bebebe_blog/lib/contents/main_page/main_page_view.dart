/// -------------------------------------------
///         メインページ(自己紹介)
/// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './demo_page_view.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({Key? key, bool this.isPlayDemo = true, required double this.mainContentHeight}) : super(key: key);

  /// デモを再生するか
  final bool isPlayDemo;

  /// このコンテンツの高さ
  final double mainContentHeight;

  @override
  State<MainPageWidget> createState() => MainPageView(this.isPlayDemo, this.mainContentHeight);
} // end of class

class MainPageView extends State<MainPageWidget> {
  /// デモを再生するだけのページ
  late DemoPageWidget _demoPage;

  /// デモからメイン画面に移るディレイ
  int delaySwitchTime = 0;

  /// デモを再生するか
  bool isPlayDemo;

  /// このコンテンツの高さ
  final double mainContentHeight;

  /// 画面切り替えのためにディレイして状態を変化させる
  MainPageView(bool this.isPlayDemo, double this.mainContentHeight) {
    // デモをするときはディレイをつける
    if (this.isPlayDemo) this.delaySwitchTime = 5300;

    // デモページを作成
    this._demoPage = DemoPageWidget();

    // 時間が来たら紹介文を表示する
    Future.delayed(Duration(milliseconds: this.delaySwitchTime), () {
      this.isPlayDemo = false;
      setState(() {});
    });
  } // end of constructor

  @override
  void initState() {
    super.initState();
  } // end of method

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    double introduceHeight = this.mainContentHeight * 0.3;

    // stackで重ねるデモの位置
    double demoHeight = this.mainContentHeight * 0.65;
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
      height: this.mainContentHeight,
      color: const Color.fromARGB(255, 137, 194, 240),
      child: Stack(
        children: [
          // デモ動画
          Positioned(
            left: demoPadding,
            right: demoPadding,
            child: Container(height: demoHeight, width: demoWidth, child: this._demoPage.createDemoWidget(context, this.isPlayDemo)),
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
      child: this.isPlayDemo ? SizedBox() : introduceColumn,
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


