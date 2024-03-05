/// -------------------------------------------
///    取得したリポジトリ一覧をもとにコンテナを作る
/// -------------------------------------------

import 'package:flutter/material.dart';

import './github_page_view.dart';

/// コンテナ用のウィジェット(各ウィジェットが独立して状態を保持する必要がある)
class GitHubContainerWidget extends StatefulWidget {
  GitHubContainerWidget({Key? key}) : super(key: key);

  State<GitHubContainerWidget> createState() => GitHubContainerView();
} // end of class

class GitHubContainerView extends State<GitHubContainerWidget> {
  bool _flag = false;
  int _duration = 600;
  Color _firstColor = const Color.fromARGB(128, 234, 234, 234);
  Color _mainColor = const Color.fromARGB(255, 234, 234, 234);
  //Color _mainColor = Colors.blue;

  GitHubContainerView() {
    // 画面描画後に状態を変えてフェードさせる
    Future.delayed(Duration(milliseconds: 10), () {
      this._flag = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // 上下にパディングを作って移動しているように見せる
    return Column(children: [
      AnimatedContainer(
        duration: Duration(milliseconds: this._duration),
        height: this._flag ? 0 : 15,
      ),
      // ここが本体
      Expanded(
          child: AnimatedContainer(
        duration: Duration(milliseconds: this._duration),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this._flag ? this._mainColor : this._firstColor,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Color.fromARGB(255, 198, 198, 198), offset: Offset(2, 2)),
          ],
        ),
      )),
      AnimatedContainer(duration: Duration(milliseconds: this._duration), height: this._flag ? 15 : 0),
    ]);
  }
} // end of class

extension GithubRepositoryContainer on GithubPageView {
  /// 浮き上がりながらフェードインしたい
  Widget createRepositoryContainer(List repositoryInfo) {
    return GitHubContainerWidget();
  }
} // end of extension

