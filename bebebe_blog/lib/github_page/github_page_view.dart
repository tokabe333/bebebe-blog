/// -------------------------------------------
///         Githubページ(TOPとかコミット状況とか)
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main_frame.dart';
import './github_api_util.dart';
import './github_repository_container.dart';

class GithubPageWidget extends StatefulWidget {
  GithubPageWidget({Key? key}) : super(key: key);
  final String title = "べーやん's Site";
  State<GithubPageWidget> createState() => GithubPageView();
} // end of class

class GithubPageView extends State<GithubPageWidget> {
  /// リポジトリ一覧を取得するAPI
  String _repositoryAPI = "https://api.github.com/users/tokabe333/repos";

  /// 取得する予定のリポジトリ一覧(非同期でget)
  Future<List>? futureRepositories;

  /// 取得したリポジトリ一覧
  List? repositories;

  /// 作成したリポジトリコンテナ
  Widget? repositoryContainers;

  /// すでに取得したリポジトリを表示したか
  bool displayedRepositories = false;

  /// 最初にリポジトリ一覧を取得する
  GithubPageView() {
    this.futureRepositories = this.getRepositorys(this._repositoryAPI);
  } // end of constructor

  /// ウィジェットサイズ取得
  GlobalKey? mainContentKey;

  @override
  Widget build(BuildContext context) {
    return MainFrame(title: "beyan's home", page: this._createGithubPage(context));
  } // end of build

  /// GitHubページを作成する
  Widget _createGithubPage(BuildContext context) {
    /// 読み込みが終わったらもう一度setStateする
    this.futureRepositories!.then((repos) {
      if (this.displayedRepositories == false) {
        setState(() {});
        this.displayedRepositories = true;
      }
      this.repositories = repos;
    });

    // リポジトリ一覧のウィジェット
    if (this.repositories != null && this.repositoryContainers == null) {
      List<Widget> containers = [];
      for (var i = 0; i < this.repositories!.length; ++i) {
        containers.add(this.createRepositoryContainer(this.repositories![i]));
      }

      this.repositoryContainers = GridView.extent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: MainFrameView.mainContentWidth * 0.04,
        crossAxisSpacing: MainFrameView.mainContentWidth * 0.02,
        padding: EdgeInsets.all(MainFrameView.mainContentWidth * 0.02),
        children: containers,
      );
    }

    // print("画面サイズ : ${MediaQuery.of(context).size!.width}");
    // print("ウィジェットサイズ : ${MainFrameView.mainContentWidth}");

    return Center(
        key: this.mainContentKey,
        child: Container(
          color: Color.fromARGB(255, 94, 175, 171),
          width: double.infinity,
          height: 2000,
          child: repositoryContainers,
        ));
  }
} // end of class
