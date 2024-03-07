/// -------------------------------------------
///         メインページ(自己紹介)
/// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
/// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';

import '../../site_frames/main_frame.dart';

class ProfilePageWidget extends StatefulWidget {
  ProfilePageWidget({Key? key}) : super(key: key);

  State<ProfilePageWidget> createState() => ProfilePageView();
} // end of class

class ProfilePageView extends State<ProfilePageWidget> {
  @override
  void initState() {}

  /// メインコンテンツ(デモとサイト紹介)を作成
  @override
  Widget build(BuildContext context) {
    return Container();
  }
} // end of class


