# GitHub Actions 全平台构建配置

本项目已配置完整的GitHub Actions工作流，支持全平台自动化构建。

## 📁 文件结构

```
.github/
├── workflows/
│   ├── build.yml          # 基础构建工作流
│   ├── build-matrix.yml   # 矩阵构建工作流（推荐）
│   ├── release.yml        # 发布工作流
│   ├── ci.yml            # 持续集成工作流
│   └── template.yml      # 工作流模板
├── scripts/
│   └── build_all.sh      # 构建脚本
├── dependabot.yml        # 依赖更新配置
└── README.md            # GitHub Actions说明
```

## 🚀 工作流说明

### 1. 持续集成 (ci.yml)
- **触发**: 推送到主分支或创建PR
- **功能**: 代码分析、测试、依赖检查、构建检查
- **用途**: 确保代码质量，防止破坏性更改

### 2. 矩阵构建 (build-matrix.yml) - 推荐使用
- **触发**: 推送到主分支、创建标签、手动触发
- **功能**: 并行构建所有平台
- **优势**: 效率高，资源利用率好

### 3. 基础构建 (build.yml)
- **触发**: 推送到主分支、创建标签、手动触发
- **功能**: 顺序构建所有平台
- **用途**: 备用方案，资源需求较低

### 4. 发布构建 (release.yml)
- **触发**: 创建版本标签、手动触发
- **功能**: 构建所有平台并创建GitHub Release
- **用途**: 正式版本发布

## 🎯 支持的平台

| 平台 | 应用 | 格式 | 状态 |
|------|------|------|------|
| Android | simple_live_app | APK, AAB | ✅ |
| Android | simple_live_tv_app | APK, AAB | ✅ |
| Windows | simple_live_app | ZIP | ✅ |
| Linux | simple_live_app | tar.gz | ✅ |
| macOS | simple_live_app | ZIP | ✅ |
| Web | simple_live_app | ZIP | ✅ |
| 控制台 | simple_live_console | 可执行文件 | ✅ |
| iOS | simple_live_app | - | ❌ (需要证书) |

## 📋 使用方法

### 自动构建
1. **推送代码**: 推送到 `main` 或 `master` 分支
2. **创建标签**: 创建以 `v` 开头的标签（如 `v1.0.0`）
3. **Pull Request**: 向主分支提交PR

### 手动构建
1. 进入GitHub仓库的Actions页面
2. 选择相应的工作流
3. 点击"Run workflow"按钮
4. 选择分支并运行

### 创建发布
1. 创建版本标签：`git tag v1.0.0`
2. 推送标签：`git push origin v1.0.0`
3. GitHub Actions会自动构建并创建Release

## 🔧 配置说明

### 环境变量
- `PUB_HOSTED_URL`: Flutter包镜像地址
- `FLUTTER_STORAGE_BASE_URL`: Flutter存储镜像地址

### Flutter版本
- 当前使用: `3.24.0`
- 渠道: `stable`

### Java版本
- Android构建使用: `17`

## 📦 构建产物

### 普通构建
- 产物上传到GitHub Actions Artifacts
- 可在Actions页面下载
- 保留7天

### 发布构建
- 产物附加到GitHub Release
- 永久保存
- 自动生成发布说明

## 🛠️ 自定义配置

### 修改Flutter版本
编辑工作流文件中的 `flutter-version` 字段：
```yaml
- name: 设置Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.24.0'  # 修改这里
```

### 添加新平台
1. 在矩阵中添加新的平台配置
2. 添加相应的构建步骤
3. 配置产物上传

### 修改触发条件
编辑工作流的 `on` 部分：
```yaml
on:
  push:
    branches: [ main, master, develop ]  # 添加分支
  schedule:
    - cron: '0 0 * * 1'  # 每周一运行
```

## 🐛 故障排除

### 构建失败
1. 检查Flutter版本兼容性
2. 确认依赖配置正确
3. 查看构建日志

### 依赖问题
1. 运行 `flutter pub get`
2. 检查 `pubspec.yaml`
3. 清理缓存：`flutter clean`

### 平台特定问题
- **Android**: 确保Android SDK配置正确
- **Windows**: 需要Visual Studio
- **Linux**: 需要GTK开发库
- **macOS**: 需要Xcode

## 📚 相关链接

- [GitHub Actions文档](https://docs.github.com/actions)
- [Flutter CI/CD指南](https://docs.flutter.dev/deployment/ci)
- [subosito/flutter-action](https://github.com/subosito/flutter-action)

## 🤝 贡献

如需修改GitHub Actions配置，请：
1. 创建功能分支
2. 修改相应的工作流文件
3. 提交Pull Request
4. 等待CI检查通过

---

**注意**: 首次使用GitHub Actions时，需要在仓库设置中启用Actions功能。
