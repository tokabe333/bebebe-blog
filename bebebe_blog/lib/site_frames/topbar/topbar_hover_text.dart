/// -------------------------------------------
///            画面左部に表示するバー
///         各ページへのリンクを並べたい
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'dart:math' as math;
import 'package:vrouter/vrouter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../contents/main_page/main_page_view.dart';

/// 画面上部に表示するハイパーリンクテキスト
class HyperLinkText extends StatefulWidget {
  HyperLinkText(
      {Key? key,
      required String this.text,
      required double this.fontSize,
      required String this.route,
      Alignment this.textAlignment = Alignment.center,
      double this.height = 60})
      : super(key: key);
  // 表示するテキスト
  String text;

  /// フォントサイズ
  double fontSize;

  /// Vrouteで使用するリンク
  String route;

  /// フォントの高さ
  double height;

  /// フォントの配置
  Alignment textAlignment;

  @override
  State<HyperLinkText> createState() => HyperLinkTextView(height);
}

class HyperLinkTextView extends State<HyperLinkText> {
  /// 現在マウスカーソルがホバーされているか
  bool isHover = false;

  /// 通常時の色
  Color primaryColor = Colors.white;

  /// ホバー時の色
  Color hoverColor = const Color.fromARGB(255, 137, 194, 240);

  /// 通常時の色
  Widget primaryContainer = Container();

  /// ホバー時のウィジェット(これに切り替える)
  Widget hoverContainer = Container();

  /// 通常時のウィジェット(普段はこれ)
  Widget animatedContainer = Container();

  /// このウィジェットの高さ
  double height;

  HyperLinkTextView(double this.height) {}

  @override
  void initState() {
    /// 通常時のフォント
    primaryContainer = Container(
      height: this.height,
      color: primaryColor,
      alignment: widget.textAlignment,
      // margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Text(widget.text,
            // style: TextStyle(
            //     // fontFamily: "noto",
            //     color: const Color.fromARGB(255, 102, 102, 102),
            //     letterSpacing: 0.5,
            //     fontWeight: FontWeight.w500,
            //     fontSize: widget.fontSize)),
            style: GoogleFonts.notoSansJp(
                color: const Color.fromARGB(255, 102, 102, 102),
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                fontSize: widget.fontSize)),
        onTap: () {
          // 別のページなら遷移する(現在のページには遷移しない)
          if (context.vRouter.path != widget.route) {
            context.vRouter.to(widget.route);
          }
        },
      ),
    );

    /// マウスホバー時のフォント
    hoverContainer = Container(
      height: this.height,
      color: hoverColor,
      alignment: widget.textAlignment,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Text(widget.text,
            // style: TextStyle(
            //   // fontFamily: "noto",
            //   color: Colors.white,
            //   letterSpacing: 0.5,
            //   fontWeight: FontWeight.w500,
            //   fontSize: widget.fontSize,
            // )),
            style: GoogleFonts.notoSansJp(
              color: Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              fontSize: widget.fontSize,
            )),
        onTap: () {
          // 別のページなら遷移する(現在のページには遷移しない)
          if (context.vRouter.path != widget.route) {
            context.vRouter.to(widget.route);
          }
        },
      ),
    );
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
        child: animatedContainer);
  } // end of build
} // end of class
