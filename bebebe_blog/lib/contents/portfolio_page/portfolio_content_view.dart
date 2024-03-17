// -------------------------------------------
//            制作物1個分のコンテナ
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortFolioContentWidget extends StatefulWidget {
  const PortFolioContentWidget({Key? key, required double this.containerHeight, required double this.containerWidth}) : super(key: key);

  final double containerHeight;
  final double containerWidth;

  @override
  State<PortFolioContentWidget> createState() => PortFolioContentView();
} // end of class

class PortFolioContentView extends State<PortFolioContentWidget> {
  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      height: widget.containerHeight,
      width: widget.containerWidth,
      color: Colors.brown,
    );

    return FadeInAnimation(
      animateDirection: AnimateDirection.bottom,
      moveAmount: 10,
      delay: const Duration(milliseconds: 1000),
      child: Container(
        color: const Color.fromARGB(255, 137, 194, 240),
        child: container,
      ),
    );
  }
} // end of class
