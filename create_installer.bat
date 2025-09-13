@echo off
echo 创建 Simple Live 安装程序
echo =========================

REM 检查 Inno Setup 是否安装
where iscc >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo 错误: 未找到 Inno Setup 编译器 (iscc.exe)
    echo 请先安装 Inno Setup: https://jrsoftware.org/isinfo.php
    echo.
    echo 或者使用以下替代方案:
    echo 1. 使用 NSIS (Nullsoft Scriptable Install System)
    echo 2. 使用 Advanced Installer
    echo 3. 使用 WiX Toolset
    pause
    exit /b 1
)

REM 创建输出目录
if not exist installer mkdir installer

REM 编译安装程序
echo 正在编译安装程序...
iscc installer.iss

if %ERRORLEVEL% EQU 0 (
    echo.
    echo 安装程序创建成功！
    echo 位置: installer\SimpleLiveSetup.exe
    echo.
    echo 您可以运行 installer\SimpleLiveSetup.exe 来安装应用
) else (
    echo.
    echo 安装程序创建失败！
    echo 请检查 installer.iss 文件是否有错误
)

pause

