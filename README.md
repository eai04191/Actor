# Actor
[![Total Download](https://img.shields.io/github/downloads/eai04191/Actor/total.svg)](https://github.com/eai04191/Actor/releases)

FFXIVで使うためのACTを一発で導入するツールです。

![Screenshot](https://i.imgur.com/A7G3mYT.png)

## Actorがしてくれること

### ランタイム類インストール
ACTを動かすために必要なソフト類のインストール
 - Visual Studio 2017 用 Microsoft Visual C++ 再頒布可能パッケージ
 - .NET Framework 4.7
 - Win10Pcap

### ACTインストール
1. [Advanced Combat Tracker](http://advancedcombattracker.com/)最新版のダウンロード
2. [FFXIV_ACT_Plugin](https://github.com/ravahn/FFXIV_ACT_Plugin)最新版のダウンロード
3. [OverlayPlugin](https://github.com/hibiyasleep/OverlayPlugin)(hibiyasleep氏の版)最新版のダウンロード
4. [Hojoring](https://github.com/anoyetta/ACT.Hojoring)最新版のダウンロード
5. ダウンロードしたプラグインの導入
6. 初期設定
    * `GameLanguage`: __日本語__
    * `ParseFilter`: __Party__
    * `Number of seconds to wait after the last combat action to begin a new encounter.`: __30__
    * [x] `Use WinPCap Network Driver`
7. ショートカットの作成

## 対象
- ACTを初めて使う人
- 新しいPCなどにACTをセットアップしたい人

インストール時に確認がありますが設定が初期化されるのですでに使用している人は注意してください。

# 使い方
1. [Releases](https://github.com/eai04191/Actor/releases)から最新の`Actor_vX.X.X.zip`をダウンロード・展開する。
2. ACTをインストールしたい場所まで展開した __フォルダごと__ 移動してActorを実行する。
3. おわり

## 設定を引き継いだまま最新のプラグイン、ACTにしたいんだけど……
インストールを終えた後 __コンフィグをインストールしますか?__ で __いいえ__ を選択してください。

その後ATCを起動して`Plugins`から

  - `ACT\plugin\FFXIV_ACT_Plugin\FFXIV_ACT_Plugin.dll`
  - `ACT\plugin\OverlayPlugin\OverlayPlugin.dll`
  - `ACT\plugin\Hojoring\ACT.SpecialSpellTimer.dll`
  - `ACT\plugin\Hojoring\ACT.TTSYukkuri.dll`
  - `ACT\plugin\Hojoring\ACT.UltraScouter.dll`

を`Add`してください。

## わからないことがある
[Issue](https://github.com/eai04191/Actor/issues/new)、[Twitter](https://twitter.com/eai04191)でお気軽にお聞きください。

---

## 以下のコードを利用しています
- [Native Zip and Unzip XP/Vista/7 [AHK_L] - Scripts and Functions - AutoHotkey Community](https://autohotkey.com/board/topic/60706-native-zip-and-unzip-xpvista7-ahk-l/)
- [cocobelgica/AutoHotkey-JSON: JSON module for AutoHotkey](https://github.com/cocobelgica/AutoHotkey-JSON)

## License
MIT
