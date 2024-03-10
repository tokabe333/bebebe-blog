/// -------------------------------------------
///    ポートフォリオ一覧を出せるように頑張る
/// -------------------------------------------

import 'package:bebebe_blog/site_frames/content_frame/content_frame.dart';
import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;
import 'dart:io';

class BackgroundImageWidget extends StatefulWidget {
  const BackgroundImageWidget({
    Key? key,
    required double this.contentHeight,
    required String this.imagePath,
    required double this.imageHeight,
    required double this.imageWidth,
  }) : super(key: key);

  /// 背景を表示するフィールド
  final double contentHeight;

  /// 表示する背景画像パス
  final String imagePath;

  /// 読み込む画像サイズ
  final double imageHeight;
  final double imageWidth;

  @override
  State<BackgroundImageWidget> createState() => BackgroundImageView(contentHeight, imagePath, imageHeight, imageWidth);
} // end of class

class BackgroundImageView extends State<BackgroundImageWidget> {
  /// 繰り返す背景画像
  Image? backgroundImage;

  /// 背景を表示するフィールド
  double contentHeight;

  /// 読み込む画像のパス
  String imagePath;

  /// 読み込んだ画像のサイズ(厳密には別のリーダーで読む)
  double imageHeight;

  /// 読み込んだ画像のサイズ
  double imageWidth;

  /// コンテンツの大きさとパスはwidget.よりコンストラクタで受け取る方が便利
  BackgroundImageView(
      double this.contentHeight, String this.imagePath, double this.imageHeight, double this.imageWidth);

  @override
  void didChangeDependencies() async {
    this._loadImage(context);
    super.didChangeDependencies();
  }

  /// 非同期で画像を読み込み、終わったら画面更新
  void _loadImage(BuildContext context) async {
    print("画像読み込み開始");
    final Image image = Image.asset(widget.imagePath);

    // 読み込み完了を監視
    await precacheImage(image.image, context);
    print("画像読み込み終了");

    // 読み込み終了したら更新
    setState(() {
      print("setstate");
      this.backgroundImage = image;
    });
  } // end of method

  @override
  Widget build(BuildContext context) {
    if (this.backgroundImage == null) {
      return Container();
    }

    // 画面サイズと画像サイズ
    double displayWidth = MediaQuery.of(context).size.width;
    // 繰り返し回数
    int hnum = (displayWidth / imageWidth).ceil();
    int vnum = (this.contentHeight / imageHeight).ceil() + 1;

    // 同じウィジェットをたくさんつくる
    List<Widget> backgrounds = [];
    for (int i = 0; i < vnum; ++i) {
      for (int j = 0; j < hnum; ++j) {
        backgrounds.add(Positioned(
          // 下に超えるとコンテンツの大きさが変わってしまう
          top: contentHeight - i * this.imageHeight,
          left: j * this.imageWidth,
          child: this.backgroundImage!,
        ));
      }
    }

    return SizedBox(
      width: this.imageWidth * hnum,
      height: imageHeight * (vnum - 1),
      child: Stack(children: backgrounds),
    );
  } // end of build
} // end of class



