---
description: Overview of PowerToys Desired State Configuration (DSC) support
ms.date:     10/18/2025
ms.topic:    overview
title:       PowerToys DSC Overview
---

> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。

# PowerToys DSC 概览

## 简介

PowerToys 支持期望状态配置(DSC)v3,可对 PowerToys 设置进行声明式配置管理。

## 描述

PowerToys 通过 `PowerToys.DSC.exe` 命令行工具提供 Microsoft 期望状态配置(DSC)支持,使你能够:

- 声明并强制执行 PowerToys 实用工具的期望配置状态。
- 跨多台系统自动化 PowerToys 配置。
- 将 PowerToys 配置与 WinGet 及其他兼容 DSC 的工具集成。
- 将 PowerToys 设置作为代码纳入版本控制。

PowerToys 的 DSC 实现提供了一个 **settings** 资源,用于管理所有 PowerToys 实用工具(模块)的配置。每个实用工具都可以独立配置,从而对 PowerToys 环境实现细粒度控制。

## 使用方式

PowerToys DSC 有三种使用方式:

### 1. 直接运行 PowerToys.DSC.exe

使用 PowerToys.DSC.exe 命令行工具直接执行 DSC 操作:

```powershell
# Get current settings for a module
PowerToys.DSC.exe get --resource 'settings' --module Awake

# Set settings for a module
$input = '{"settings":{...}}'
PowerToys.DSC.exe set --resource 'settings' --module Awake --input $input

# Test if settings match desired state
PowerToys.DSC.exe test --resource 'settings' --module Awake --input $input
```

详细信息见 [PowerToys.DSC.exe 命令参考][01]。

### 2. Microsoft 期望状态配置(DSC)

在标准 DSC 配置文档中使用 PowerToys DSC 资源:

```yaml
# powertoys-config.dsc.yaml
$schema: https://aka.ms/dsc/schemas/v3/bundled/config/document.json
resources:
  - name: Configure Awake
    type: Microsoft.PowerToys/AwakeSettings
    properties:
      settings:
        properties:
          keepDisplayOn: true
          mode: 1
        name: Awake
        version: 0.0.1
```

### 3. WinGet 配置

将 PowerToys 配置与 WinGet 包安装集成:

```yaml
# winget-powertoys.yaml
$schema: https://raw.githubusercontent.com/PowerShell/DSC/main/schemas/2023/08/config/document.json
metadata:
  winget:
    processor: dscv3
resources:
  - name: Install PowerToys
    type: Microsoft.WinGet.DSC/WinGetPackage
    properties:
      id: Microsoft.PowerToys
      source: winget

  - name: Configure FancyZones
    type: Microsoft.PowerToys/FancyZonesSettings
    properties:
      settings:
        properties:
          fancyzones_shiftDrag: true
          fancyzones_mouseSwitch: true
        name: FancyZones
        version: 1.0
```

## 可用资源

PowerToys DSC 提供以下资源:

| 资源       | 说明                                       |
| ---------- | ------------------------------------------ |
| `settings` | 管理 PowerToys 实用工具模块的配置。 |

settings 资源的详细信息见 [Settings 资源参考][03]。

## 支持的模块

settings 资源支持配置以下 PowerToys 实用工具:

| 模块                   | 说明                                         | 文档                                  |
| ---------------------- | -------------------------------------------- | ------------------------------------- |
| App                    | PowerToys 应用常规设置。                     | [App module][04]                      |
| AdvancedPaste          | 高级剪贴板操作。                             | [AdvancedPaste module][05]            |
| AlwaysOnTop            | 将窗口置顶固定。                             | [AlwaysOnTop module][06]              |
| Awake                  | 保持电脑唤醒。                               | [Awake module][07]                    |
| ColorPicker            | 系统级取色器工具。                           | [ColorPicker module][08]              |
| CropAndLock            | 裁剪并锁定窗口局部区域。                     | [CropAndLock module][09]              |
| EnvironmentVariables   | 管理环境变量。                               | [EnvironmentVariables module][10]     |
| FancyZones             | 窗口布局管理器。                             | [FancyZones module][11]               |
| FileLocksmith          | 查明占用文件的进程。                         | [FileLocksmith module][12]            |
| FindMyMouse            | 快速定位鼠标指针。                           | [FindMyMouse module][13]              |
| Hosts                  | 快速编辑 hosts 文件。                        | [Hosts module][14]                    |
| ImageResizer           | 从右键菜单调整图片尺寸。                     | [ImageResizer module][15]             |
| KeyboardManager        | 重新映射按键并创建快捷键。                   | [KeyboardManager module][16]          |
| MeasureTool            | 测量屏幕上的像素。                           | [MeasureTool module][17]              |
| MouseHighlighter       | 高亮显示鼠标操作。                           | [MouseHighlighter module][18]         |
| MouseJump              | 在大屏或多屏之间快速移动指针。               | [MouseJump module][19]                |
| MousePointerCrosshairs | 以鼠标为中心显示十字线。                     | [MousePointerCrosshairs module][20]   |
| Peek                   | 快速文件预览工具。                           | [Peek module][21]                     |
| PowerAccent            | 快速选择带音符的字符。                       | [PowerAccent module][22]              |
| PowerOCR               | 从图片中提取文本。                           | [PowerOCR module][23]                 |
| PowerRename            | 批量重命名文件。                             | [PowerRename module][24]              |
| RegistryPreview        | 可视化查看和编辑注册表文件。                 | [RegistryPreview module][25]          |
| ShortcutGuide          | 显示键盘快捷键。                             | [ShortcutGuide module][26]            |
| Workspaces             | 保存和恢复应用组合。                         | [Workspaces module][27]               |
| ZoomIt                 | 屏幕缩放与标注工具。                         | [ZoomIt module][28]                   |

## 常见操作

### 列出所有支持的模块

```powershell
PowerToys.DSC.exe modules --resource 'settings'
```

### 获取当前配置

```powershell
# Get configuration for a specific module.
PowerToys.DSC.exe get --resource 'settings' --module FancyZones

# Export configuration (identical to get).
PowerToys.DSC.exe export --resource 'settings' --module FancyZones
```

### 应用配置

```powershell
# Set configuration for a module.
$input = '{"settings":{...}}'
PowerToys.DSC.exe set --resource 'settings' --module FancyZones --input $input
```

### 校验配置

```powershell
# Test if current state matches desired state.
$input = '{"settings":{...}}'
PowerToys.DSC.exe test --resource 'settings' --module FancyZones --input $input
```

### 生成 schema

```powershell
# Get JSON schema for a module's settings.
PowerToys.DSC.exe schema --resource 'settings' --module FancyZones
```

### 生成 DSC manifest

```powershell
# Generate manifest for a specific module.
$outputDir = "C:\manifests"
PowerToys.DSC.exe manifest --resource 'settings' --module FancyZones `
  --outputDir $outputDir

# Generate manifests for all modules.
PowerToys.DSC.exe manifest --resource 'settings' --outputDir $outputDir
```

## 示例

完整示例见:

- [Settings 资源示例][29]
- [modules][30] 文件夹中的各个模块文档

## 另请参阅

- [Settings 资源参考][03]
- [PowerToys.DSC.exe 命令参考][01]
- [模块文档][30]
- [Microsoft DSC 文档][31]
- [WinGet 配置文档][32]

<!-- Link reference definitions -->
[01]: ./modules/
[03]: ./settings-resource.md
[04]: ./modules/App.md
[05]: ./modules/AdvancedPaste.md
[06]: ./modules/AlwaysOnTop.md
[07]: ./modules/Awake.md
[08]: ./modules/ColorPicker.md
[09]: ./modules/CropAndLock.md
[10]: ./modules/EnvironmentVariables.md
[11]: ./modules/FancyZones.md
[12]: ./modules/FileLocksmith.md
[13]: ./modules/FindMyMouse.md
[14]: ./modules/Hosts.md
[15]: ./modules/ImageResizer.md
[16]: ./modules/KeyboardManager.md
[17]: ./modules/MeasureTool.md
[18]: ./modules/MouseHighlighter.md
[19]: ./modules/MouseJump.md
[20]: ./modules/MousePointerCrosshairs.md
[21]: ./modules/Peek.md
[22]: ./modules/PowerAccent.md
[23]: ./modules/PowerOCR.md
[24]: ./modules/PowerRename.md
[25]: ./modules/RegistryPreview.md
[26]: ./modules/ShortcutGuide.md
[27]: ./modules/Workspaces.md
[28]: ./modules/ZoomIt.md
[29]: ./settings-resource.md#examples
[30]: ./modules/
[31]: https://learn.microsoft.com/powershell/dsc/overview
[32]: https://learn.microsoft.com/windows/package-manager/configuration/
