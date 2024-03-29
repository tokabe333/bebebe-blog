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
    Uri uri = Uri.http("beyan-connect.net", "apis/portfolio_page/call_csm_form_version");
    // ヘッダーの設定
    Map<String, String> headers = {'content-type': 'application/json'};

    // GET通信
    http.Response resp = await http.get(uri, headers: headers);

    // 通信失敗時は虚無を返す
    if (resp.statusCode != 200) {
      print("通信失敗 : ${resp.statusCode}");
      return -1;
    }

    // 通信成功したがstatus ngの場合
    Map<String, dynamic> responseBody = jsonDecode(resp.body);
    //print(responseBody.toString());
    if (responseBody.containsKey("form") == false) {
      print("form not contained ${responseBody}");
      return -1;
    }
    responseBody = responseBody["form"];
    if (responseBody.containsKey("id") == false) {
      print("id not contained ${responseBody}");
      return -1;
    }

    // 通信成功してデータも取れたら返す(ReportModel型に変換するのは他の処理にまかせる)
    return responseBody["id"];
  } // end of method

  /// CSMのフォームにJSONで新規コメントを追加する
  Future<bool> asyncSetCsmFormComment({required String name, required String email, required String comment}) async {
    // POSTはヘッダーに特に値が入らない
    Uri uri = Uri.http("beyan-connect.net", "apis/portfolio_page/set_csm_form_comment");
    // ヘッダーの設定
    Map<String, String> headers = {'content-type': 'application/json'};
    // bodyにデータを書き込む
    Map<String, String> body = {
      "name": name,
      "email": email,
      "comment": comment,
    };

    // POST通信
    http.Response resp = await http.post(uri, headers: headers, body: jsonEncode(body));

    print("resp.body : ${resp.body}");

    // 正しく送信できたか
    return resp.statusCode != 200 && resp.statusCode != 201;
  } // end of method
} // end of extension
