// -------------------------------------------
//         メインページ(自己紹介)
// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './send_button.dart';

class ContactPageWidget extends StatefulWidget {
  const ContactPageWidget({Key? key, required double this.mainContentHeight}) : super(key: key);

  /// このコンテンツの高さ
  final double mainContentHeight;

  @override
  State<ContactPageWidget> createState() => ContactPageView();
} // end of class

class ContactPageView extends State<ContactPageWidget> {
  int _versionid = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SendButtonWidget(),
    );
  }
} // end of class
