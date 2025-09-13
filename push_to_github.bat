@echo off
echo 推送代码到GitHub进行APK构建...

REM 初始化Git仓库（如果还没有）
if not exist ".git" (
    echo 初始化Git仓库...
    git init
    git add .
    git commit -m "Initial commit: Simple Live App"
)

REM 添加远程仓库
echo 请先在GitHub上创建仓库，然后运行以下命令：
echo.
echo git remote add origin https://github.com/您的用户名/您的仓库名.git
echo git branch -M main
echo git push -u origin main
echo.
echo 或者手动推送代码到GitHub仓库

echo.
echo 推送完成后，GitHub Actions将自动开始构建APK
echo 您可以在仓库的 Actions 标签页查看构建进度
echo 构建完成后，APK文件将在 Releases 页面下载

pause
