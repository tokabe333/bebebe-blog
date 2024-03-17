// -------------------------------------------
//            画面左部に表示するバー
//         各ページへのリンクを並べたい
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 画面上部に表示するハイパーリンクテキスト
class HyperLinkText extends StatefulWidget {
  const HyperLinkText({Key? key, required String this.text, required double this.fontSize, Alignment this.textAlignment = Alignment.center, double this.height = 60, Function? this.onTap}) : super(key: key);
  // 表示するテキスト
  final String text;

  /// フォントサイズ
  final double fontSize;

  /// フォントの高さ
  final double height;

  /// フォントの配置
  final Alignment textAlignment;

  /// タップ時の処理
  final Function? onTap;

  @override
  State<HyperLinkText> createState() => HyperLinkTextView();
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

  @override
  void initState() {
    /// 通常時のフォント
    primaryContainer = Container(
      height: widget.height,
      color: primaryColor.withOpacity(0),
      alignment: widget.textAlignment,
      // margin: EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Text(widget.text, style: GoogleFonts.notoSansJp(color: const Color.fromARGB(255, 102, 102, 102), letterSpacing: 0.5, fontWeight: FontWeight.w500, fontSize: widget.fontSize)),
        onTap: () => widget.onTap?.call(),
      ),
    );

    /// マウスホバー時のフォント
    hoverContainer = Container(
      height: widget.height,
      color: hoverColor,
      alignment: widget.textAlignment,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        child: Text(widget.text,
            style: GoogleFonts.notoSansJp(
              color: Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              fontSize: widget.fontSize,
            )),
        onTap: () => widget.onTap?.call(),
      ),
    );

    super.initState();
  } // end of method

  @override
  Widget build(BuildContext context) {
    /// クロスフェードを作る
    animatedContainer = AnimatedCrossFade(
      firstChild: primaryContainer,
      secondChild: hoverContainer,
      crossFadeState: this.isHover ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 100),
    );

    // マウスホバーイベントをつける
    return MouseRegion(
      // ホバー時に色を変える
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
} // end of class
