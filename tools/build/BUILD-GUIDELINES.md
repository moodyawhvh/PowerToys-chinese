> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。

# 构建脚本 – 快速指南

使用这些脚本在本地构建 PowerToys。它们会自动检测平台(x64/arm64)、初始化 Visual Studio 开发者环境,并在失败时输出有用的日志。

## 快速开始(cmd.exe 下)
- 先做快速核心构建(runner + settings)和 NuGet 还原:
  - `tools\build\build-essentials.cmd`
- 构建当前文件夹中的项目:
  - `tools\build\build.cmd`

提示:把 `D:\PowerToys\tools\build` 加入 PATH,即可在任何位置使用这些包装脚本。

## 该用哪个脚本
1) `build-essentials.ps1`
   - 为 `PowerToys.slnx` 还原 NuGet 包并构建核心项目(runner、settings)。
   - 自动检测平台;自动初始化 VS 开发者环境。
   - 示例(PowerShell):
     - `./tools/build/build-essentials.ps1`
     - `./tools/build/build-essentials.ps1 -Platform arm64 -Configuration Release`

2) `build.ps1`(可在任意文件夹使用)
   - 构建当前目录中的任意 `.sln/.csproj/.vcxproj`。
   - 自动检测平台;自动初始化 VS 开发者环境。
   - 可接受额外的 MSBuild 参数(转发给 msbuild):
     - `./tools/build/build.ps1 '/p:CIBuild=true' '/p:SomeProp=Value'`
   - 仅还原:
     - `./tools/build/build.ps1 -RestoreOnly`

3) `build-installer.ps1`(谨慎使用)
   - 完整的本地打包流水线(还原、构建、签名 MSIX、WiX v5 MSI/bootstrapper)。
   - 自动初始化 VS 开发者环境。会清理 `installer/` 下的部分输出(保留 *.exe)。
   - 关键选项:`-PerUser true|false`、`-InstallerSuffix wix5|vnext`。
   - 示例:
     - `./tools/build/build-installer.ps1 -Platform x64 -Configuration Release -PerUser true -InstallerSuffix wix5`

## 日志与故障排查
- 失败时,查看被构建的解决方案/项目旁边的日志:
  - `build.<configuration>.<platform>.all.log` — 完整文本日志
  - `build.<configuration>.<platform>.errors.log` — 仅错误
  - `build.<configuration>.<platform>.warnings.log` — 仅警告
  - `build.<configuration>.<platform>.trace.binlog` — 用 MSBuild Structured Log Viewer 打开
- VS 环境初始化:
  - 脚本优先尝试 DevShell(`Microsoft.VisualStudio.DevShell.dll` / `Enter-VsDevShell`),失败后回退到 `VsDevCmd.bat`。
  - 如果找不到 VS,请从 "Developer PowerShell for VS 2022" 或 "Developer PowerShell for VS" 运行,或确保 `Program Files (x86)\Microsoft Visual Studio\Installer` 下存在 `vswhere.exe`。

## 备注
- 如有需要,可用 `-Platform x64|arm64` 显式覆盖平台。
- CMD 包装脚本:`build.cmd`、`build-essentials.cmd` 会把所有参数转发给对应的 PowerShell 脚本。
