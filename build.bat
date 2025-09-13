@echo off
REM Flutter Windows Build Script
REM 使用方法: build.bat [命令]

set FLUTTER_PATH=C:\Users\15891\Desktop\flutter\bin\flutter.bat
set PROJECT_DIR=.
set BUILD_DIR=build\windows\runner\Release
set DESKTOP_DIR=C:\Users\15891\Desktop\SimpleLiveApp

REM 设置环境变量
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

if "%1"=="" goto help
if "%1"=="help" goto help
if "%1"=="doctor" goto doctor
if "%1"=="deps" goto deps
if "%1"=="clean" goto clean
if "%1"=="build" goto build
if "%1"=="build-debug" goto build-debug
if "%1"=="run" goto run
if "%1"=="copy" goto copy
if "%1"=="deploy" goto deploy
if "%1"=="check" goto check
goto help

:doctor
echo 检查Flutter环境...
%FLUTTER_PATH% doctor
goto end

:deps
echo 获取项目依赖...
%FLUTTER_PATH% pub get
goto end

:clean
echo 清理构建文件...
%FLUTTER_PATH% clean
if exist build rmdir /s /q build
goto end

:build
echo 构建Windows应用 (Release)...
%FLUTTER_PATH% build windows --release
if %ERRORLEVEL% EQU 0 (
    echo 构建成功！
) else (
    echo 构建失败！请检查Visual Studio安装。
)
goto end

:build-debug
echo 构建Windows应用 (Debug)...
%FLUTTER_PATH% build windows --debug
if %ERRORLEVEL% EQU 0 (
    echo 构建成功！
) else (
    echo 构建失败！请检查Visual Studio安装。
)
goto end

:run
echo 运行应用...
%FLUTTER_PATH% run -d windows
goto end

:copy
echo 复制应用到桌面...
if not exist "%DESKTOP_DIR%" mkdir "%DESKTOP_DIR%"
if exist "%BUILD_DIR%" (
    xcopy /E /I /Y "%BUILD_DIR%" "%DESKTOP_DIR%"
    echo 应用已复制到桌面: %DESKTOP_DIR%
) else (
    echo 构建目录不存在！请先运行 build 命令。
)
goto end

:deploy
echo 开始完整部署...
call :clean
call :build
if %ERRORLEVEL% EQU 0 (
    call :copy
    echo 部署完成！应用位于: %DESKTOP_DIR%
) else (
    echo 部署失败！构建过程中出现错误。
)
goto end

:check
echo 检查构建结果...
if exist "%BUILD_DIR%\simple_live_app.exe" (
    echo 构建成功！可执行文件: %BUILD_DIR%\simple_live_app.exe
) else (
    echo 构建失败！未找到可执行文件。
)
goto end

:help
echo.
echo Flutter Windows 构建脚本
echo ========================
echo.
echo 使用方法: build.bat [命令]
echo.
echo 可用命令:
echo   doctor      - 检查Flutter环境
echo   deps        - 获取项目依赖
echo   clean       - 清理构建文件
echo   build       - 构建Windows应用 (Release)
echo   build-debug - 构建Windows应用 (Debug)
echo   run         - 运行应用
echo   copy        - 复制应用到桌面
echo   deploy      - 完整构建并复制到桌面
echo   check       - 检查构建结果
echo   help        - 显示此帮助信息
echo.
echo 示例:
echo   build.bat build     - 构建应用
echo   build.bat deploy    - 构建并复制到桌面
echo.

:end
pause


