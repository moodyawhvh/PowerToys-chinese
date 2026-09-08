---
description: 'Top-level AI contributor guidance for developing PowerToys - a collection of Windows productivity utilities'
applyTo: '**'
---

> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。

# PowerToys – AI 贡献者指南

这是面向 AI 参与 PowerToys 开发的顶层指引。保持变更原子化,遵循既有模式,并在 PR 中给出确切的文件路径。

## 概览

PowerToys 是一套面向高级用户的实用工具集,用于调校和精简 Windows 体验。

| 领域 | 位置 | 说明 |
|------|------|------|
| Runner | `src/runner/` | 主可执行程序、托盘图标、模块加载器、快捷键管理 |
| 设置界面 | `src/settings-ui/` | 通过命名管道通信的 WinUI/WPF 配置应用 |
| 模块 | `src/modules/` | 各个 PowerToys 实用工具(各自独立子文件夹) |
| 公共库 | `src/common/` | 共享代码:日志、IPC、设置、DPI、遥测、工具类 |
| 构建工具 | `tools/build/` | 构建脚本与自动化 |
| 文档 | `doc/devdocs/` | 开发者文档 |
| 安装程序 | `installer/` | 基于 WiX 的安装项目 |

架构细节与模块类型见[架构总览](doc/devdocs/core/architecture.md)。

## 规范

详细的编码规范见:

- [编码指南](doc/devdocs/development/guidelines.md) – 依赖、测试、PR 管理
- [代码风格](doc/devdocs/development/style.md) – 格式化,C++/C#/XAML 风格规则
- [日志](doc/devdocs/development/logging.md) – C++ spdlog 与 C# Logger 用法

### 组件专属说明

在对应区域工作时,以下说明文件会被自动应用:

- [Runner 与设置界面](.github/instructions/runner-settings-ui.instructions.md) – IPC 契约、schema 迁移
- [公共库](.github/instructions/common-libraries.instructions.md) – ABI 稳定性、共享代码准则

## 构建

### 前置条件

- Visual Studio 2022 17.4+ 或 Visual Studio 2026
- Windows 10 1803+(2018 年 4 月更新或更高)
- 初始化一次子模块:`git submodule update --init --recursive`

### 构建命令

| 任务 | 命令 |
|------|------|
| 首次构建 / NuGet 还原 | `tools\build\build-essentials.cmd` |
| 构建当前文件夹 | `tools\build\build.cmd` |
| 带选项构建 | `build.ps1 -Platform x64 -Configuration Release` |

### 构建纪律

1. 每个操作一个终端(构建 → 测试),中途不要切换或新开终端
2. 修改完成后,`cd` 到发生变更的项目文件夹(`.csproj`/`.vcxproj`)
3. 用脚本构建:`tools/build/build.ps1` 或 `tools/build/build.cmd`
4. 首次构建或缺少 NuGet 包时,先运行 `build-essentials.cmd`
5. **退出码 0 = 成功;非零 = 失败** – 把这条当铁律
6. 失败时阅读错误日志:`build.<config>.<platform>.errors.log`
7. 构建成功之前不要启动测试或运行 Runner

### 构建日志

位于被构建的解决方案/项目旁边:

- `build.<configuration>.<platform>.errors.log` – 仅错误(优先查看)
- `build.<configuration>.<platform>.all.log` – 完整日志
- `build.<configuration>.<platform>.trace.binlog` – 供 MSBuild Structured Log Viewer 使用

完整细节见[构建指南](tools/build/BUILD-GUIDELINES.md)。

## 测试

### 定位测试

- 通过产品代码前缀查找测试项目(如 `FancyZones`、`AdvancedPaste`)
- 在同级目录或上溯 1-2 层寻找名为 `<Product>*UnitTests` 或 `<Product>*UITests` 的文件夹

### 运行测试

1. **先构建测试项目**,等待退出码 0
2. 通过 VS 测试资源管理器(`Ctrl+E, T`)或带筛选器的 `vstest.console.exe` 运行
3. 本仓库中**避免使用 `dotnet test`** – 请用 VS 测试资源管理器或 vstest.console.exe

### 测试类型

| 类型 | 要求 | 环境准备 |
|------|------|----------|
| 单元测试 | 标准开发环境 | 无 |
| UI 测试 | WinAppDriver v1.2.1、开发者模式 | 从 [WinAppDriver releases](https://github.com/microsoft/WinAppDriver/releases/tag/v1.2.1) 安装 |
| 模糊测试 | OneFuzz、.NET 10 | 见[模糊测试](doc/devdocs/tools/fuzzingtesting.md) |

### 测试纪律

1. 行为变更时同步新增或调整测试
2. 若跳过测试,说明原因(如纯注释改动、字符串重命名)
3. 涉及文件 I/O 或用户输入的新模块**必须**实现模糊测试

### 特殊要求

- **Mouse Without Borders**:需要 2 台以上物理计算机(不能用虚拟机)
- **多显示器实用工具**:在 2 台以上显示器、不同 DPI 设置下测试

UI 测试环境细节见 [UI 测试](doc/devdocs/development/ui-tests.md)。

## 边界

### 以下情况应先寻求澄清

- 扫阅相关文档后规格仍然含糊
- 跨模块影响(共享枚举/结构体)不明确
- 涉及安全、提权或安装程序改动
- 需要修改 GPO 或策略处理逻辑

### 需要格外小心的区域

| 区域 | 顾虑 | 参考文档 |
|------|------|----------|
| `src/common/` | ABI 破坏 | [公共库说明](.github/instructions/common-libraries.instructions.md) |
| `src/runner/`、`src/settings-ui/` | IPC 契约、schema | [Runner 与设置界面说明](.github/instructions/runner-settings-ui.instructions.md) |
| 安装程序文件 | 发布影响 | 需仔细评审 |
| 提权/GPO 逻辑 | 安全 | 确认策略处理无回归 |

### 禁止事项

- 不要把未完成的功能合入 main(使用功能分支)
- 不要在未同步更新 runner 和 settings-ui 的情况下破坏 IPC/JSON 契约
- 不要在热路径里加刷屏日志
- 未经 PM 批准且未更新 `NOTICE.md` 前,不要引入第三方依赖

## 验证清单

收尾前请确认:

- [ ] 构建通过,退出码 0
- [ ] 测试已更新且本地通过
- [ ] 无意外的 ABI 破坏或 schema 变更
- [ ] runner 与 settings-ui 之间 IPC 契约一致
- [ ] 新依赖已加入 `NOTICE.md`
- [ ] PR 保持原子性(单一逻辑变更),并关联了 issue

## 文档索引

### 核心架构

- [架构总览](doc/devdocs/core/architecture.md)
- [Runner](doc/devdocs/core/runner.md)
- [设置系统](doc/devdocs/core/settings/readme.md)
- [模块接口](doc/devdocs/modules/interface.md)

### 开发

- [编码指南](doc/devdocs/development/guidelines.md)
- [代码风格](doc/devdocs/development/style.md)
- [日志](doc/devdocs/development/logging.md)
- [UI 测试](doc/devdocs/development/ui-tests.md)
- [模糊测试](doc/devdocs/tools/fuzzingtesting.md)

### 构建与工具

- [构建指南](tools/build/BUILD-GUIDELINES.md)
- [工具总览](doc/devdocs/tools/readme.md)

### 说明文件(自动应用)

- [Runner 与设置界面](.github/instructions/runner-settings-ui.instructions.md)
- [公共库](.github/instructions/common-libraries.instructions.md)
