/// -------------------------------------------
///         自己紹介とスキルセットとか
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';

import './profile_page_view.dart';
import './skilset_badge.dart';
import './profile_introduce.dart';

class ProfilePageWidget extends StatefulWidget {
  ProfilePageWidget({Key? key}) : super(key: key);

  State<ProfilePageWidget> createState() => ProfilePageView();
} // end of class

class ProfilePageView extends State<ProfilePageWidget> {
  @override
  void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        this.createIntroduce(context),
        Center(
          child: SkilsetBadge(
            text: "Github",
            fontSize: 20,
            hyperLink: "https://github.com/tokabe333",
            borderColor: Color.fromARGB(255, 0, 112, 19),
            hoverBackgroundColor: Color.fromARGB(255, 159, 203, 166),
          ),
        ),
      ],
    );
  }
} // end of class


