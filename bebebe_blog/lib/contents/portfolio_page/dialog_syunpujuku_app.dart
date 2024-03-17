// -------------------------------------------
//   春風塾アプリ のポートフォリオ詳細
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

/// ダイアログ画面のウィジェット
class ShunpujukuAppDialogWidget extends StatefulWidget {
  const ShunpujukuAppDialogWidget({Key? key}) : super(key: key);

  @override
  State<ShunpujukuAppDialogWidget> createState() => ShunpujukuAppDialogView();
} // end of class

/// ダイアログ画面のビュー(状態)
class ShunpujukuAppDialogView extends State<ShunpujukuAppDialogWidget> {
  /// 画面見出し用の
  TextStyle _sectionStyle(size) => GoogleFonts.kosugiMaru(fontSize: size, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  /// 詳細説明用
  TextStyle _bodyStyle(size, {weight}) => GoogleFonts.kosugiMaru(fontSize: size, fontWeight: weight ?? FontWeight.w400, height: 1.75);

  /// リンク表示用文字列
  TextStyle _hyperlinkStyle(size) => GoogleFonts.kosugiMaru(fontSize: size, fontWeight: FontWeight.w400, color: Colors.lightBlue, height: 1.75);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: this._createDialogContent(context),
      actions: [],
    );
  } // end of build

  /// ダイアログで実際に表示するコンテンツ
  Widget _createDialogContent(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = math.min(displayWidth * 0.8, 900);

    return Container(
      constraints: BoxConstraints.tightFor(width: contentWidth),
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: displayWidth < 640 ? [this._createSmartPhoneDialog(contentWidth)] : [this._createPcDialog(contentWidth)],
      ),
    );
  } // end of method

  /// 画面サイズが小さい場合は縦に並べる
  Widget _createSmartPhoneDialog(double contentWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        this._createLeftSideIntroduction(contentWidth),
        const SizedBox(height: 20),
        this._createRightSideImage(contentWidth),
      ],
    );
  } // end of method

  /// 画面サイズが大きい場合は横に並べる
  Widget _createPcDialog(double contentWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this._createLeftSideIntroduction(contentWidth * 0.45),
        const Spacer(),
        // 右の画像は中央に配置
        this._createRightSideImage(contentWidth * 0.5),
      ],
    );
  } // end of method

  /// 左側の説明文を作成
  Widget _createLeftSideIntroduction(double width) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("塾管理アプリ(仮)", style: this._sectionStyle(22))),
          const SizedBox(height: 5),
          Text("現在製作中のスマートフォン/Webアプリです。プログラミング塾の教員や保護者の利用を想定し、予約管理・連絡・報告機能を備えます。私が勤めている会社で使用するためですね(笑)", style: this._bodyStyle(17)),
          const SizedBox(height: 2),
          Text("iOS、Android、Web(教員向け)のアプリ全てをFlutterで実装予定です。各種情報の管理や追加・更新をするためにサーバ側はDjango+SQlite3でAPIを提供しています。", style: this._bodyStyle(17)),
          const SizedBox(height: 20),
          Center(child: Text("Development Stacks", style: this._sectionStyle(22))),
          const SizedBox(height: 5),
          Text("Conoha VPS, Nginx, Django, SQlite3\nFlutter, Flutter Web", style: this._bodyStyle(17)),
        ],
      ),
    );
  } // end of method

  /// 右側の画像を作成
  Widget _createRightSideImage(double width) {
    return Column(children: [
      const SizedBox(height: 5),
      SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/images/portfolio/coming_soon_dialog.png", fit: BoxFit.cover),
        ),
      ),
    ]);
  } // end of method

  /// ハイパーリンクを内蔵したテキストを作成する
  Widget _createHyperLinkText(String hyperLink, double fontSize) {
    return InkWell(
      child: Text(hyperLink, style: this._hyperlinkStyle(fontSize)),
      onTap: () async {
        final url = Uri.parse(hyperLink);
        if (await canLaunchUrl(url) == false) return;
        launchUrl(url);
      },
    );
  } // end of method
} // end of class
