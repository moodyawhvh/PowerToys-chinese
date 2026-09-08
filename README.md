<div align="center">

# PowerToys 中文翻译版

**[中文版] PowerToys — 微软官方 Windows 效率工具箱,30+ 实用工具的中文介绍与上手指南**

[![原项目](https://img.shields.io/badge/原项目-microsoft--PowerToys-blue?style=flat-square&logo=github)](https://github.com/microsoft/PowerToys)
[![中文文档](https://img.shields.io/badge/中文文档-README.zh--CN.md-orange?style=flat-square)](README.zh-CN.md)
[![GitHub Stars](https://img.shields.io/github/stars/microsoft/PowerToys?style=flat-square&label=原项目Stars)](https://github.com/microsoft/PowerToys/stargazers)
[![微信联系](https://img.shields.io/badge/微信-uaycar-brightgreen?style=flat-square&logo=wechat)](#)

</div>

---

> 这是 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 的中文翻译版本。
> 完整源代码请访问原项目:https://github.com/microsoft/PowerToys

**代部署 / 定制服务 / 技术咨询 请添加微信:uaycar**

---

## 📖 项目简介

PowerToys 是微软官方开源的 Windows 效率工具集,旨在帮助用户自定义 Windows 并简化日常操作。它包含 30 多个面向高级用户的小工具,覆盖窗口管理、快捷启动、批量重命名、取色、文本识别、多机协同等高频场景。本仓库对其官方 README 进行了中文翻译整理,方便中文用户快速了解与上手,所有功能与代码均来自原项目。

## ✨ 主要特性

- **FancyZones 窗口分区**:自定义窗口布局,拖拽窗口自动贴靠到指定区域
- **PowerToys Run 快捷启动器**:Alt+Space 一键呼出,搜索应用、文件、计算与系统命令
- **Keyboard Manager 键盘映射**:重映射按键与快捷键,打造个人键位方案
- **PowerRename 批量重命名**:资源管理器集成,支持正则表达式的批量改名
- **Color Picker 屏幕取色**:随时拾取屏幕任意像素的颜色值
- **Text Extractor 文字识别(OCR)**:从屏幕任意区域直接提取文字
- **Always on Top / Mouse Utilities**:窗口置顶、找鼠标、放大鼠标等桌面辅助
- **Mouse Without Borders 跨设备协同**:一套键鼠控制多台电脑,跨机复制粘贴
- **Awake / File Locksmith / Peek 等**:保持屏幕常亮、查看文件占用、空格预览文件等 30+ 实用工具

## 📁 文件说明

| 文件 | 说明 |
|:-----|:-----|
| README.md | 本文件(中文简介) |
| README.zh-CN.md | 详细中文文档(完整汉化) |

## 🚀 快速开始

1. 前往 [原项目 Releases](https://aka.ms/installPowerToys) 页面,在 **Assets** 中下载与系统架构匹配的安装包(多数设备选 x64 per-user);
2. 或在 Microsoft Store 中搜索 PowerToys 直接安装;
3. 或使用 WinGet 命令行安装(用户级,默认):

```powershell
winget install Microsoft.PowerToys -s winget
```

4. 全机器范围安装:

```powershell
winget install --scope machine Microsoft.PowerToys -s winget
```

5. 也可使用 Chocolatey、Scoop 等社区安装方式,详见[官方安装文档](https://learn.microsoft.com/windows/powertoys/install);
6. 安装后启动 PowerToys,在设置中按需启用各工具模块并配置快捷键;
7. 各工具的详细中文说明见本仓库 [README.zh-CN.md](README.zh-CN.md)。

完整源代码与最新版本请访问原项目:https://github.com/microsoft/PowerToys

## 📞 联系方式

**代部署 / 定制服务 / 技术咨询 请添加微信:uaycar**

---

本项目为 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 的中文翻译版本,所有代码版权归原项目作者所有,遵循其原始许可证。

**如果觉得有用,请给原项目点个 Star!** ⭐
