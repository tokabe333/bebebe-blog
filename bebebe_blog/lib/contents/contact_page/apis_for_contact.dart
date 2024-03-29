// -------------------------------------------
//         メインページ(自己紹介)
// 初回起動はデモを表示する(/にアクセスしたら /homeはデモなし)
// -------------------------------------------

import 'package:easy_animate/animation/fade_in_animation.dart';
import 'package:easy_animate/enum/animate_direction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import './contact_page_view.dart';

extension ApisForContact on ContactPageView {
  // CMSのバージョンを取得するAPI
  Future<int> asyncCallCmsFormVersion() async {
    return 0;
  } // end of method
} // end of extension
