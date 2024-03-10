/// -------------------------------------------
///         スキル紹介文章(language:)
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';

extension SkilsetText on ProfilePageView {
  /// スキルセットを文字で表現
  Widget createSkilsetText(BuildContext context, double contentWidth, FontWeight fontWeight) {
    String skilsetText = "言語 : C++, C#, Python, Ruby, Dart\nサーバ : Nginx, Django\nフロント:Unity, Flutter";
    return Container(
      constraints: BoxConstraints.tightFor(width: contentWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: Text(
        skilsetText,
        style: GoogleFonts.notoSansJp(
          color: Colors.black,
          fontWeight: fontWeight,
          fontSize: contentWidth > 500 ? 20 : 17,
        ),
      ),
    );
  } // end of method
} // end of class

