<div align="center">

# PowerToys 中文文档

[![原项目](https://img.shields.io/badge/原项目-microsoft--PowerToys-blue?style=flat-square&logo=github)](https://github.com/microsoft/PowerToys)
[![微信联系](https://img.shields.io/badge/微信-uaycar-brightgreen?style=flat-square&logo=wechat)](#)

**[中文版] PowerToys — 微软官方 Windows 效率工具箱中文文档**

</div>

---

> 这是 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 官方 README 的中文翻译文档。
> 完整源代码请访问原项目:https://github.com/microsoft/PowerToys
>
> **代部署 / 定制服务 / 技术咨询 请添加微信:uaycar**

Microsoft PowerToys 是一套帮助你自定义 Windows、简化日常操作的实用工具集。

目录:[安装](#-安装) · [官方文档](https://aka.ms/powertoys-docs) · [博客](https://aka.ms/powertoys-releaseblog) · [更新日志](https://github.com/microsoft/PowerToys/releases)

## 🔨 实用工具

PowerToys 内置 30 多个工具,帮你定制和优化 Windows 使用体验(英文名为工具原名,点击可跳转官方介绍页):

| 工具 | 说明 |
|:-----|:-----|
| [Advanced Paste](https://aka.ms/PowerToysOverview_AdvancedPaste) | 高级粘贴,借助 AI 对剪贴板内容进行转换粘贴 |
| [Always on Top](https://aka.ms/PowerToysOverview_AoT) | 快捷键置顶任意窗口 |
| [Awake](https://aka.ms/PowerToysOverview_Awake) | 保持设备唤醒,阻止休眠 |
| [Color Picker](https://aka.ms/PowerToysOverview_ColorPicker) | 系统级屏幕取色器 |
| [Command Not Found](https://aka.ms/PowerToysOverview_CmdNotFound) | PowerShell 中缺命令时给出安装建议 |
| [Command Palette](https://aka.ms/PowerToysOverview_CmdPal) | 可扩展的命令面板启动器 |
| [Crop And Lock](https://aka.ms/PowerToysOverview_CropAndLock) | 将窗口某区域裁剪为独立子窗口 |
| [Environment Variables](https://aka.ms/PowerToysOverview_EnvironmentVariables) | 可视化管理环境变量 |
| [FancyZones](https://aka.ms/PowerToysOverview_FancyZones) | 窗口管理器,自定义贴靠布局 |
| [File Explorer Add-ons](https://aka.ms/PowerToysOverview_FileExplorerAddOns) | 资源管理器增强预览(SVG/Markdown/PDF 等) |
| [File Locksmith](https://aka.ms/PowerToysOverview_FileLocksmith) | 查看是什么进程占用了文件 |
| [Grab And Move](https://aka.ms/PowerToysOverview_GrabAndMove) | 无需聚焦即可拖动/调整窗口 |
| [Hosts File Editor](https://aka.ms/PowerToysOverview_HostsFileEditor) | 图形化编辑 Windows Hosts 文件 |
| [Image Resizer](https://aka.ms/PowerToysOverview_ImageResizer) | 右键批量调整图片尺寸 |
| [Keyboard Manager](https://aka.ms/PowerToysOverview_KeyboardManager) | 重映射按键与快捷键 |
| [Light Switch](https://aka.ms/PowerToysOverview_LightSwitch) | 按时间/日照自动切换系统深浅色主题 |
| [Mouse Utilities](https://aka.ms/PowerToysOverview_MouseUtilities) | 找到鼠标、高亮鼠标、十字线等鼠标辅助 |
| [Mouse Without Borders](https://aka.ms/PowerToysOverview_MouseWithoutBorders) | 一套键鼠控制多台电脑 |
| [New+](https://aka.ms/PowerToysOverview_NewPlus) | 自定义资源管理器"新建"模板 |
| [Peek](https://aka.ms/PowerToysOverview_Peek) | 按住快捷键快速预览文件 |
| [PowerDisplay](https://aka.ms/PowerToysOverview_PowerDisplay) | 多显示器亮度、对比度等集中管理 |
| [PowerRename](https://aka.ms/PowerToysOverview_PowerRename) | 支持正则的批量重命名 |
| [PowerToys Run](https://aka.ms/PowerToysOverview_PowerToysRun) | 快捷启动器,搜索即启动 |
| [Quick Accent](https://aka.ms/PowerToysOverview_QuickAccent) | 快速输入带重音符号的字符 |
| [Registry Preview](https://aka.ms/PowerToysOverview_RegistryPreview) | 可视化预览 .reg 文件内容 |
| [Screen Ruler](https://aka.ms/PowerToysOverview_ScreenRuler) | 屏幕标尺,测量像素尺寸 |
| [Shortcut Guide](https://aka.ms/PowerToysOverview_ShortcutGuide) | 长按 Win 键显示快捷键指南 |
| [Text Extractor](https://aka.ms/PowerToysOverview_TextExtractor) | 从屏幕任意位置提取文字(OCR) |
| [Window Hopper](https://aka.ms/PowerToysOverview_WindowHopper) | 快捷键在同名窗口间快速切换 |
| [Workspaces](https://aka.ms/PowerToysOverview_Workspaces) | 一键启动自定义工作区应用组合 |
| [ZoomIt](https://aka.ms/PowerToysOverview_ZoomIt) | 屏幕缩放、放大与演示标注工具 |

## 📦 安装

详细的安装说明与系统要求请参阅[官方安装文档](https://learn.microsoft.com/windows/powertoys/install)。

如果想快速上手,可选择以下任一安装方式:

### 从 GitHub 下载 .exe 安装包

前往 [PowerToys GitHub Releases](https://aka.ms/installPowerToys),向下滚动展开 **Assets**,选择与你的处理器架构和安装范围匹配的安装文件。对大多数设备而言,应选择 _x64 per-user_(x64 按用户安装)。

### Microsoft Store

直接从 Microsoft Store 安装 PowerToys:[点此获取](https://aka.ms/getPowertoys)。

### WinGet

从 [WinGet](https://github.com/microsoft/winget-cli#installing-the-client) 下载安装 PowerToys。通过 winget 更新时会沿用当前 PowerToys 的安装范围。在命令行 / PowerShell 中执行:

- 用户范围安装(默认)

```powershell
winget install Microsoft.PowerToys -s winget
```

- 全机器范围安装

```powershell
winget install --scope machine Microsoft.PowerToys -s winget
```

### 其他安装方式

也可以使用 Chocolatey、Scoop 等[社区维护的安装方式](https://learn.microsoft.com/windows/powertoys/install#community-driven-install-tools),如果你偏好这些包管理器,可在对应文档中找到安装说明。

## ✨ 最新动态

查看 [更新日志(Releases)](https://github.com/microsoft/PowerToys/releases/) 了解每个版本的最新变化。

## 🛣️ 路线图

在 [v0.102](https://github.com/microsoft/PowerToys/milestone/46) 版本中,团队正在推进:使用 WinUI 3 现代化改造多个工具、为 Command Palette 增加标签页与 JavaScript/TypeScript 扩展支持,并在整个 PowerToys 中加入更多效率改进。

## ❤️ PowerToys 社区

PowerToys 团队非常感谢[活跃社区](https://github.com/microsoft/PowerToys/blob/main/COMMUNITY.md)的支持。无论是提交 Bug、更新文档、参与设计还是编写功能,社区贡献者的工作都极其重要——没有大家的帮助,PowerToys 无法成长为今天的样子。感谢每一位贡献者,你们的反馈让 PowerToys 逐月进步!

## 参与贡献

本项目欢迎各种形式的贡献:除了编写功能和修复 Bug,你还可以参与规格撰写、设计、文档和找 Bug。我们诚邀高级用户社区一起打造这套帮助大家用好 Windows 的工具。**在开始开发想贡献的功能之前**,请先阅读 [贡献者指南(CONTRIBUTING.md)](https://github.com/microsoft/PowerToys/blob/main/CONTRIBUTING.md),以便我们与你一起确定最佳方案、在开发全程提供指导,避免重复劳动。多数贡献需要签署[贡献者许可协议(CLA)](https://cla.opensource.microsoft.com),以确认你授予我们使用该贡献的权利且你本人有权授予。开发环境搭建等细节请阅读[开发者文档](https://github.com/microsoft/PowerToys/tree/main/doc/devdocs),其中包含本地编译的完整步骤。

## 行为准则

本项目采用 [Microsoft 开源行为准则](https://github.com/microsoft/PowerToys/blob/main/CODE_OF_CONDUCT.md)。

## 隐私声明

应用会记录基本的诊断数据(遥测)。有关隐私及数据收集的更多信息,请参阅 [PowerToys 数据与隐私文档](https://aka.ms/powertoys-data-and-privacy-documentation)。

---

> **代部署 / 定制服务 / 技术咨询 请添加微信:uaycar**

本项目为 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 的中文翻译文档,所有代码与内容版权归原项目作者所有,遵循其原始许可证(MIT License)。

**如果觉得有用,请给原项目点个 Star!** ⭐
