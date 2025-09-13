@echo off
echo 设置Android SDK环境...

REM 创建Android SDK目录
if not exist "C:\Android\Sdk" mkdir "C:\Android\Sdk"

REM 设置环境变量
set ANDROID_HOME=C:\Android\Sdk
set ANDROID_SDK_ROOT=C:\Android\Sdk
set PATH=%PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin

echo 环境变量已设置
echo ANDROID_HOME=%ANDROID_HOME%
echo ANDROID_SDK_ROOT=%ANDROID_SDK_ROOT%

echo.
echo 请手动下载以下文件：
echo 1. Android SDK Command Line Tools
echo    下载链接: https://developer.android.com/studio#command-tools
echo 2. 解压到: C:\Android\Sdk\cmdline-tools\latest\
echo 3. 运行: flutter doctor --android-licenses
echo 4. 运行: flutter build apk --release

pause
