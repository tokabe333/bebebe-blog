// -------------------------------------------
//            制作物1個分のコンテナ
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortFolioContentWidget extends StatefulWidget {
  const PortFolioContentWidget({
    Key? key,
    required double this.containerHeight,
    required double this.containerWidth,
    required String this.imagePath,
    required String this.caption,
  }) : super(key: key);

  final double containerHeight;
  final double containerWidth;
  final String imagePath;
  final String caption;

  @override
  State<PortFolioContentWidget> createState() => PortFolioContentView();
} // end of class

class PortFolioContentView extends State<PortFolioContentWidget> {
  /// フェードインアニメーションを付けてコンテナを返す
  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      animateDirection: AnimateDirection.bottom,
      moveAmount: 10,
      delay: const Duration(milliseconds: 1000),
      child: this._createMainContainer(),
    );
  } // end of build

  /// 実際に描画するコンテナを作る
  Widget _createMainContainer() {
    return Container(
      height: widget.containerHeight,
      width: widget.containerWidth,
      padding: const EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFFFFFFF)),
      child: Column(children: [
        Image.asset(widget.imagePath),
        const Spacer(),
        Text(widget.caption, style: GoogleFonts.notoSansJp(fontSize: widget.containerWidth < 300 ? 12 : 14, fontWeight: FontWeight.w400)),
        const Spacer(),
      ]),
    );
  } // end of method
} // end of class
