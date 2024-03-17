// -------------------------------------------
//   beyan-connect.net のポートフォリオ詳細
// -------------------------------------------

import 'package:flutter/material.dart';

/// ダイアログ画面のウィジェット
class BeyanConnectDialogWidget extends StatefulWidget {
  const BeyanConnectDialogWidget({Key? key}) : super(key: key);

  @override
  State<BeyanConnectDialogWidget> createState() => BeyanConnectDialogView();
} // end of class

/// ダイアログ画面のビュー(状態)
class BeyanConnectDialogView extends State<BeyanConnectDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.only(top: 0, left: 0, bottom: 10, right: 10),
      content: this._createDialogContent(context),
      actions: [],
    );
  } // end of build

  /// ダイアログで実際に表示するコンテンツ
  Widget _createDialogContent(BuildContext context) {
    return Container(color: Colors.lightGreen);
  } // end of method
} // end of class
