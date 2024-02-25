/// -------------------------------------------
///    取得したリポジトリ一覧をもとにコンテナを作る
/// -------------------------------------------

import 'package:flutter/material.dart';

import './github_page_view.dart';

extension GithubRepositoryContainer on GithubPageView {
  Widget createRepositoryContainer(List repositoryInfo) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 234, 234, 234),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Color.fromARGB(255, 198, 198, 198), offset: Offset(2, 2)),
        ],
      ),
    );
  }
} // end of extension