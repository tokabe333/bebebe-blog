// -------------------------------------------
//         入力用テキストフォーム
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../site_frames/colors.dart';

class ContactTextformWidget extends StatefulWidget {
  const ContactTextformWidget({Key? key, required String this.heading, required double this.width}) : super(key: key);

  /// フォームの見出し
  final String heading;

  /// テキストフォームの高さ(固定長)
  final double height = 100;

  /// テキストフォームの横幅(親から指定)
  final double width;

  @override
  State<ContactTextformWidget> createState() => ContactTextformView();
} // end of class

class ContactTextformView extends State<ContactTextformWidget> with SingleTickerProviderStateMixin {
  /// 上記のどちらかを表示する
  late Widget displayText;

  /// 入力用フォーム
  late Widget textform;

  /// 入力フォームの下線
  late Widget underLine;

  /// 通常時の見出し文字
  late TextStyle primaryStyle;

  /// テキスト入力時の見出し文字
  late TextStyle focusStyle;

  /// フォーム入力用
  final textController = TextEditingController();

  /// 現在フォーカス中の文字
  final focusNode = FocusNode();

  /// 再生関連
  late AnimationController _animationController;

  /// 異動範囲
  late Tween<Alignment> _tween;

  /// 再生されるアニメーション controller * tween;
  late Animation<Alignment> _animation;

  /// 最初から再生するか、最後から逆再生するか
  bool animationSwitch = true;

  @override
  void initState() {
    super.initState();

    // アニメーションの状態定義
    this._animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    this._tween = Tween(begin: const Alignment(-1, 0), end: const Alignment(-1, -0.7));
    this._animation = this._animationController.drive(this._tween);

    // フォーカスの入力状態を監視
    this.focusNode.addListener(
      () {
        // 見出し文字を動かす
        if (this.textController.text.isEmpty) {
          this.animationSwitch ? this._animationController.forward() : this._animationController.reverse();
          this.animationSwitch = !this.animationSwitch;
        }
        // フォーカスがあたっていたら文字を全選択して画面更新
        if (this.focusNode.hasFocus) {
          this.textController.selection = TextSelection(baseOffset: 0, extentOffset: this.textController.text.length);
        }
        setState(() {});
      },
    );

    // 横幅を指定してテキストフォームを作る
    this.textform = TextFormField(
      autofocus: false,
      controller: this.textController,
      focusNode: this.focusNode,
      style: GoogleFonts.kosugiMaru(fontSize: 18, fontWeight: FontWeight.w400, height: 1.75),
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.textController.dispose();
    this.focusNode.dispose();
  } // end of dispose

  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じて文字サイズを変更(選択状態に応じて変化するのでbuild内に)
    this.primaryStyle = this.textController.text.isEmpty ? GoogleFonts.kosugiMaru(fontSize: 18, fontWeight: FontWeight.w400, height: 1.75) : GoogleFonts.kosugiMaru(fontSize: 15, fontWeight: FontWeight.w400, height: 1.75, color: MyColor.subgrey);
    this.focusStyle = GoogleFonts.kosugiMaru(fontSize: 15, fontWeight: FontWeight.w400, height: 1.75, color: MyColor.mainblue);
    // 移動しつつ色とサイズをアニメーションで変更
    this.displayText = AnimatedCrossFade(
      firstChild: Text(widget.heading, style: this.focusStyle),
      secondChild: Text(widget.heading, style: this.primaryStyle),
      crossFadeState: this.focusNode.hasFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );

    // フォーカス選択でライン変更
    this.underLine = AnimatedCrossFade(
      firstChild: const Divider(thickness: 2, color: Color.fromARGB(185, 11, 127, 223)),
      secondChild: const Divider(thickness: 1, color: Color.fromARGB(255, 102, 102, 102)),
      crossFadeState: this.focusNode.hasFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(children: [
        // 押したら移動する見出し文字
        AnimatedBuilder(
          animation: this._animation,
          builder: (context, _) {
            return Align(alignment: this._animation.value, child: this.displayText);
          },
        ),
        // テキストフォーム
        Align(alignment: const Alignment(-1, 0), child: this.textform),
        // 下線
        Align(alignment: const Alignment(0, 0.52), child: this.underLine),
      ]),
    );
  } // end of build
} // end of class
