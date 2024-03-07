/// -------------------------------------------
///         自己紹介文章のところ
/// -------------------------------------------

import 'package:bebebe_blog/contents/profile_page/skilset_badge.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';

import './profile_page_view.dart';

extension ProfileIntroduce on ProfilePageView {
  /// 紹介文作成
  Widget createIntroduce(BuildContext context) {
    /// 画面サイズからコンテンツサイズを作る
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.95;
    double paddingWidth = (displayWidth - contentWidth) / 2;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: contentWidth),
      child: Container(
        margin: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "とりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすととりあえずテキストとりあえずてきすと",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
            fontSize: displayWidth > 500 ? 15 : 13,
          ),
        ),
      ),
    );
  } // end of method
} // end of class

