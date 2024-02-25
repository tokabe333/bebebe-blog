/// -------------------------------------------
///         Githubページ(TOPとかコミット状況とか)
/// -------------------------------------------

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main_frame.dart';

class GithubPageWidget extends StatefulWidget {
  GithubPageWidget({Key? key}) : super(key: key);
  final String title = "べーやん's Site";
  State<GithubPageWidget> createState() => GithubPageView();
} // end of class

class GithubPageView extends State<GithubPageWidget> {
  /// リポジトリ一覧を取得するAPI
  String repositoryAPI = "https://api.github.com/users/tokabe333/repos";

  @override
  Widget build(BuildContext context) {
    return MainFrame(title: "beyan's home", page: this._createGithubPage(context));
  } // end of build

  /// Githubからリポジトリ一覧を取得
  Future<List> getRepositorys(String url) async {
    var response = await http.get(Uri.parse(url));
    List body = jsonDecode(response.body);
    return body;
  }

  Widget _createGithubPage(BuildContext context) {
    return Center(
        child: Container(
      color: Color.fromARGB(255, 136, 210, 206),
      width: double.infinity,
      height: 2000,
      // child: Image.asset(
      //   "images/test_body.jpg",
      // ),
    ));
  }
} // end of class
