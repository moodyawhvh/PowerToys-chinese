> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。
>
> 注:本文件超过 10000 字符,按翻译规范仅翻译核心章节;"Core Architecture / Common Components / Tools / Processes / Other Resources" 等纯链接索引段落保留英文原样。

# PowerToys 开发者文档

欢迎阅读 PowerToys 开发者文档。本文档面向希望为 PowerToys 做贡献或想了解其工作原理的开发者。

## 快速开始

### 前置条件

1. Windows 10 2018 年 4 月更新(版本 1803)或更高
1. [Visual Studio 2026](https://visualstudio.microsoft.com/downloads/)(推荐)或 Visual Studio 2022 17.4+,并包含以下工作负载/组件:
   - 使用 C++ 的桌面开发
   - WinUI 应用开发
   - .NET 桌面开发
   - Windows 11 SDK (10.0.22621.0)
   - Windows 11 SDK (10.0.26100.3916)
1. .NET 8 SDK
1. 在 Windows 中启用长路径(详见 [Enable Long Paths](https://learn.microsoft.com/windows/win32/fileio/maximum-file-path-limitation#enabling-long-paths-in-windows-10-version-1607-and-later))

> **提示:** 可以使用仓库中的 [WinGet 配置文件](https://github.com/microsoft/PowerToys/tree/main/.config)自动安装带全部所需工作负载的 Visual Studio:
> ```powershell
> winget configure .config\configuration.winget
> ```
> 请选择与你 VS 版本匹配的文件(如 `configuration.vsProfessional.winget` 或 `configuration.vsEnterprise.winget`)。

### Fork、Clone 与环境搭建

1. 如果还没有,先在 GitHub 上 fork 本仓库
1. 在本地克隆你的 fork
1. 运行自动化环境搭建脚本(**推荐**):

```powershell
.\tools\build\setup-dev-environment.ps1
```

该脚本会:
- 启用 Windows 长路径支持(需要管理员权限)
- 启用 Windows 开发者模式(需要管理员权限)
- 引导你从 `.vsconfig` 安装所需的 Visual Studio 组件
- 初始化 git 子模块

使用 `-Help` 参数可查看全部可用选项。

<details>
<summary><strong>手动搭建(如果你不想用脚本)</strong></summary>

#### 安装 Visual Studio 依赖

1. 打开 `PowerToys.slnx` 文件。
1. 如果解决方案资源管理器面板中出现 `install extra components` 对话框,点击 `install`。

或者,使用 Visual Studio 安装程序从仓库根目录导入 `.vsconfig` 文件,以安装全部所需工作负载。

#### 初始化子模块

这是一次性步骤,编译 PowerToys 的大部分组件之前必须完成。

1. 打开终端
1. 进入你克隆 PowerToys 的文件夹
1. 运行 `git submodule update --init --recursive`

</details>

### 构建

#### 使用 Visual Studio

- 在 Visual Studio 中打开 `PowerToys.slnx`。
- 在 `Solutions Configuration` 下拉菜单中选择 `Release` 或 `Debug`。
- 从 `Build` 菜单选择 `Build Solution`,或按 <kbd>Control</kbd>+<kbd>Shift</kbd>+<kbd>b</kbd>。
- 构建过程可能需要几分钟,取决于电脑性能。完成后,PowerToys 二进制文件位于仓库的 `x64\Release\` 目录下。
    - 你可以直接运行 `x64\Release\PowerToys.exe` 而无需安装 PowerToys,但部分模块(如 PowerRename、ImageResizer、文件资源管理器扩展等)只有在构建安装程序并安装 PowerToys 之后才可用。

#### 使用命令行

也可以使用 `tools\build\` 中提供的脚本从命令行构建:

```powershell
# Build the full solution (auto-detects platform)
.\tools\build\build.ps1

# Build with specific configuration
.\tools\build\build.ps1 -Platform x64 -Configuration Release

# Build only essential projects (runner + settings) for faster iteration
.\tools\build\build-essentials.ps1

# Build everything including the installer (Release only)
.\tools\build\build-installer.ps1
```

### 调试

详细的调试技巧(包括 Visual Studio 配置、附加到子进程、构建错误排查)见 [Debugging](development/debugging.md)。

### 创建新的 PowerToy

覆盖模块架构、设置集成、安装程序打包与测试的端到端指南见 [Creating a New PowerToy](development/new-powertoy.md)。

### 开发 Command Palette 扩展

如果想为 Command Palette 开发自己的扩展,请参阅 [Command Palette 扩展性文档](https://aka.ms/building-cmdpal-extensions),其中介绍了如何创建、打包和分发与 Command Palette 集成的自定义扩展。

## 开发指南

- [Coding Guidelines](development/guidelines.md) - 开发指南与最佳实践
- [Coding Style](development/style.md) - 代码格式化与风格约定
- [Logging and Telemetry](development/logging.md) - 日志与遥测的用法
- [Localization](development/localization.md) - 如何支持多语言
- [UI Testing](development/ui-tests.md) - 如何为 PowerToys 编写 UI 测试
- [Developing with VS Code](development/dev-with-vscode.md) - 使用 VS Code 构建、调试和贡献

## 规则

- **遵循代码中已有的模式。**
- 遵守[代码风格](development/style.md)。
- 尽量把新功能/组件封装到接口定义良好的库中。
- 在扩展代码时,把新功能封装成类,或把既有功能重构为类。
- 新增类/方法或修改现有代码时,补充新的单元测试或更新现有测试。

## GitHub 工作流

- 开始修复/开发功能之前,确保有一个打开的 issue 来跟踪这项工作。
- 为 issue 添加 `In progress` 标签(如果还没有)。同时添加 `Cost-Small/Medium/Large` 工作量估计,并确保打好了所有合适的标签。
- 如果你是社区贡献者,可能无权给 issue 添加标签;此时只需评论说明你已开始处理该 issue,并尽量给出预计交付时间。
- 如果工作项规模为中/大,请用 markdown 任务列表列出各子项,每完成一项就打勾更新。
- **在打开 PR 之前,确保你的改动能在本地成功构建且功能测试通过。** 这一点对 AI 辅助(vibe coding)贡献尤其重要——务必验证 AI 生成的代码符合预期。用于讨论的探索性 PR 或草稿 PR 例外。
- 打开 PR 时请遵循 PR 模板。
- 当你希望团队审阅时(即使工作尚未完全完成),把 PR 标记为 "Ready For Review",团队会评审你的工作并提出评论、建议和修改请求。可能需要多轮往返,但最终会得到可靠、可测试、合规、可以放心合并的代码。
- PR 获批后,由 PR 所有者执行合并。对于社区贡献,批准该 PR 的评审者也可以合并。
- 合并 PR 使用 `Squash and merge` 选项。如果因为提交在逻辑上相互独立而不想 squash,可使用 `Rebase and merge`。
- 在 PR 中引用 issue 可自动关闭它。你可以在 PR 描述中使用[关闭关键字](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword),让 GitHub 自动把 PR 与 issue 关联。

## 核心架构

- [Architecture Overview](core/architecture.md) - Overview of the PowerToys architecture and module interface
- [Runner and System tray](core/runner.md) - Details about the PowerToys Runner process
- [Settings](core/settings/readme.md) - Documentation on the settings system
- [Installer](core/installer.md) - Information about the PowerToys installer
- [Modules](modules/readme.md) - Documentation for individual PowerToys modules

## 通用组件

- [Context Menu Handlers](common/context-menus.md) - How PowerToys implements and registers Explorer context menu handlers
- [Monaco Editor](common/monaco-editor.md) - How PowerToys uses the Monaco code editor component across modules

## 工具

- [Tools Overview](tools/readme.md) - Overview of tools in PowerToys
- [Build Tools](tools/build-tools.md) - Tools that help building PowerToys
- [Bug Report Tool](tools/bug-report-tool.md) - Tool for collecting logs and system information
- [Debugging Tools](tools/debugging-tools.md) - Specialized tools for debugging
- [Fuzzing Testing](tools/fuzzingtesting.md) - How to implement and run fuzz testing for PowerToys modules

## 流程

- [Release Process](processes/release-process.md) - How PowerToys releases are prepared and published
- [Update Process](processes/update-process.md) - How PowerToys updates work
- [GPO Implementation](processes/gpo.md) - Group Policy Objects implementation details

## 其他资源

- [aka.ms links](akaLinks.md) - List of short links
- [Issue/PR commands](commands.md) - Special commands for managing issues and pull requests

## 构建安装程序

我们的安装程序分两部分:一个 EXE 和一个 MSI。EXE(Bootstrapper)包含 MSI 并处理更复杂的安装逻辑。
- EXE 负责安装所有前置依赖,并通过 MSI 安装 PowerToys。它还提供安装标志等额外功能(见下文)。
- MSI 负责安装 PowerToys 二进制文件。

安装程序只能在 `Release` 模式下编译;必须先执行步骤 1 和 2 才能编译 MSI。

1. 编译 `PowerToys.slnx`,方法见上文。
1. 编译 `BugReportTool.sln` 工具。根目录相对路径:`tools\BugReportTool\BugReportTool.sln`(详情见下文)
1. 编译 `StylesReportTool.sln` 工具。根目录相对路径:`tools\StylesReportTool\StylesReportTool.sln`(详情见下文)
1. 编译 `PowerToysSetup.slnx`,根目录相对路径:`installer\PowerToysSetup.slnx`(详情见下文)

构建与调试安装程序的更多细节见 [Installer](core/installer.md)。
