// -------------------------------------------
//         スキル紹介文章(language:)
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './profile_page_view.dart';

extension SkilsetText on ProfilePageView {
  /// スキルセットを文字で表現
  Widget createSkilsetText(BuildContext context, double contentWidth, FontWeight fontWeight) {
    String skilsetText = "言語　　 : C++, C#, Python, (Ruby, Dart)\nサーバ　 : Nginx, Django\nフロント : Unity, Flutter";
    return Container(
      constraints: BoxConstraints.tightFor(width: contentWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
      alignment: Alignment.center,
      child: Text(
        skilsetText,
        style: GoogleFonts.kosugiMaru(
          color: Colors.black,
          fontWeight: fontWeight,
          fontSize: contentWidth > 500 ? 20 : 17,
        ),
      ),
    );
  } // end of method
} // end of class

