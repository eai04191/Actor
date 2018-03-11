#NoEnv
SetWorkingDir %A_ScriptDir%
FileEncoding, UTF-8
#Include <JSON>

ACT := Object()
ACT.fileurl := "http://advancedcombattracker.com/includes/page-download.php?id=57"

FFXIV_ACT_Plugin := Object()
FFXIV_ACT_Plugin.owner := "ravahn"
FFXIV_ACT_Plugin.repo := "FFXIV_ACT_Plugin"

Hojoring := Object()
Hojoring.owner := "anoyetta"
Hojoring.repo := "ACT.Hojoring"

OverlayPlugin := Object()
OverlayPlugin.owner := "hibiyasleep"
OverlayPlugin.repo := "OverlayPlugin"

title := "Actor"
version := "2.0.0"
windowtitle := title " v" version
Log := ""
Progress := 0

Gui, Font,S9 , ＭＳ ゴシック
Gui, Add, Edit,ReadOnly Multi w500 r15 vLog
Gui, Font
Gui, Add, Button, Default gInstall w100, インストール
; Gui, Add, Progress,yp+2 x+5 w395 vProgress
Gui, Show, Center AutoSize, %windowtitle%

Log("==================================================================")
Log(" _____     _           ")
Log("|  _  |___| |_ ___ ___  Advanced  Combat  Tracker")
Log("|     |  _|  _| . |  _| One-click Ready for FFXIV")
Log("|__l__|___|_| |___|_|   version " version)
Log("                       ")
Log("==================================================================")
Log("準備完了")

GuiControl,,Log, %Log%
Return

URLDownloadToVar(url) {
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", url, true)
    whr.Send()
    whr.WaitForResponse()
    Return whr.ResponseText
}

GetJson(owner, repo, isUsePreRelease){
    url = https://api.github.com/repos/%owner%/%repo%/releases/latest
    Return URLDownloadToVar(url)
}

ParseJson(project) {
    project.json := JSON.Load(GetJson(project.owner, project.repo, false))
    project.fileurl := project.json.assets.1.browser_download_url
    project.filename := project.json.assets.1.name
}

Unzip(filepath, extractpath) {
    RunWait, util\7za.exe x %filepath% -o%extractpath%
}

Download(url, saveto) {
    ; -L --location リダイレクトを許可
    ; -k --insecure SSL認証エラーを無視
    ; -Y --speed-limit 速度の最小値
    ; -y --speed-time 値の時間分 -Y 以下の速度になったら失敗させる
    RunWait, util\curl.exe %url% -L -k --retry 5 -Y 1 -y 10 -o %saveto%
}

Log(message) {
    global Log
    Gui, Submit, NoHide
    FormatTime, timestamp,, HH:mm:ss
    newvalue := Log . "[" . timestamp . "] " . message . "`n"
    GuiControl,, Log, %newvalue%
    ControlSend, Edit1, ^{End}
    Gui, Submit, NoHide
}


InstallConfig() {
    Log("コンフィグをインストール")
    FileCreateDir, % A_AppData . "\Advanced Combat Tracker\Config"
    FileRead, ACTconfig, config\Advanced Combat Tracker.config.xml
    StringReplace, ACTconfig, ACTconfig, ACTPATH, % A_ScriptDir . "\ACT", All
    FileAppend, % ACTconfig, % A_AppData . "\Advanced Combat Tracker\Config\Advanced Combat Tracker.config.xml"
    FileCopy, config\FFXIV_ACT_Plugin.config.xml, % A_AppData . "\Advanced Combat Tracker\Config\", 1
}

GuiClose:
    FileAppend, % Log, Actor.log
    ExitApp

Install:
    GuiControl, Disable, インストール
    GuiControl, Text, インストール, インストール中

    Log("ACTフォルダがあるかチェックします")
    if(FileExist("ACT")){
        Log("ACTフォルダが見つかりました")
        Try {
            FileExist("ACT_old")
            FileRemoveDir % "ACT_old", 1
            FileMoveDir, ACT, ACT_old, R
        } Catch e {
            MsgBox, 64, % windowtitle, すでに存在しているACTフォルダを移動できませんでした。`n先にACTを終了させてください。
            Goto, GuiClose
        }
    }else{
        Log("ACTフォルダは見つかりませんでした")
    }


    Log("ダウンロード用フォルダを準備")
    FileRemoveDir % "actor_download", 1
    FileCreateDir % "actor_download"


    MsgBox, 36, % windowtitle, 動作に必要なランタイム類`n･Visual Studio 2017 用 Microsoft Visual C++ 再頒布可能パッケージ`n･Microsoft .NET Framework 4.7`n･Win10Pcap`nをダウンロード・インストールしますか?`n`nよくわからなければ [はい] を選択してください。
    IfMsgBox, Yes
    {
        MsgBox, 64, % windowtitle, インストール中に再起動を求められた場合 [あとで再起動する] を選択し、`nすべての処理が完了してから再起動してください。

        dotNetfx47_URL = http://go.microsoft.com/fwlink/?linkid=825298
        Win10Pcap_URL = http://www.win10pcap.org/download/Win10Pcap-v10.2-5002.msi
        If (A_Is64bitOS) {
            VC_URL = https://go.microsoft.com/fwlink/?LinkId=746572
        } Else {
            VC_URL = https://go.microsoft.com/fwlink/?LinkId=746571
        }

        Log("Visual Studio 2017 用 Microsoft Visual C++ 再頒布可能パッケージをダウンロード")
        Download(VC_URL, "actor_download\" . "VC.exe")
        Log("Visual Studio 2017 用 Microsoft Visual C++ 再頒布可能パッケージをインストール")
        RunWait, actor_download\VC.exe /passive /promptrestart

        Log(".NET Framework 4.7をダウンロード")
        Download(dotNetfx47_URL, "actor_download\" . "dotNetfx47.exe")
        Log(".NET Framework 4.7をインストール")
        RunWait, actor_download\dotNetfx47.exe /passive /promptrestart

        Log("Win10Pcapをダウンロード")
        URLDownloadToFile % Win10Pcap_URL, % A_ScriptDir . "\actor_download\Win10Pcap.msi"
        Download(Win10Pcap_URL, "actor_download\" . "Win10Pcap.msi")
        Log("Win10Pcapをインストール")
        RunWait, actor_download\Win10Pcap.msi /passive /promptrestart

        Log("ランタイム類の準備が完了しました")
    }


    Log("最新のファイル情報を取得します")

    parseJson(FFXIV_ACT_Plugin)
    Log("FFXIV_ACT_Plugin")
    Log("URL: " FFXIV_ACT_Plugin.fileurl)

    parseJson(Hojoring)
    Log("Hojoring")
    Log("URL: " Hojoring.fileurl)

    parseJson(OverlayPlugin)
    If (A_Is64bitOS)
    { ; 64bit
        OverlayPlugin.fileurl := OverlayPlugin.json.assets.1.browser_download_url
        OverlayPlugin.filename := OverlayPlugin.json.assets.1.name
    }
    Else If (OverlayPlugin.json.assets.3.name)
    { ; 32bit FullとPatch両方リリースの場合
        OverlayPlugin.fileurl := OverlayPlugin.json.assets.3.browser_download_url
        OverlayPlugin.filename := OverlayPlugin.json.assets.3.name
    }
    Else
    { ; 32bit Fullリリースのみの場合
        OverlayPlugin.fileurl := OverlayPlugin.json.assets.2.browser_download_url
        OverlayPlugin.filename := OverlayPlugin.json.assets.2.name
    }
    Log("OverlayPlugin")
    Log("URL: " OverlayPlugin.fileurl)



    Log("ACTをダウンロード")
    Download(ACT.fileurl, "actor_download\" . "ACT.zip")
    Log("ACTを展開")
    Unzip("actor_download\" . "ACT.zip", "ACT")

    Log("FFXIV_ACT_Pluginをダウンロード")
    Download(FFXIV_ACT_Plugin.fileurl, "actor_download\" . FFXIV_ACT_Plugin.filename)
    Log("FFXIV_ACT_Pluginを展開")
    Unzip("actor_download\" . FFXIV_ACT_Plugin.filename, "ACT\plugin\FFXIV_ACT_Plugin")

    Log("Hojoringをダウンロード")
    Download(Hojoring.fileurl, "actor_download\" . Hojoring.filename)
    Log("Hojoringを展開")
    Unzip("actor_download\" . Hojoring.filename, "ACT\plugin\Hojoring")

    Log("OverlayPluginをダウンロード")
    Download(OverlayPlugin.fileurl, "actor_download\" . OverlayPlugin.filename)
    Log("OverlayPluginを展開")
    Unzip("actor_download\" . OverlayPlugin.filename, "ACT\plugin\OverlayPlugin")

    if(FileExist(A_AppData "\Advanced Combat Tracker\Config")){
        MsgBox, 36, Actor, コンフィグをインストールしますか?`n既存のコンフィグは移動されます。
        IfMsgBox, Yes
        {
            Log("既存のコンフィグを移動")
            Log("移動先: " A_AppData "\Advanced Combat Tracker\Config_old")
            FileRemoveDir, % A_AppData . "\Advanced Combat Tracker\Config_old", 1
            FileMoveDir, % A_AppData . "\Advanced Combat Tracker\Config", % A_AppData . "\Advanced Combat Tracker\Config_old"
            InstallConfig()
        }
    }else {
        InstallConfig()
    }

    MsgBox, 36, Actor, デスクトップにショートカットを作成しますか?
    IfMsgBox, Yes
    {
        If (A_Is64bitOS) {
            Log("ショートカットを作成")
            FileCreateShortcut, % A_ScriptDir . "\ACT\Advanced Combat Tracker.exe", % A_Desktop . "\Advanced Combat Tracker.lnk"
        }
        Else {
            Log("ショートカットを作成(x86)")
            FileCreateShortcut, % A_ScriptDir . "\ACT\ACTx86.exe", % A_Desktop . "\Advanced Combat Tracker(x86).lnk"
        }
    }

    Log("ダウンロード用フォルダを削除")
    FileRemoveDir, % "actor_download", 1

    MsgBox, 64, Actor, すべての処理が完了しました
    Log("すべての処理が完了しました")

    Gui, Add, Button, Default gGuiClose w100 xp+0 yp+0, 終了