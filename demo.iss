#define MyAppSetupName 'MyProgram'
#define MyAppVersion '6.0'

[Setup]
AppName={#MyAppSetupName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppSetupName} {#MyAppVersion}
AppCopyright=Copyright 2007-2015 stfx
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany=stfx
AppPublisher=stfx
OutputBaseFilename={#MyAppSetupName}-{#MyAppVersion}
DefaultGroupName={#MyAppSetupName}
DefaultDirName={pf}\{#MyAppSetupName}
UninstallDisplayIcon={app}\MyProgram.exe
OutputDir=bin
SourceDir=.
AllowNoIcons=yes
SolidCompression=yes
ShowLanguageDialog=no

;Downloading and installing dependencies will only work if the memo/ready page is enabled (default behaviour)
;DisableReadyPage=no
;DisableReadyMemo=no

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "ja"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "src\MyProgram.exe"; DestDir: "{app}"
Source: "scripts\isxdl\japanese.ini"; Flags: dontcopy

[Icons]
Name: "{group}\{#MyAppSetupName}"; Filename: "{app}\MyProgram.exe"

[Run]
Filename: "{app}\MyProgram.exe"; Description: "{cm:LaunchProgram,{#MyAppSetupName}}"; Flags: nowait postinstall skipifsilent

#include "scripts\products.iss"
#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"
#include "scripts\products\dotnetfx45.iss"
#include "japanese.iss"

[Code]
function InitializeSetup(): boolean;
begin
  // .NET Framework 4.0 Client OR Full以降が入っていれば動くプログラム
  if (not netfxinstalled(NetFx40Client, '') and not netfxinstalled(NetFx40Full, '')) then begin
    //存在しない場合、.NET Framework 4.5.2をインストールする(ただし4.5.0以降がインストール済みなら何もしない)
  	dotnetfx45(50); 
  end;
  Result := true;
end;
