/// -------------------------------------------
///         自己紹介文章のところ
/// -------------------------------------------

import 'package:bebebe_blog/contents/profile_page/skilset_badge.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import './profile_page_view.dart';

extension ProfileIntroduce on ProfilePageView {
  /// 紹介文作成
  Widget createIntroduce(BuildContext context, double contentWidth) {
    /// 画面サイズからコンテンツサイズを作る
    double displayWidth = MediaQuery.of(context).size.width;
    double paddingWidth = (displayWidth - contentWidth) / 2;
    double imageWidth = math.max(contentWidth * 0.2, 200);
    double textWidth = contentWidth * 0.7;

    var rend = this.profileKey.currentContext?.findRenderObject() as RenderBox?;
    double imageHeight = rend == null ? 150 : rend!.size.height * 0.75;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(contentWidth * 0.03),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: imageWidth),
            child: Image.asset("assets/images/beyan-alpha.png"),
          ),
          SizedBox(
            key: this.profileKey,
            width: textWidth,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "高専→高専専攻科→大学院と情報系学科に所属。就職を機に地元へ帰るも半年で離職し、四国八十八箇所へ歩き遍路に。結願後は友人に誘われ再就職して現在。競技プログラミングやUnityでのゲーム開発、Djangoでのバックエンド、Flutterでのフロントエンド等スキルは雑多。大学院では医療用CTの画像再構成と深層学習の研究に従事。",
                style: GoogleFonts.kosugiMaru(
                  // style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                  fontSize: displayWidth > 500 ? 20 : 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } // end of method
} // end of class

