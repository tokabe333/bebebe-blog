// -------------------------------------------
//         メインページ(自己紹介)
// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './send_button.dart';
import './contact_textform.dart';

class ContactPageWidget extends StatefulWidget {
  const ContactPageWidget({Key? key, required double this.mainContentHeight}) : super(key: key);

  /// このコンテンツの高さ
  final double mainContentHeight;

  @override
  State<ContactPageWidget> createState() => ContactPageView();
} // end of class

class ContactPageView extends State<ContactPageWidget> {
  int _versionid = 0;

  /// 名前を取得するためのキー
  GlobalKey<ContactTextformView> nameKey = GlobalKey();

  // メールアドレスを取得するためのキー
  GlobalKey<ContactTextformView> emailKey = GlobalKey();

  // コメントを取得するためのキー
  GlobalKey<ContactTextformView> commentKey = GlobalKey();

  /// メッセージをすでに送信したか
  bool isSendComment = false;

  /// データ送信用ボタン
  late Widget sendButton;

  /// 見出し
  Widget sectionText = Text("Ｃｏｎｔａｃｔ", style: GoogleFonts.kosugiMaru(fontSize: 50, fontWeight: FontWeight.w600, letterSpacing: -10, color: const Color.fromARGB(255, 102, 102, 102)));

  @override
  void initState() {
    super.initState();

    // ボタンはPCとスマホで共通
    // 押したらデータを送信するために監視
    this.sendButton = SendButtonWidget(sendComment: () {
      var name = nameKey.currentState?.textController.text;
      print("namename : ${name}");
    });
  } // end of initState

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: this._createContactPagePc(context),
    );
  } // end of build

  /// PC用の2段組みフォームを作成
  Widget _createContactPagePc(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.7;
    double minicontentWidth = contentWidth * 0.45;
    double buttonWidth = displayWidth * 0.2;

    return Column(children: [
      const Spacer(),
      this.sectionText,
      const Spacer(),
      SizedBox(
        width: contentWidth,
        child: Row(children: [ContactTextformWidget(key: this.nameKey, heading: "Name", width: minicontentWidth), const Spacer(), ContactTextformWidget(key: this.emailKey, heading: "E-Mail", width: minicontentWidth)]),
      ),
      const Spacer(),
      ContactTextformWidget(key: this.commentKey, heading: "Comment", width: contentWidth),
      const Spacer(),
      Container(decoration: BoxDecoration(border: Border.all(width: 1)), width: buttonWidth, height: buttonWidth * 0.4, child: this.sendButton),
      const Spacer(),
    ]);
  }
} // end of class
