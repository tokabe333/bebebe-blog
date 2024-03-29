// -------------------------------------------
//     Rive state machine を利用したボタン
//  https://github.com/rive-app/rive-flutter/blob/master/example/lib/example_state_machine.dart
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SendButtonWidget extends StatefulWidget {
  const SendButtonWidget({Key? key, required Function this.sendComment}) : super(key: key);

  /// JSONデータを送信する
  final Function sendComment;

  @override
  State<SendButtonWidget> createState() => SendButtonView();
} // end of class

class SendButtonView extends State<SendButtonWidget> {
  Artboard? _riveArtBoard;
  StateMachineController? _controller;
  SMIInput<bool>? _hoverInput;
  SMIInput<bool>? _pressInput;

  /// メッセージの送信待ち状態(ボタンが押された)
  bool waitingSendMessage = false;

  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/animations/send_button.riv").then((data) async {
      print(RiveFile.needsTextRuntime(data));

      await RiveFile.initializeText();
      // バイナリデータを開く
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;
      this._controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
      if (this._controller != null) {
        artboard.addController(this._controller!);
        this._hoverInput = this._controller!.findInput("hvr?");
        this._pressInput = this._controller!.findInput('clck?');
      } else {
        print("コントローラーが見つかりません");
      }

      setState(() => this._riveArtBoard = artboard);
    });
  } // end of initState

  @override
  Widget build(BuildContext context) {
    Widget? clippedArtboard;
    if (this._riveArtBoard != null) {
      clippedArtboard = Rive(artboard: this._riveArtBoard!);
      clippedArtboard = Transform.scale(scale: 5, child: clippedArtboard);

      clippedArtboard = ClipRect(
        child: Align(
          alignment: Alignment.center,
          widthFactor: 0.2,
          heightFactor: 0.2,
          child: clippedArtboard,
        ),
      );
      clippedArtboard = Container(decoration: BoxDecoration(border: Border.all(width: 1)), child: clippedArtboard);
    }

    return MouseRegion(
      onEnter: (_) => this._hoverInput?.value = true,
      onExit: (_) => this._hoverInput?.value = false,
      child: InkWell(
        // onTap: () => this._pressInput?.value = true,
        onTapDown: (_) {
          this._pressInput?.value = true;
          this.waitingSendMessage = true;
          print("send button いまから実行");
          widget.sendComment.call();
          print("sendbutton 終了");
        },
        onTapUp: (_) => this._pressInput?.value = false,
        onTapCancel: () {
          this._pressInput?.value = false;
          this._hoverInput?.value = false;
        },
        child: clippedArtboard ?? const Text("Null", style: TextStyle(fontSize: 20)),
      ),
    );
  } // end of build
} // end of class
 