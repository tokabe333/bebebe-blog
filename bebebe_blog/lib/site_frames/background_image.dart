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
    required String this.imagePath,
    required double this.imageHeight,
    required double this.imageWidth,
    required GlobalKey this.parentWidgetKey,
  }) : super(key: key);

  /// 表示する背景画像パス
  final String imagePath;

  /// 読み込む画像サイズ
  final double imageHeight;

  /// 読み込む画像サイズ
  final double imageWidth;

  /// 背景フィールドのサイズを調べるためのキー
  final GlobalKey parentWidgetKey;

  @override
  State<BackgroundImageWidget> createState() =>
      BackgroundImageView(imagePath, imageHeight, imageWidth, parentWidgetKey);
} // end of class

class BackgroundImageView extends State<BackgroundImageWidget> {
  /// 繰り返す背景画像
  Image? backgroundImage;

  /// 背景を表示するフィールド

  /// 読み込む画像のパス
  String imagePath;

  /// 読み込んだ画像のサイズ(厳密には別のリーダーで読む)
  double imageHeight;

  /// 読み込んだ画像のサイズ
  double imageWidth;

  /// 背景フィールドのサイズを調べるためのキー
  GlobalKey parentWidgetKey;

  /// コンテンツの大きさとパスはwidget.よりコンストラクタで受け取る方が便利
  BackgroundImageView(
    String this.imagePath,
    double this.imageHeight,
    double this.imageWidth,
    GlobalKey this.parentWidgetKey,
  );

  @override
  void didChangeDependencies() async {
    this._loadImage(context);
    super.didChangeDependencies();
  }

  /// 非同期で画像を読み込み、終わったら画面更新
  void _loadImage(BuildContext context) async {
    final Image image = Image.asset(widget.imagePath);

    // 読み込み完了を監視
    await precacheImage(image.image, context);

    // 読み込み終了したら更新
    setState(() {
      this.backgroundImage = image;
    });
  } // end of method

  @override
  Widget build(BuildContext context) {
    // 読み込み終わっていなければ虚無を返す
    if (this.backgroundImage == null) {
      return SizedBox();
    }

    // 親ウィジェットのサイズを調べる(まだ作られていなければ何もしない)
    RenderObject? renderObj = this.parentWidgetKey.currentContext?.findRenderObject();
    RenderBox? renderBox = renderObj == null ? null : renderObj as RenderBox;
    double? parentWidth = renderBox?.size.width;
    double? parentHeight = renderBox?.size.height;
    if (parentWidth == null || parentHeight == null) {
      // とりあえず0.2秒後にもう一度見てみる
      Future.delayed(Duration(milliseconds: 200)).then((_) {
        setState(() {});
      });
      return SizedBox();
    }

    // 画面サイズと画像サイズ
    // 繰り返し回数
    int hnum = (parentWidth! / imageWidth).ceil();
    int vnum = (parentHeight! / imageHeight).ceil() + 1;

    print("parentHeight:${parentHeight} parentWidth:${parentWidth} hnum:${hnum} vnum:${vnum}");

    // 同じウィジェットをたくさんつくる
    List<Widget> backgrounds = [];
    for (int i = 0; i < vnum; ++i) {
      for (int j = 0; j < hnum; ++j) {
        backgrounds.add(Positioned(
          // 下に超えるとコンテンツの大きさが変わってしまう
          top: parentHeight - (i + 1) * this.imageHeight,
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



