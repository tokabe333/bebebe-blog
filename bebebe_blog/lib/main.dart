/// -------------------------------------------
///           main文とStatelessWidget
/// -------------------------------------------

import 'package:flutter/material.dart';

import './main_page/main_page_view.dart';

void main() {
  runApp(BebebeApp());
} // end of class

class BebebeApp extends StatelessWidget {
  BebebeApp({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material Appに書いてる",
      home: MainPageWidget(),
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 216, 243)),
        useMaterial3: true,
      ),
    );
  } // end of build
} // end of class
