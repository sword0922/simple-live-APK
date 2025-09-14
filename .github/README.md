# GitHub Actions 构建说明

本项目使用GitHub Actions进行全平台自动化构建。

## 支持的平台

- **Android**: APK 和 AAB 格式
- **TV应用**: Android TV 专用版本
- **Windows**: 可执行文件
- **Linux**: 可执行文件
- **macOS**: 应用程序包
- **Web**: 静态网站
- **控制台应用**: 命令行工具

## 触发条件

构建会在以下情况下自动触发：

1. **推送代码**: 推送到 `main` 或 `master` 分支
2. **创建标签**: 创建以 `v` 开头的标签（如 `v1.0.0`）
3. **Pull Request**: 向 `main` 或 `master` 分支提交PR
4. **手动触发**: 在GitHub Actions页面手动运行

## 构建产物

### 普通构建
- 构建产物会作为Artifacts上传到GitHub Actions
- 可以在Actions页面的"Artifacts"部分下载

### 标签构建（发布版本）
- 当创建标签时，会自动创建GitHub Release
- 所有平台的构建产物会附加到Release中
- 自动生成发布说明

## 构建流程

1. **环境准备**: 设置Flutter/Dart环境
2. **依赖安装**: 安装项目依赖
3. **平台构建**: 并行构建所有平台
4. **产物打包**: 压缩构建产物
5. **上传**: 上传到GitHub Artifacts或Release

## 本地构建

如果需要本地构建，可以使用以下命令：

```bash
# 构建Android
flutter build apk --release
flutter build appbundle --release

# 构建Windows
flutter build windows --release

# 构建Linux
flutter build linux --release

# 构建macOS
flutter build macos --release

# 构建Web
flutter build web --release
```

## 注意事项

1. **iOS构建**: 由于需要Apple开发者账号和证书，暂未包含在CI中
2. **签名**: Android和macOS应用需要配置签名才能在设备上安装
3. **依赖**: 确保所有依赖都在`pubspec.yaml`中正确声明
4. **版本**: 构建版本号会自动从`pubspec.yaml`中读取

## 故障排除

### 构建失败
1. 检查Flutter版本兼容性
2. 确认所有依赖都已正确安装
3. 查看构建日志中的具体错误信息

### 依赖问题
1. 运行 `flutter pub get` 更新依赖
2. 检查 `pubspec.yaml` 中的版本约束
3. 清理构建缓存：`flutter clean`

### 平台特定问题
- **Android**: 确保Android SDK已正确安装
- **Windows**: 需要Visual Studio和Windows SDK
- **Linux**: 需要安装GTK开发库
- **macOS**: 需要Xcode和macOS SDK
