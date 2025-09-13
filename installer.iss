; Inno Setup 安装脚本
; 用于打包 Simple Live App

[Setup]
AppName=Simple Live
AppVersion=1.9.3
AppPublisher=Simple Live Team
AppPublisherURL=https://github.com/xiaoyaocz/dart_simple_live
AppSupportURL=https://github.com/xiaoyaocz/dart_simple_live
AppUpdatesURL=https://github.com/xiaoyaocz/dart_simple_live
DefaultDirName={autopf}\Simple Live
DefaultGroupName=Simple Live
AllowNoIcons=yes
LicenseFile=
OutputDir=installer
OutputBaseFilename=SimpleLiveSetup
SetupIconFile=assets\logo.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1

[Files]
; 主程序文件
Source: "build\windows\x64\runner\Release\simple_live_app.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\windows\x64\runner\Release\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Simple Live"; Filename: "{app}\simple_live_app.exe"
Name: "{group}\{cm:UninstallProgram,Simple Live}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Simple Live"; Filename: "{app}\simple_live_app.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Simple Live"; Filename: "{app}\simple_live_app.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\simple_live_app.exe"; Description: "{cm:LaunchProgram,Simple Live}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

