/// -------------------------------------------
///          スキルセットを並べたView
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';

import './profile_page_view.dart';
import './skilset_badge.dart';
import './profile_introduce.dart';

extension SkilsetList on ProfilePageView {
  /// スキルセットバッジを並べたやーつを作る
  Widget createSkilsetList(BuildContext context, double contentWidth, double badgeWidth) {
    // スキルバッジリストを作成
    List<Widget> badges = this._createSkilsetList(badgeWidth);

    return Container(
      width: contentWidth,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: badges,
      ),
    );
  } // end of method

  /// スキルセット一覧
  List<Widget> _createSkilsetList(double badgeWidth) {
    List<Widget> badges = [
      // github
      SkilsetBadge(
        text: "Github",
        width: badgeWidth,
        fontSize: 20,
        hyperLink: "https://github.com/tokabe333",
        borderColor: const Color.fromARGB(255, 0, 112, 19),
        hoverBackgroundColor: const Color.fromARGB(255, 159, 203, 166),
      ),

      // Atcoder
      SkilsetBadge(
        text: "AtCoder",
        width: badgeWidth,
        fontSize: 20,
        hyperLink: "https://atcoder.jp/users/tokabe333",
        borderColor: const Color.fromARGB(255, 108, 108, 108),
        hoverBackgroundColor: const Color.fromARGB(255, 206, 206, 206),
      ),
    ];

    return badges;
  } // end of method
} // end of class