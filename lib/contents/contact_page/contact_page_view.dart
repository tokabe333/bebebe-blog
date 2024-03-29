// -------------------------------------------
//         メインページ(自己紹介)
// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;

import './send_button.dart';
import './contact_textform.dart';
import './apis_for_contact.dart';

class ContactPageWidget extends StatefulWidget {
  const ContactPageWidget({Key? key, required double this.mainContentHeight}) : super(key: key);

  /// このコンテンツの高さ
  final double mainContentHeight;

  @override
  State<ContactPageWidget> createState() => ContactPageView();
} // end of class

class ContactPageView extends State<ContactPageWidget> {
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
    this.sendButton = SendButtonWidget(sendComment: () async {
      // バージョン情報を取得
      int id = await this.asyncCallCmsFormVersion();
      if (id == -1) return;
      // 入力されているテキストをAPIに投げる
      String name = nameKey.currentState?.textController.text ?? "";
      String email = emailKey.currentState?.textController.text ?? "";
      String comment = commentKey.currentState?.textController.text ?? "";
      await this.asyncSetCsmFormComment(name: name, email: email, comment: comment);
    });
  } // end of initState

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: displayWidth < 640 ? this._createContactPageSmartPhone(context) : this._createContactPagePc(context),
    );
  } // end of build

  /// PC用の2段組みフォームを作成
  Widget _createContactPagePc(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.7;
    double minicontentWidth = contentWidth * 0.45;
    double buttonWidth = math.max(displayWidth * 0.2, 200);

    return Column(children: [
      const Spacer(flex: 2),
      this.sectionText,
      const Spacer(flex: 1),
      SizedBox(
        width: contentWidth,
        child: Row(children: [ContactTextformWidget(key: this.nameKey, heading: "Name", width: minicontentWidth), const Spacer(), ContactTextformWidget(key: this.emailKey, heading: "E-Mail", width: minicontentWidth)]),
      ),
      const Spacer(flex: 1),
      ContactTextformWidget(key: this.commentKey, heading: "Comment", width: contentWidth),
      const Spacer(flex: 1),
      SizedBox(width: buttonWidth, height: buttonWidth * 0.4, child: this.sendButton),
      const Spacer(flex: 2),
    ]);
  } // end of method

  /// スマホ用の上下に並べたフォームを作成
  Widget _createContactPageSmartPhone(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = displayWidth * 0.8;
    double buttonWidth = math.max(displayWidth * 0.2, 200);

    return Column(children: [
      const Spacer(flex: 1),
      this.sectionText,
      const Spacer(flex: 2),
      ContactTextformWidget(key: this.nameKey, heading: "Name", width: contentWidth),
      const Spacer(flex: 2),
      ContactTextformWidget(key: this.emailKey, heading: "E-Mail", width: contentWidth),
      const Spacer(flex: 2),
      ContactTextformWidget(key: this.commentKey, heading: "Comment", width: contentWidth),
      const Spacer(flex: 2),
      SizedBox(width: buttonWidth, height: buttonWidth * 0.4, child: this.sendButton),
      const Spacer(flex: 1),
    ]);
  }
} // end of class
