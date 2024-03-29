// -------------------------------------------
//         入力用テキストフォーム
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../site_frames/colors.dart';

import './send_button.dart';

class ContactTextformWidget extends StatefulWidget {
  ContactTextformWidget({Key? key, required String this.heading}) : super(key: key);

  /// フォームの見出し
  final String heading;

  /// テキストフォームの高さ(固定長)
  final double height = 100;

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

  late AnimationController _animationController;

  late Tween<Alignment> _tween;

  late Animation<Alignment> _animation;

  bool animationSwitch = true;

  @override
  void initState() {
    super.initState();

    // アニメーションの状態定義
    this._animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    this._tween = Tween(begin: const Alignment(-1, 0), end: const Alignment(-1, -1));
    this._animation = this._animationController.drive(this._tween);

    // フォーカスの入力状態を監視
    this.focusNode.addListener(
      () {
        // フォーカスがあたっていたら文字を全選択して画面更新
        if (this.focusNode.hasFocus) {
          this.textController.selection = TextSelection(baseOffset: 0, extentOffset: this.textController.text.length);
          setState(() {});
        }
        // 見出し文字を動かす
        this.animationSwitch ? this._animationController.forward() : this._animationController.reverse();
        this.animationSwitch = !this.animationSwitch;
      },
    );

    // 横幅を指定してテキストフォームを作る
    this.textform = TextFormField(
      autofocus: false,
      controller: this.textController,
      focusNode: this.focusNode,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.textController.dispose();
    this.focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    // 画面サイズに応じて文字サイズを変更(選択状態に応じて変化するのでbuild内に)
    this.primaryStyle = GoogleFonts.kosugiMaru(fontSize: 18, fontWeight: FontWeight.w400, height: 1.75);
    this.focusStyle = GoogleFonts.kosugiMaru(fontSize: 15, fontWeight: FontWeight.w400, height: 1.75, color: this.focusNode.hasFocus ? mainblue : subgrey);
    this.displayText = Text(widget.heading, style: this.focusNode.hasFocus ? this.focusStyle : this.primaryStyle);

    // フォーカス選択でライン変更
    this.underLine = AnimatedCrossFade(
      firstChild: const Divider(thickness: 2, color: Color.fromARGB(185, 11, 127, 223)),
      secondChild: const Divider(thickness: 1, color: Color.fromARGB(255, 102, 102, 102)),
      crossFadeState: this.focusNode.hasFocus ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );

    return SizedBox(
      width: displayWidth,
      height: displayHeight,
      child: Stack(children: [
        // this.displayWidget,
        AnimatedBuilder(
          animation: this._animation,
          builder: (context, _) {
            return Align(alignment: this._animation.value, child: this.displayText);
          },
        ),
        this.textform,
        this.underLine,
      ]),
    );
  } // end of build
} // end of class
