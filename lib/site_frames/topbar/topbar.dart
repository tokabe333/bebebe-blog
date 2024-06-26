// -------------------------------------------
//            画面左部に表示するバー
//         各ページへのリンクを並べたい
// -------------------------------------------

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../site_frames/colors.dart';

import './topbar_hover_text.dart';

class Topbar extends StatefulWidget implements PreferredSizeWidget {
  const Topbar({
    Key? key,
    required double this.height,
    required GlobalKey<ScaffoldState> this.scaffoldKey,
    required ItemScrollController? this.mainContentsScrollControler,
  }) : super(key: key);

  /// トップバーの高さ、以降はこれが基準
  final double height;

  /// Drawerをいじる用、MainFrameのscaffoldを取得
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// メインコンテンツをスクロールするためのコントローラー
  final ItemScrollController? mainContentsScrollControler;

  /// これをオーバーライドすることでPreferredSizeWidgetになってAppBarに表示できる
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<Topbar> createState() => TopbarView();
} // end of class

/// 画面上部に表示するバー
class TopbarView extends State<Topbar> {
  /// メインコンテンツサイズ
  double topbarContentWidth = 600;

  // ハンバーガーメニューを置く場所(左から何割の場所か)
  double hamburgerButtonPlace = 0.1;

  /// 画面右上部に表示するナビゲーション
  final List<Widget> tabs = [];

  /// 画面左上に表示するアイコン画像
  // Widget iconImage = Image.asset("images/fox_logo_alpha.png", fit: BoxFit.contain);
  Widget iconImage = Image.asset("images/beyan-alpha.png", fit: BoxFit.contain);

  /// main_frameからDrawerを呼び出すためのkey
  // final GlobalKey<TopbarView> _topbarViewKey = GlobalKey<TopbarView>();

  /// フォントをタップした際のスクロール処理
  void scrollOnTap(int index) {
    widget.mainContentsScrollControler?.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
    );
  } // end of method

  /// 画面上部のタブバーを作成する
  void _createTopTabs(BuildContext context) {
    this.tabs.add(InkWell(
        onTap: () => this.scrollOnTap(0),
        child: HyperLinkText(
          text: "トップ",
          fontSize: 15,
          onTap: () => this.scrollOnTap(0),
        )));
    this.tabs.add(InkWell(
        onTap: () => this.scrollOnTap(1),
        child: HyperLinkText(
          text: "プロフィール",
          fontSize: 15,
          onTap: () => this.scrollOnTap(1),
        )));
    this.tabs.add(InkWell(
        onTap: () => this.scrollOnTap(2),
        child: HyperLinkText(
          text: "制作物",
          fontSize: 15,
          onTap: () => this.scrollOnTap(2),
        )));
    this.tabs.add(InkWell(
        onTap: () => this.scrollOnTap(3),
        child: HyperLinkText(
          text: "連絡先",
          fontSize: 15,
          onTap: () => this.scrollOnTap(3),
        )));
    this.tabs.add(const SizedBox(width: 20));
    // this.tabs.add(this._createBottomIcon(path: "images/qiita.png", hyperLink: "https://qiita.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(path: "images/github.png", hyperLink: "https://github.com/tokabe333/"));
    this.tabs.add(this._createBottomIcon(path: "images/atcoder.png", hyperLink: "https://atcoder.jp/users/tokabe333"));
    this.tabs.add(this._createBottomIcon(path: "images/twitter_blue.png", hyperLink: "https://twitter.com/tokabe333"));
    this.tabs.add(this._createBottomIcon(path: "images/youtube_red.png", hyperLink: "https://www.youtube.com/channel/UCS2o5U1Aom8AgK4Pn1MI16w"));
  }

  @override
  void initState() {
    // 画面上部のバーを作成する
    this._createTopTabs(context);

    widget.scaffoldKey.currentState?.openDrawer();

    super.initState();
  } // end of initState

  @override
  Widget build(BuildContext context) {
    // 左右のパディング
    double displayWidth = MediaQuery.of(context).size.width;
    double padding = (displayWidth - this.topbarContentWidth) / 2;

    if (padding >= 0) {
      return this._createDefaultTopbar(displayWidth, padding);
    } else {
      return this._createDrawerTopBar(context);
    }
  } // end of build

  /// 大きさが足りているときは横長のバー
  Widget _createDefaultTopbar(double displayWidth, double padding) {
    // トップバーの配置
    return Container(
      width: displayWidth,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: padding, right: padding),
      // color: const Color.fromARGB(255, 184, 184, 184),
      color: Colors.white.withOpacity(0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // アイコン
          InkWell(
            onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
            child: Container(height: widget.height, margin: const EdgeInsets.only(left: 40), child: this.iconImage),
          ),

          // 右上タブ
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: this.tabs,
              ),
            ),
          ),
        ],
      ),
    );
  } // end of method

  /// スマホなど幅が小さい画面のときに表示するバー
  Widget _createDrawerTopBar(BuildContext context) {
    // 横幅を計算
    double displayWidth = MediaQuery.of(context).size.width;
    double paddingLeft = displayWidth * this.hamburgerButtonPlace;

    // Drawerを起動するハンバーガーボタン
    Widget hamburgerButton = SizedBox(
      width: widget.height * 0.7,
      height: widget.height * 0.7,
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0),
        // backgroundColor: const Color.fromARGB(128, 11, 127, 223),
        child: InkWell(
          onTap: () {
            widget.scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(
            Icons.dehaze_rounded,
            color: MyColor.mainblue,
            // color: Colors.white,
          ),
        ),
      ),
    );

    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              SizedBox(width: paddingLeft),
              Flexible(child: hamburgerButton),
            ],
          )),
          // アイコン
          InkWell(
            onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
            child: SizedBox(height: widget.height, child: this.iconImage),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  } // end of method

  /// 外部リンクへのアイコンを作る(BottomではなくTop)
  Widget _createBottomIcon({required String path, String hyperLink = ""}) {
    return Container(
        height: 50,
        width: 20,
        margin: const EdgeInsets.only(left: 7, right: 7),
        child: InkWell(
          child: Image.asset(path),
          onTap: () async {
            final url = Uri.parse(hyperLink);
            if (await canLaunchUrl(url)) {
              launchUrl(url);
            }
          },
        ));
  } // end of method
} // end of class
