# GitHub Actions 快速开始指南

## 🚀 5分钟快速设置

### 1. 启用GitHub Actions

1. 进入您的GitHub仓库
2. 点击 **Settings** → **Actions** → **General**
3. 选择 **"Allow all actions and reusable workflows"**
4. 点击 **Save**

### 2. 推送代码

将GitHub Actions配置文件推送到仓库：

```bash
git add .github/
git commit -m "添加GitHub Actions全平台构建配置"
git push origin main
```

### 3. 查看构建状态

1. 进入GitHub仓库的 **Actions** 标签页
2. 您会看到以下工作流：
   - ✅ **持续集成** - 代码检查
   - 🔨 **矩阵构建全平台应用** - 完整构建
   - 📦 **创建发布** - 版本发布

## 🎯 常用操作

### 立即构建所有平台

1. 进入 **Actions** 页面
2. 选择 **"矩阵构建全平台应用"**
3. 点击 **"Run workflow"**
4. 选择分支并运行

### 创建新版本发布

```bash
# 创建版本标签
git tag v1.0.0

# 推送标签（自动触发发布构建）
git push origin v1.0.0
```

### 只构建特定平台

1. 进入 **Actions** 页面
2. 选择 **"优化构建全平台应用"**
3. 点击 **"Run workflow"**
4. 选择构建类型：
   - `android` - 只构建Android
   - `desktop` - 只构建桌面应用
   - `web` - 只构建Web应用
   - `console` - 只构建控制台应用

## 📱 构建产物

### 普通构建
- 产物保存在 **Actions** → **Artifacts**
- 可下载到本地
- 保留7天

### 版本发布
- 产物附加到 **Releases**
- 永久保存
- 自动生成发布说明

## 🔧 Android签名构建

### 准备签名文件

```bash
# 生成签名密钥
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# 获取Base64编码
base64 -i upload-keystore.jks
```

### 运行签名构建

1. 进入 **Actions** 页面
2. 选择 **"Android签名构建"**
3. 点击 **"Run workflow"**
4. 填写签名信息：
   - **Keystore Base64**: 上一步获取的字符串
   - **Keystore密码**: 创建密钥时的密码
   - **Key别名**: upload
   - **Key密码**: 创建密钥时的密码

## ⚡ 性能优化

### 使用缓存构建

选择 **"缓存优化构建"** 工作流，构建速度提升50%+

### 并行构建

**"矩阵构建全平台应用"** 使用并行构建，效率最高

## 🐛 常见问题

### 构建失败怎么办？

1. 点击失败的作业查看日志
2. 检查错误信息
3. 常见解决方案：
   - 运行 `flutter clean`
   - 检查依赖版本
   - 确认Flutter环境

### 如何查看构建进度？

1. 进入 **Actions** 页面
2. 点击正在运行的作业
3. 查看实时日志

### 构建产物在哪里？

- **普通构建**: Actions → Artifacts
- **版本发布**: Releases → 下载

## 📚 更多信息

- 📖 [完整部署指南](DEPLOYMENT_GUIDE.md)
- 🔧 [GitHub Actions配置说明](.github/README.md)
- 📋 [项目配置说明](GITHUB_ACTIONS_SETUP.md)

## 🆘 需要帮助？

1. 查看构建日志中的错误信息
2. 参考故障排除指南
3. 在GitHub Issues中报告问题

---

**提示**: 首次使用建议先运行CI检查，确保代码质量后再进行完整构建。
