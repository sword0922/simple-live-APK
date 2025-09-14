#!/bin/bash

# 全平台构建脚本
# 用于GitHub Actions自动化构建

set -e

echo "开始全平台构建..."

# 设置环境变量
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# 检查Flutter环境
echo "检查Flutter环境..."
flutter doctor

# 构建Android应用
build_android() {
    echo "构建Android应用..."
    cd simple_live_app
    flutter pub get
    flutter build apk --release
    flutter build appbundle --release
    cd ..
    echo "Android应用构建完成"
}

# 构建TV应用
build_tv_app() {
    echo "构建TV应用..."
    cd simple_live_tv_app
    flutter pub get
    flutter build apk --release
    flutter build appbundle --release
    cd ..
    echo "TV应用构建完成"
}

# 构建Windows应用
build_windows() {
    echo "构建Windows应用..."
    cd simple_live_app
    flutter pub get
    flutter build windows --release
    cd ..
    echo "Windows应用构建完成"
}

# 构建Linux应用
build_linux() {
    echo "构建Linux应用..."
    cd simple_live_app
    flutter pub get
    flutter build linux --release
    cd ..
    echo "Linux应用构建完成"
}

# 构建macOS应用
build_macos() {
    echo "构建macOS应用..."
    cd simple_live_app
    flutter pub get
    flutter build macos --release
    cd ..
    echo "macOS应用构建完成"
}

# 构建Web应用
build_web() {
    echo "构建Web应用..."
    cd simple_live_app
    flutter pub get
    flutter build web --release
    cd ..
    echo "Web应用构建完成"
}

# 构建控制台应用
build_console() {
    echo "构建控制台应用..."
    cd simple_live_console
    dart pub get
    dart compile exe bin/simple_live_console.dart -o simple_live_console
    cd ..
    echo "控制台应用构建完成"
}

# 根据参数执行相应的构建
case "$1" in
    "android")
        build_android
        ;;
    "tv")
        build_tv_app
        ;;
    "windows")
        build_windows
        ;;
    "linux")
        build_linux
        ;;
    "macos")
        build_macos
        ;;
    "web")
        build_web
        ;;
    "console")
        build_console
        ;;
    "all")
        build_android
        build_tv_app
        build_windows
        build_linux
        build_macos
        build_web
        build_console
        ;;
    *)
        echo "用法: $0 {android|tv|windows|linux|macos|web|console|all}"
        exit 1
        ;;
esac

echo "构建完成！"
