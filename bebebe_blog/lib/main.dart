/// -------------------------------------------
///           main文とStatelessWidget
/// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import 'main_page/start_page_view.dart';
import './main_page/main_page_view.dart';
import './github_page/github_page_view.dart';

void main() {
  runApp(BebebeApp());
} // end of class

class BebebeApp extends StatelessWidget {
  BebebeApp({super.key}) {}

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "beyan's home page",
    //   home: MainPageWidget(),
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 226, 216, 243)),
    //     useMaterial3: true,
    //   ),
    // );
    /// VRouterでページごとに /hogehoge にする
    return VRouter(
      debugShowCheckedModeBanner: false,
      mode: VRouterMode.history,
      buildTransition: (animation, ___, child) {
        return child;
      },
      routes: [
        VWidget(path: "/", widget: MainPageWidget()),
        VWidget(path: "/home", widget: MainPageWidget()),
        VWidget(path: "/github", widget: GithubPageWidget()),
        VWidget(path: "/contact", widget: MainPageWidget()),
        VRouteRedirector(path: r'*', redirectTo: "/"),
      ],
    );
  } // end of build
} // end of class
