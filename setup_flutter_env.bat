@echo off
echo 设置Flutter国内镜像源...

REM 设置Flutter镜像
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

REM 设置Dart镜像
set PUB_CACHE=C:\Users\15891\Desktop\flutter\.pub-cache

echo 环境变量已设置
echo PUB_HOSTED_URL=%PUB_HOSTED_URL%
echo FLUTTER_STORAGE_BASE_URL=%FLUTTER_STORAGE_BASE_URL%
echo PUB_CACHE=%PUB_CACHE%

REM 运行Flutter命令
C:\Users\15891\Desktop\flutter\bin\flutter.bat %*

pause


