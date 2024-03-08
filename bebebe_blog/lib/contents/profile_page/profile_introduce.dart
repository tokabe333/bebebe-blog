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
  Widget createIntroduce(BuildContext context) {
    /// 画面サイズからコンテンツサイズを作る
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = math.min(displayWidth * 0.95, 700);
    double paddingWidth = (displayWidth - contentWidth) / 2;
    double imageWidth = contentWidth * 0.2;
    double textWidth = contentWidth * 0.7;

    print("currentContest : ${this.profileKey.currentContext}");
    print("findrenderobject : ${this.profileKey.currentContext?.findRenderObject()}");
    var rend = this.profileKey.currentContext?.findRenderObject() as RenderBox?;
    print("size : ${rend?.size}");
    double imageHeight = rend == null ? 150 : rend!.size.height * 0.8;

    return Container(
      color: const Color.fromARGB(255, 244, 255, 237),
      padding: EdgeInsets.all(contentWidth * 0.02),
      child: Wrap(
        children: [
          SizedBox(child: Image.asset("assets/images/beyan-alpha.png")),
          SizedBox(
            key: this.profileKey,
            width: textWidth,
            child: Text(
              "高専→高専専攻科→大学院と情報系学科に所属。就職を機に地元へ帰るも半年で離職し、四国八十八箇所へ歩き遍路に。結願後は友人に誘われ再就職して現在。競技プログラミングやUnityでのゲーム開発、Djangoでのバックエンド、Flutterでのフロントエンド等スキルは雑多。大学院では医療用CTの画像再構成と深層学習の研究に従事。",
              style: GoogleFonts.kosugiMaru(
                // style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                fontSize: displayWidth > 500 ? 17 : 13,
              ),
            ),
          ),
        ],
      ),
    );

    // return ConstrainedBox(
    //   constraints: BoxConstraints.tightFor(width: contentWidth),
    //   child: Container(
    //     margin: EdgeInsets.only(left: paddingWidth, right: paddingWidth),
    //     // padding: EdgeInsets.all(contentWidth * 0.01),
    //     decoration: BoxDecoration(
    //       color: Color.fromARGB(255, 244, 255, 237),
    //       borderRadius: BorderRadius.circular(20),
    //     ),
    //     child: Wrap(
    //       children: [
    //         SizedBox(width: imageWidth, height: imageWidth, child: Image.asset("assets/images/beyan-alpha.png")),
    //         SizedBox(
    //           width: textWidth,
    //           child: Text(
    //             "高専→高専専攻科→大学院と情報系学科に所属。就職を機に地元へ帰るも半年で離職し、四国八十八箇所へ歩き遍路に。結願後は友人に誘われ再就職して現在。競技プログラミングやUnityでのゲーム開発、Djangoでのバックエンド、Flutterでのフロントエンド等スキルは雑多。大学院では医療用CTの画像再構成と深層学習の研究に従事。",
    //             style: GoogleFonts.kosugiMaru(
    //               // style: TextStyle(
    //               color: Colors.black,
    //               letterSpacing: 0.5,
    //               fontWeight: FontWeight.w500,
    //               fontSize: displayWidth > 500 ? 17 : 13,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  } // end of method
} // end of class

