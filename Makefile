# Flutter Windows Build Makefile
# 使用方法: make build 或 make run

# 配置变量
FLUTTER_PATH = C:\Users\15891\Desktop\flutter\bin\flutter.bat
PROJECT_DIR = .
BUILD_DIR = build\windows\runner\Release
DESKTOP_DIR = C:\Users\15891\Desktop\SimpleLiveApp

# 环境变量设置
ENV_VARS = set PUB_HOSTED_URL=https://pub.flutter-io.cn && set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# 默认目标
.PHONY: all
all: build

# 检查Flutter环境
.PHONY: doctor
doctor:
	@echo "检查Flutter环境..."
	$(ENV_VARS) && $(FLUTTER_PATH) doctor

# 获取依赖
.PHONY: deps
deps:
	@echo "获取项目依赖..."
	$(ENV_VARS) && $(FLUTTER_PATH) pub get

# 清理构建文件
.PHONY: clean
clean:
	@echo "清理构建文件..."
	$(ENV_VARS) && $(FLUTTER_PATH) clean
	if exist build rmdir /s /q build

# 构建Windows应用 (Release)
.PHONY: build
build: deps
	@echo "构建Windows应用 (Release)..."
	$(ENV_VARS) && $(FLUTTER_PATH) build windows --release
	@echo "构建完成！"

# 构建Windows应用 (Debug)
.PHONY: build-debug
build-debug: deps
	@echo "构建Windows应用 (Debug)..."
	$(ENV_VARS) && $(FLUTTER_PATH) build windows --debug
	@echo "构建完成！"

# 运行应用
.PHONY: run
run: deps
	@echo "运行应用..."
	$(ENV_VARS) && $(FLUTTER_PATH) run -d windows

# 复制到桌面
.PHONY: copy-to-desktop
copy-to-desktop: build
	@echo "复制应用到桌面..."
	if not exist "$(DESKTOP_DIR)" mkdir "$(DESKTOP_DIR)"
	if exist "$(BUILD_DIR)" xcopy /E /I /Y "$(BUILD_DIR)" "$(DESKTOP_DIR)"
	@echo "应用已复制到桌面: $(DESKTOP_DIR)"

# 完整构建并复制到桌面
.PHONY: deploy
deploy: clean build copy-to-desktop
	@echo "部署完成！应用位于: $(DESKTOP_DIR)"

# 检查构建结果
.PHONY: check-build
check-build:
	@echo "检查构建结果..."
	if exist "$(BUILD_DIR)\simple_live_app.exe" (
		echo "构建成功！可执行文件: $(BUILD_DIR)\simple_live_app.exe"
	) else (
		echo "构建失败！未找到可执行文件。"
	)

# 显示帮助信息
.PHONY: help
help:
	@echo "可用的命令:"
	@echo "  make doctor          - 检查Flutter环境"
	@echo "  make deps            - 获取项目依赖"
	@echo "  make clean           - 清理构建文件"
	@echo "  make build           - 构建Windows应用 (Release)"
	@echo "  make build-debug     - 构建Windows应用 (Debug)"
	@echo "  make run             - 运行应用"
	@echo "  make copy-to-desktop - 复制应用到桌面"
	@echo "  make deploy          - 完整构建并复制到桌面"
	@echo "  make check-build     - 检查构建结果"
	@echo "  make help            - 显示此帮助信息"


