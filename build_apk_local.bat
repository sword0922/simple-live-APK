@echo off
echo 本地构建APK（需要Android SDK）...

REM 设置环境变量
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

echo 检查Flutter环境...
C:\Users\15891\Desktop\flutter\bin\flutter.bat doctor

echo.
echo 如果Android工具链显示为绿色勾号，按任意键继续构建APK...
pause

echo 进入项目目录...
cd simple_live_app

echo 获取依赖...
C:\Users\15891\Desktop\flutter\bin\flutter.bat pub get

echo 构建APK...
C:\Users\15891\Desktop\flutter\bin\flutter.bat build apk --release

if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo.
    echo APK构建成功！
    echo 文件位置: build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo 复制APK到桌面...
    copy "build\app\outputs\flutter-apk\app-release.apk" "C:\Users\15891\Desktop\SimpleLiveApp.apk"
    echo APK已复制到桌面: SimpleLiveApp.apk
) else (
    echo.
    echo APK构建失败！请检查Android SDK安装。
)

pause
