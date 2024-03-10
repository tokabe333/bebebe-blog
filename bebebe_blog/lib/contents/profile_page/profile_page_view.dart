/// -------------------------------------------
///         自己紹介とスキルセットとか
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import './profile_page_view.dart';
import './skilset_badge.dart';
import './skilset_list.dart';
import './profile_introduce.dart';
import './profile_page_smartphone.dart';
import '../../site_frames/background_image.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key, required double this.topbarHeight}) : super(key: key);

  /// トップバーの高さは毎回与えられる
  final double topbarHeight;

  @override
  State<ProfilePageWidget> createState() => ProfilePageView();
} // end of class

class ProfilePageView extends State<ProfilePageWidget> {
  /// 自分のアイコンイメージ(読み込み終わったらsetstate)
  Image? iconImage;

  /// このウィジェットの大きさを調べるためのキー
  GlobalKey profilePageKey = GlobalKey();

  /// このウィジェットの大きさを調べるためのキー(スマートフォンページ)
  GlobalKey profilePageKeySmartphone = GlobalKey();

  @override
  void didChangeDependencies() async {
    this._loadImage(context);
    super.didChangeDependencies();
  } // end of didChangeDependencies

  /// 非同期で画像を読み込み、終わったら画面更新
  void _loadImage(BuildContext context) async {
    final Image image = Image.asset("assets/images/beyan-alpha.png");

    // 読み込み完了を監視
    await precacheImage(image.image, context);

    // 読み込み終了したら更新
    setState(() {
      this.iconImage = image;
    });
  } // end of method

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    // 画面サイズに応じて画面を切り替え
    double displayHeight = MediaQuery.of(context).size.height;
    double displayWidth = MediaQuery.of(context).size.width;

    // 横幅で対応
    if (displayWidth < 640) {
      return this.createSmartPhonePage(context);
    } else {
      return this.createPcPage(context);
    }
  } // end of build

  Widget createPcPage(BuildContext context) {
    // 画面サイズに応じてウィジェット更新
    double displayHeight = MediaQuery.of(context).size.height;
    double contentHeight = displayHeight - widget.topbarHeight;
    double displayWidth = MediaQuery.of(context).size.width;
    double defaultContentWidth = 900;
    double contentWidth = math.min(displayWidth * 0.9, defaultContentWidth);

    // パディングは画面サイズ依存で
    double paddingTop = contentHeight * 0.2;
    double paddingMiddle = math.max(30, contentHeight * 0.05);

    // バッジの大きさは紹介Containerに収まるサイズ
    double badgeWidth = contentWidth / 4.5;
    double badgeFontSize = 20;

    // メインのコンテンツ
    return Container(
      key: this.profilePageKey,
      constraints: BoxConstraints(minHeight: contentHeight),
      child: Stack(
        children: [
          // 背景画像を繰り返す
          BackgroundImageWidget(
            imagePath: "assets/images/background/introduction.webp",
            imageHeight: 315,
            imageWidth: 315,
            parentWidgetKey: this.profilePageKey,
          ),

          Column(
            children: [
              SizedBox(height: paddingTop),
              Center(child: this.createIntroduce(context, contentWidth)),
              SizedBox(height: paddingMiddle),
              this.createSkilsetList(context, contentWidth, badgeWidth, badgeFontSize),
            ],
          ),
        ],
      ),
    );
  } // end of method
} // end of class


