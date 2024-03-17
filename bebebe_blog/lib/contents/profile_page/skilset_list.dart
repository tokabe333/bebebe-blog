// -------------------------------------------
//          スキルセットを並べたView
// -------------------------------------------

import 'package:flutter/material.dart';

import './profile_page_view.dart';
import './skilset_badge.dart';

extension SkilsetList on ProfilePageView {
  /// スキルセットバッジを並べたやーつを作る
  Widget createSkilsetList(BuildContext context, double contentWidth, double badgeWidth, double fontSize) {
    // スキルバッジリストを作成
    List<Widget> badges = this._createSkilsetList(badgeWidth, fontSize);

    return Container(
      width: contentWidth,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 20,
        children: badges,
      ),
    );
  } // end of method

  /// スキルセット一覧
  List<Widget> _createSkilsetList(double badgeWidth, double fontSize) {
    List<Widget> badges = [
      // github
      SkilsetBadge(
        text: "Github",
        width: badgeWidth,
        fontSize: fontSize,
        hyperLink: "https://github.com/tokabe333",
        borderColor: const Color.fromARGB(255, 0, 112, 19),
        hoverBackgroundColor: const Color.fromARGB(255, 159, 203, 166),
      ),

      // Atcoder
      SkilsetBadge(
        text: "AtCoder",
        width: badgeWidth,
        fontSize: fontSize,
        hyperLink: "https://atcoder.jp/users/tokabe333",
        borderColor: const Color.fromARGB(255, 108, 108, 108),
        hoverBackgroundColor: const Color.fromARGB(255, 206, 206, 206),
      ),

      // Twitter
      SkilsetBadge(
        text: "Twitter",
        width: badgeWidth,
        fontSize: fontSize,
        hyperLink: "https://twitter.com/tokabe333",
        borderColor: Color.fromARGB(255, 40, 142, 221),
        hoverBackgroundColor: Color.fromARGB(255, 178, 217, 239),
      ),

      // Youtube
      SkilsetBadge(
        text: "Youtube",
        width: badgeWidth,
        fontSize: fontSize,
        hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w",
        borderColor: Color.fromARGB(255, 182, 49, 49),
        hoverBackgroundColor: Color.fromARGB(255, 223, 174, 174),
      ),
    ];

    return badges;
  } // end of method
} // end of class