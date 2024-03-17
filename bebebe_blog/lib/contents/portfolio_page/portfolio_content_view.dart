// -------------------------------------------
//            制作物1個分のコンテナ
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './dialog_beyan-connect.dart';

class PortFolioContentWidget extends StatefulWidget {
  const PortFolioContentWidget({
    Key? key,
    required double this.containerHeight,
    required double this.containerWidth,
    required String this.imagePath,
    required String this.caption,
    required Widget this.dialogWidget,
  }) : super(key: key);

  final double containerHeight;
  final double containerWidth;
  final String imagePath;
  final String caption;
  final Widget dialogWidget;

  @override
  State<PortFolioContentWidget> createState() => PortFolioContentView();
} // end of class

class PortFolioContentView extends State<PortFolioContentWidget> {
  /// このコンテナの高さ(ホバー時に変化する)
  double _containerHeight = 0;

  /// このコンテナの横幅(ホバー時に変化する)
  double _containerWidth = 0;

  /// コンテナのホバー中検出
  bool _isHover = false;

  @override
  initState() {
    this._containerHeight = widget.containerHeight;
    this._containerWidth = widget.containerWidth;

    super.initState();
  }

  /// フェードインアニメーションを付けてコンテナを返す
  @override
  Widget build(BuildContext context) {
    // ホバー時とクリック時のイベントをつける
    Widget container = InkWell(
      onTap: () => showDialog(context: context, builder: (context) => widget.dialogWidget),
      onHover: (isEnter) {
        if (isEnter) {
          this._isHover = true;
        } else {
          this._isHover = false;
        }
        setState(() {});
      },
      child: this._createMainContainer(),
    );

    return FadeInAnimation(
      animateDirection: AnimateDirection.bottom,
      moveAmount: 10,
      delay: const Duration(milliseconds: 1000),
      child: container,
    );
  } // end of build

  /// 実際に描画するコンテナを作る
  Widget _createMainContainer() {
    return AnimatedContainer(
      // ホバー時のアニメーション設定
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      // ホバー時のサイズ変更
      height: this._isHover ? this._containerHeight * 1.1 : this._containerHeight,
      width: this._isHover ? this._containerWidth * 1.1 : this._containerWidth,
      padding: const EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
      alignment: Alignment.topCenter,
      // 形状と影
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
        boxShadow: this._isHover ? [const BoxShadow(color: Color.fromARGB(255, 210, 226, 250), blurRadius: 1, offset: Offset(3, 3))] : [],
      ),
      // サムネ画像とキャプションを並べる
      child: Column(children: [
        Image.asset(widget.imagePath),
        const Spacer(),
        Text(widget.caption, style: GoogleFonts.notoSansJp(fontSize: widget.containerWidth < 300 ? 12 : 14, fontWeight: FontWeight.w400)),
        const Spacer(),
      ]),
    );
  } // end of method
} // end of class
