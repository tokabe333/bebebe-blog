/// -------------------------------------------
///    取得したリポジトリ一覧をもとにコンテナを作る
/// -------------------------------------------

import 'package:flutter/material.dart';

import './github_page_view.dart';

extension GithubRepositoryContainer on GithubPageView {
  Widget createRepositoryContainer(List repositoryInfo) {
    return Container(
      width: 100,
      height: 100,
      color: Color.fromARGB(255, 255, 0, 0),
      // decoration: BoxDecoration(color: Color.fromARGB(0, 71, 71, 71), borderRadius: BorderRadius.circular(10)),
    );
  }
} // end of extension