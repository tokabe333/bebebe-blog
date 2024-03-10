/// -------------------------------------------
///         自己紹介文章のところ
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';

extension ProfileIntroduce on ProfilePageView {
  /// べーやんアイコン作成
  Widget _createIconImage(double imageWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: imageWidth),
      child: Image.asset("assets/images/beyan-alpha.png"),
    );
  } // end of method

  Widget _createIntroduceText(double textWidth, FontWeight fontWeight) {
    return SizedBox(
      width: textWidth,
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          "高専→高専専攻科→大学院と情報系学科に所属。就職を機に地元へ帰るも半年で離職し、四国八十八箇所へ歩き遍路に。結願後は友人に誘われ再就職して現在。競技プログラミングやUnityでのゲーム開発、Djangoでのバックエンド、Flutterでのフロントエンド等スキルは雑多。大学院では医療用CTの画像再構成と深層学習の研究に従事。",
          style: GoogleFonts.kosugiMaru(
            // style: GoogleFonts.notoSansJp(
            color: Colors.black,
            letterSpacing: 0.5,
            fontWeight: fontWeight,
            fontSize: textWidth > 500 ? 20 : 17,
          ),
        ),
      ),
    );
  } // end of method

  /// 紹介文作成
  Widget createIntroduce(BuildContext context, double contentWidth) {
    // コンテンツサイズから配分
    double imageWidth = math.max(contentWidth * 0.2, 200);
    double textWidth = contentWidth * 0.7;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(contentWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 画面が小さくなったら画像を上限に置く
          this._createIconImage(imageWidth),
          // テキストは自由に大きさを配置
          this._createIntroduceText(textWidth, FontWeight.w500),
        ],
      ),
    );
  } // end of method

  /// 紹介文作成 SmartPhone
  Widget createIntroduceSmartphone(BuildContext context, double contentWidth) {
    // コンテンツサイズから配分
    double imageWidth = math.max(contentWidth * 0.2, 100);
    double textWidth = contentWidth;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 画面が小さくなったら画像を上限に置く
          this._createIconImage(imageWidth),
          // テキストは自由に大きさを配置
          this._createIntroduceText(textWidth, FontWeight.w400),
        ],
      ),
    );
  } // end of method
} // end of class

