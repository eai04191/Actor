# Actor
[![Total Download](https://img.shields.io/github/downloads/eai04191/Actor/total.svg)](https://github.com/eai04191/Actor/releases)

FFXIVで使うためのACTを一発で導入するツールです。

![Screenshot](https://i.imgur.com/HA6s2WJ.png)

## Disclaimer 免責条項
ACTは非公式の外部ツールです。
ACT及びActorを使用したことによって利用者がいかなる不利益を被ったとしても、__作者は一切の責任を負いません。__
必ず自己責任においてご利用ください。
また、ゲーム内チャットやその他TwitterなどでもACTを使っている旨は発言しないことをおすすめします。

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
5. ダウンロードしたプラグインの導入（任意）
6. 初期設定（任意）
  - `GameLanguage`: __日本語__
  - `ParseFilter`: __Party__
  - `Number of seconds to wait after the last combat action to begin a new encounter.`: __30__
  - [x] `Use WinPCap Network Driver`
7. ショートカットの作成（任意）

## 対象
- ACTを初めて使う人
- 新しいPCなどにACTをセットアップしたい人

インストール時に確認がありますが設定が初期化されるのですでに使用している人は注意してください。

# 使い方
1. [Releases](https://github.com/eai04191/Actor/releases)から最新の`Actor_vX.X.X.zip`をダウンロード・展開する。
2. ACTをインストールしたい場所まで展開した __フォルダごと__ 移動してActorを実行する。
3. おわり

## 設定を引き継いだまま最新のプラグイン・ACTにしたい
1. 新たにActorでインストールする。
    最後に聞かれる __コンフィグをインストールしますか?__ で __いいえ__ を選択する。

2. ACTを起動して`Plugins`から、古いプラグインを`Remove`（右上の×ボタン）する。

![Screenshot](https://i.imgur.com/Yxt6f7Z.png)

3. Actorフォルダの中にある

  - `ACT\plugin\FFXIV_ACT_Plugin\FFXIV_ACT_Plugin.dll`
  - `ACT\plugin\OverlayPlugin\OverlayPlugin.dll`
  - `ACT\plugin\Hojoring\ACT.SpecialSpellTimer.dll`
  - `ACT\plugin\Hojoring\ACT.TTSYukkuri.dll`
  - `ACT\plugin\Hojoring\ACT.UltraScouter.dll`

を`Browse...`から選んで`Add/Enable Plugin`する。

4. 最後にACTを再起動する。

## わからないことがある
[Github Issue](https://github.com/eai04191/Actor/issues/new)もしくは[Twitter](https://twitter.com/eai04191)かDiscord Eai#4693でお気軽にお問い合わせください。

---

## 以下のコードを利用しています
- [cocobelgica/AutoHotkey-JSON: JSON module for AutoHotkey](https://github.com/cocobelgica/AutoHotkey-JSON)

## License
MIT
