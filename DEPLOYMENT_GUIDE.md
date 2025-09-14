# Simple Live 部署指南

本指南将帮助您使用GitHub Actions进行全平台自动化构建和部署。

## 📋 目录

- [准备工作](#准备工作)
- [GitHub Actions配置](#github-actions配置)
- [构建类型说明](#构建类型说明)
- [Android签名配置](#android签名配置)
- [发布流程](#发布流程)
- [故障排除](#故障排除)

## 🚀 准备工作

### 1. 启用GitHub Actions

1. 进入GitHub仓库
2. 点击 "Settings" 标签
3. 在左侧菜单中找到 "Actions" → "General"
4. 确保 "Allow all actions and reusable workflows" 被选中
5. 点击 "Save"

### 2. 检查项目结构

确保您的项目包含以下文件：
```
.github/
├── workflows/
│   ├── build.yml              # 基础构建
│   ├── build-matrix.yml       # 矩阵构建（推荐）
│   ├── build-optimized.yml    # 优化构建
│   ├── build-with-cache.yml   # 缓存构建
│   ├── android-signing.yml    # Android签名
│   ├── release.yml            # 发布构建
│   └── ci.yml                 # 持续集成
├── scripts/
│   └── build_all.sh          # 构建脚本
└── dependabot.yml            # 依赖更新
```

## ⚙️ GitHub Actions配置

### 工作流说明

| 工作流文件 | 用途 | 触发条件 | 推荐度 |
|-----------|------|----------|--------|
| `ci.yml` | 代码检查、测试 | 推送、PR | ⭐⭐⭐⭐⭐ |
| `build-matrix.yml` | 矩阵构建 | 推送、标签、手动 | ⭐⭐⭐⭐⭐ |
| `build-optimized.yml` | 优化构建 | 推送、标签、手动 | ⭐⭐⭐⭐ |
| `build-with-cache.yml` | 缓存构建 | 推送、标签、手动 | ⭐⭐⭐⭐ |
| `android-signing.yml` | Android签名 | 手动 | ⭐⭐⭐ |
| `release.yml` | 发布构建 | 标签、手动 | ⭐⭐⭐⭐⭐ |

### 推荐配置

1. **日常开发**: 使用 `ci.yml` 进行代码检查
2. **功能测试**: 使用 `build-matrix.yml` 进行快速构建
3. **正式发布**: 使用 `release.yml` 进行完整构建和发布

## 🔨 构建类型说明

### 1. 持续集成 (CI)

**文件**: `ci.yml`
**用途**: 代码质量检查
**包含**:
- 代码分析 (`flutter analyze`)
- 单元测试 (`flutter test`)
- 依赖检查 (`flutter pub deps`)
- 构建检查 (Debug构建)

### 2. 矩阵构建

**文件**: `build-matrix.yml`
**用途**: 高效的并行构建
**特点**:
- 并行构建所有平台
- 资源利用率高
- 构建速度快

### 3. 优化构建

**文件**: `build-optimized.yml`
**用途**: 功能丰富的构建
**特点**:
- 支持选择性构建
- 多架构支持
- 构建通知
- 详细的构建产物

### 4. 缓存构建

**文件**: `build-with-cache.yml`
**用途**: 加速构建过程
**特点**:
- Gradle缓存
- Flutter依赖缓存
- Dart依赖缓存
- 构建速度提升50%+

## 📱 Android签名配置

### 准备工作

1. **生成签名密钥**:
```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. **获取Base64编码**:
```bash
base64 -i upload-keystore.jks
```

### 使用签名构建

1. 进入GitHub Actions页面
2. 选择 "Android签名构建" 工作流
3. 点击 "Run workflow"
4. 填写以下信息：
   - **Keystore Base64**: 上一步获取的Base64字符串
   - **Keystore密码**: 创建密钥时设置的密码
   - **Key别名**: 通常是 "upload"
   - **Key密码**: 创建密钥时设置的密码
   - **应用类型**: 选择要构建的应用

### 安全注意事项

- 签名密钥信息仅在构建过程中使用
- 构建完成后会自动清理敏感文件
- 建议使用GitHub Secrets存储密钥信息

## 🚀 发布流程

### 1. 自动发布

**步骤**:
1. 创建版本标签：
```bash
git tag v1.0.0
git push origin v1.0.0
```

2. GitHub Actions会自动：
   - 构建所有平台
   - 创建GitHub Release
   - 上传构建产物
   - 生成发布说明

### 2. 手动发布

**步骤**:
1. 进入GitHub Actions页面
2. 选择 "创建发布" 工作流
3. 点击 "Run workflow"
4. 输入版本标签（如：v1.0.0）
5. 点击 "Run workflow"

### 3. 发布内容

每个发布包含：
- **Android**: APK和AAB文件
- **Windows**: ZIP压缩包
- **macOS**: ZIP压缩包
- **Linux**: tar.gz压缩包
- **Web**: ZIP压缩包
- **控制台**: 可执行文件

## 🛠️ 故障排除

### 常见问题

#### 1. 构建失败

**症状**: GitHub Actions显示红色❌
**解决方案**:
1. 点击失败的作业查看详细日志
2. 检查Flutter版本兼容性
3. 确认依赖配置正确
4. 运行 `flutter doctor` 检查环境

#### 2. Android构建失败

**症状**: Android相关作业失败
**解决方案**:
1. 检查Java版本配置
2. 确认Android SDK设置
3. 检查 `build.gradle` 配置
4. 验证签名配置

#### 3. 依赖问题

**症状**: `pub get` 失败
**解决方案**:
1. 检查 `pubspec.yaml` 语法
2. 确认依赖版本兼容性
3. 清理缓存：`flutter clean`
4. 重新获取依赖：`flutter pub get`

#### 4. 缓存问题

**症状**: 构建产物异常
**解决方案**:
1. 清理GitHub Actions缓存
2. 重新运行构建
3. 检查缓存键配置

### 调试技巧

#### 1. 查看构建日志

1. 进入GitHub Actions页面
2. 点击失败的作业
3. 展开失败的步骤
4. 查看详细日志

#### 2. 本地复现问题

1. 克隆仓库到本地
2. 安装相同版本的Flutter
3. 运行相同的构建命令
4. 对比错误信息

#### 3. 分步调试

1. 先运行CI检查
2. 再运行单个平台构建
3. 最后运行完整构建

## 📚 最佳实践

### 1. 版本管理

- 使用语义化版本号（如：v1.0.0）
- 为重要版本创建标签
- 保持版本号一致性

### 2. 构建优化

- 使用缓存构建提高速度
- 并行构建多个平台
- 选择性构建减少资源消耗

### 3. 安全考虑

- 不要在代码中硬编码密钥
- 使用GitHub Secrets存储敏感信息
- 定期轮换签名密钥

### 4. 监控和维护

- 定期检查构建状态
- 及时更新依赖版本
- 监控构建时间和资源使用

## 🔗 相关链接

- [GitHub Actions文档](https://docs.github.com/actions)
- [Flutter CI/CD指南](https://docs.flutter.dev/deployment/ci)
- [Android签名指南](https://developer.android.com/studio/publish/app-signing)
- [Git标签管理](https://git-scm.com/book/en/v2/Git-Basics-Tagging)

## 🤝 支持

如果您遇到问题，请：

1. 查看本文档的故障排除部分
2. 检查GitHub Actions构建日志
3. 在GitHub Issues中报告问题
4. 提供详细的错误信息和复现步骤

---

**注意**: 首次使用GitHub Actions时，建议先运行CI检查确保代码质量，然后再进行完整构建。
