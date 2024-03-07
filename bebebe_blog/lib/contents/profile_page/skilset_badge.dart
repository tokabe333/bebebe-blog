/// -------------------------------------------
///           スキルセットのボタン
///     ホバーすると色が変わるやつにしたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:html' as html;
import 'dart:math' as math;
import 'package:vrouter/vrouter.dart';
import 'package:url_launcher/url_launcher.dart';

/// 画面上部に表示するハイパーリンクテキスト
class SkilsetBadge extends StatefulWidget {
  SkilsetBadge({
    Key? key,
    required String this.text,
    required double this.fontSize,
    required String this.hyperLink,
    required Color this.borderColor,
    Color? this.hoverBackgroundColor,
    Alignment this.textAlignment = Alignment.center,
    double this.height = 60,
    double this.width = 200,
  }) : super(key: key) {
    // 背景色が与えられていないならBorderColorをもとに作る
    this.hoverBackgroundColor ??= this.borderColor.withAlpha(22);
  }
  // 表示するテキスト
  String text;

  /// フォントサイズ
  double fontSize;

  /// ウィジェットの高さ
  double height;

  /// ウィジェットの横幅
  double width;

  /// このウィジェットをクリックしたときに飛ぶページ
  String hyperLink;

  /// このウィジェットの枠線色
  Color borderColor;

  /// ホバー時の色
  Color? hoverBackgroundColor;

  /// フォントの配置
  Alignment textAlignment;

  @override
  State<SkilsetBadge> createState() => SkilsetBadgeView(height, width);
}

class SkilsetBadgeView extends State<SkilsetBadge> {
  /// 現在マウスカーソルがホバーされているか
  bool isHover = false;

  /// 通常時の色
  Color primaryColor = Colors.white;

  /// ホバー時の色
  Color hoverColor = const Color.fromARGB(255, 137, 194, 240);

  /// 通常時のウィジェット(普段はこれ)
  Widget primaryContainer = Container();

  /// ホバー時のウィジェット(これに切り替える)
  Widget hoverContainer = Container();

  /// ホバー時にフェードで切り替える
  Widget animatedContainer = Container();

  /// このウィジェットの高さ
  double height;

  /// このウィジェットの横幅
  double width;

  SkilsetBadgeView(double this.height, double this.width) {}

  @override
  void initState() {
    /// 通常時のフォント
    this.primaryContainer = this._createSkilsetBadge(false);

    /// ホバー時のフォント
    this.hoverContainer = this._createSkilsetBadge(true);
  }

  @override
  Widget build(BuildContext context) {
    /// クロスフェードを作る
    animatedContainer = AnimatedCrossFade(
      firstChild: primaryContainer,
      secondChild: hoverContainer,
      crossFadeState: this.isHover ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Duration(milliseconds: 100),
    );

    /// マウスホバーイベントをつける
    return MouseRegion(
      /// ホバー時に色を変える
      onEnter: (_) {
        setState(() {
          this.isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          this.isHover = false;
        });
      },
      child: animatedContainer,
    );
  } // end of build

  /// 普段のウィジェットとホバー時のウィジェット
  Widget _createSkilsetBadge(bool isHover) {
    return InkWell(
      child: Container(
        height: this.height,
        width: this.width,
        alignment: widget.textAlignment,
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: isHover ? widget.hoverBackgroundColor : Colors.white,
          border: Border.all(width: 2, color: widget.borderColor),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            // fontFamily: "noto",
            color: isHover ? Colors.white : widget.borderColor.withAlpha(230),
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500,
            fontSize: widget.fontSize,
          ),
        ),
      ),
      onTap: () async {
        // 外部のサイトへ飛ぶ
        final url = Uri.parse(widget.hyperLink);
        if (await canLaunchUrl(url)) {
          launchUrl(url);
        }
      },
    );
  } // end of method
} // end of class
