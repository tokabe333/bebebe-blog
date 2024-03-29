// -------------------------------------------
//   beyan-connect.net のポートフォリオ詳細
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

/// ダイアログ画面のウィジェット
class BeyanConnectDialogWidget extends StatefulWidget {
  const BeyanConnectDialogWidget({Key? key}) : super(key: key);

  @override
  State<BeyanConnectDialogWidget> createState() => BeyanConnectDialogView();
} // end of class

/// ダイアログ画面のビュー(状態)
class BeyanConnectDialogView extends State<BeyanConnectDialogWidget> {
  /// 画面見出し用の
  TextStyle _sectionStyle(size) => GoogleFonts.kosugiMaru(fontSize: size, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  /// 詳細説明用
  TextStyle _bodyStyle(size, {weight}) => GoogleFonts.kosugiMaru(fontSize: size, fontWeight: weight ?? FontWeight.w400, height: 1.75);

  /// リンク表示用文字列
  TextStyle _hyperlinkStyle(size) => GoogleFonts.kosugiMaru(fontSize: size, fontWeight: FontWeight.w400, color: Colors.lightBlue, height: 1.75);

  /// ダイアログで実際に表示するコンテンツ
  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;
    double contentWidth = math.min(displayWidth * 0.8, 900);

    // スマートフォン版のダイアログ(スクロールできるようにする)
    if (contentWidth < 640) {
      return AlertDialog(
        scrollable: true,
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Wrap(children: [
            SizedBox(width: contentWidth, height: displayHeight * 0.7, child: this._createSmartPhoneDialog(contentWidth)),
          ]),
        ),
      );
    }
    // PC版のダイアログ(普通に表示する)
    else {
      return AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(10),
          child: Wrap(children: [this._createPcDialog(contentWidth)]),
        ),
      );
    }
  } // end of method

  /// 画面サイズが小さい場合は縦に並べる
  Widget _createSmartPhoneDialog(double contentWidth) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     this._createLeftSideIntroduction(contentWidth),
    //     const SizedBox(height: 20),
    //     this._createRightSideImage(contentWidth),
    //   ],
    // );
    return ListView(
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
        this._createLeftSideIntroduction(contentWidth * 0.4),
        const SizedBox(width: 10),
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
          Center(child: Text("Beyan-Connect", style: this._sectionStyle(22))),
          const SizedBox(height: 5),
          Text("現在開いているWebサイトです。Flutterの学習用と趣味を兼ねて作成しました。Hodaさんのページを参考にさせていただいています！", style: this._bodyStyle(17)),
          const SizedBox(height: 2),
          this._createHyperLinkText("Hoda's Portfolio", "https://hodalab.com/portfolio/", 17),
          const SizedBox(height: 2),
          Text("Flutter Webはまだまだ発展途上な印象を受けますが、学んだスキルがスマホやPCのネイティブアプリ開発に応用できるので気に入っています。", style: this._bodyStyle(17)),
          const SizedBox(height: 2),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [this._createGithubIcon(), const SizedBox(width: 8), this._createHyperLinkText("GitHub", "https://github.com/tokabe333/bebebe-blog", 17)]),
          const SizedBox(height: 20),
          Center(child: Text("Development Stacks", style: this._sectionStyle(22))),
          const SizedBox(height: 5),
          Text("Conoha VPS, Nginx, Flutter Web, Rive", style: this._bodyStyle(17)),
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
          child: Image.asset("assets/images/portfolio/beyan-connect_dialog.png", fit: BoxFit.cover),
        ),
      ),
    ]);
  } // end of method

  /// ハイパーリンクを内蔵したテキストを作成する
  Widget _createHyperLinkText(String text, String hyperLink, double fontSize) {
    return InkWell(
      child: Text(text, style: this._hyperlinkStyle(fontSize)),
      onTap: () async {
        final url = Uri.parse(hyperLink);
        if (await canLaunchUrl(url) == false) return;
        launchUrl(url);
      },
    );
  } // end of method

  /// GitHubへのアイコンを作る
  Widget _createGithubIcon() {
    return SizedBox(
      height: 20,
      width: 20,
      child: InkWell(
        child: Image.asset("images/github.png"),
        onTap: () async {
          final url = Uri.parse("https://github.com/tokabe333/bebebe-blog");
          if (await canLaunchUrl(url)) {
            launchUrl(url);
          }
        },
      ),
    );
  } // end of method
} // end of class
