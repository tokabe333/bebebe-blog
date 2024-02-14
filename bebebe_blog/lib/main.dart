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
    return MainPageWidget();
  } // end of build
} // end of class
