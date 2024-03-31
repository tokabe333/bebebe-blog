# Welcome to Beyan's Portfolio!!
[ここで公開しています！](https://beyan-connect.net/)

ポートフォリオページのフロント部分です。<br>
このリポジトリをご覧になられている方の参考になれば幸いです。<br>
ソースコードは lib フォルダにあります。
<br>

## Server Side
- Nginx 
- Django
- Spearly

## Front Side
- Flutter web
- Rive

<br>

# libフォルダ下の構成です

## site_frames
各ページの整形や上部バーなどサイト全体に影響するファイル群です。

- **main_frame** <br> 上部バーと4ページのコンテンツを持ちます。
- **main_frame_drawer** <br> アイコンをクリックしたときに表示されるドロワーメニューを作成します。
- **colors** <br> 色の統一感を出すために使用する色数を減らしています。
- **background_image** <br> Flutterでは背景画像を繰り返しで埋める機能が提供されていません。Stackを使って画像を等間隔に並べてタイル(小さな繰り返しパターン)から背景を生成します。
- **topbar** <br> 画面上部のバーを作ります。画面の横幅でパソコン版とスマホ版を切り替えます。
- **topbar_hover_text** <br> 上部バーに使用されているページの見出し文字です。マウスカーソルをホバーさせると色が変わります。

<br>

## contents
ここに1ページずつ作っています。

### main_page
1ページ目、アニメーションを表示します。

- **main_page_view** <br> アニメーションとゆっくりしていってねの文字を配置します。Stackで良い感じの場所に置くのに苦労しました。
- **demo_page_widget** <br> Riveアニメーションを読み込んで再生します。

### profile_page
経歴とスキルセットを表示します。UFOみたいな見た目がかわいい？

- **profile_page_view** <br> 経歴とボタンの配置をします。最初はPC版だけで考えていたので急遽buildを分割しました。

- **profile_page_smartphone** <br> 上記の仕様変更の名残です。作りながら試行錯誤しています。

- **profile_introduce** <br> 上段の経歴とアイコンです。スマホ版のときは上下に並べる実装で苦戦した記憶です。

- **skilset_text** <br> 中段のスキルセット一覧です。

- **skilset_badge** <br> 下部のスキルバッジ1つを作ります。ホバーして色を変えるのにハマっていたのでしょうね。

- **skilset_bade_list** <br> バッジを並べてくれます。

### portfolio_page
3ページ目の制作物です。ここを作るときにはFlutterにも少し慣れてきています。

- **portfolio_page_view** <br> いつもの並べてくれるやーつです。Widgetを作るコードと並べるコードに分離できるのが気持ち良いです。

- **portfolio_content_view** <br> 制作物1個を作ってくれます。ホバーしたらサイズを変えて少し影をつけます。

- **dialog_beyan-connet** <br> beyan-connetのブロックをクリックしたときに表示されるダイアログです。ここはCMSを導入していないので毎回Flutterで作る必要があります。

- **dialog_syunpujuku_app** <br> 私が勤務している塾で使用するアプリの予定です笑

### contact_page
せっかくなのでコンタクトフォームを作りました。GoogleFormで出来ないかなと調べてみましたが、JSONでフォームの回答をするAPIは提供されていないみたいです(2024/3月現在)

- **contact_page_view** <br> いつもの並べてくれるやつです。上位ウィジェットは並べることに徹して、下位ウィジェットは自身を生成することに徹すると管理が楽です。

- **contact_textform** <br> テキスト入力フォームを1個作れます。ヒントテキストに見える文字はStackで重ねているだけです笑。アニメーションをつける楽しさに芽生えてきた時期です。

- **send_button** <br> Riveアニメーションで動きをつけています。クリックすると裏でAPIが走ります。

- **apis_for_conact** <br> Google Formが使えないのでSpearly CMSを使用しています。外部のサービスやデータベースを使用するときのキーの隠し方は何が良いのでしょうか。今回は ユーザー↔Django↔CMS として間に自前APIを噛まして隠しています。
