/// -------------------------------------------
///         Githubと通信してリポジトリ一覧を取得
/// -------------------------------------------

import 'package:http/http.dart' as http;
import 'dart:convert';

import './github_page_view.dart';

extension GithubApiUtil on GithubPageView {
  /// Githubからリポジトリ一覧を取得
  Future<List> getRepositorys(String url) async {
    var response = await http.get(Uri.parse(url));
    List body = jsonDecode(response.body);
    for (var i = 0; i < body.length; ++i) {
      body[i] = [body[i]["name"], body[i]["url"], body[i]["created_at"], body[i]["updated_at"], body[i]["language"]];
    }

    return body;
  } // end of method
} // end of extension
