> 🌐 本文档由 [microsoft/PowerToys](https://github.com/microsoft/PowerToys) 翻译,英文原版见原项目。

# Issue/PR 命令

PowerToys 仓库使用一些特殊关键字来协助管理 issue 和拉取请求。以下是可以在 issue 与 PR 描述或评论中使用的最重要命令。

| 命令 | 说明 |
|------|------|
| `/azp run` | 触发当前 PR 的 Azure Pipelines CI 构建。想在不产生新提交的情况下重新构建时很有用。 |
| `/bugreport` / `/reportbug` | 添加一条评论,内含 Bug Report Tool 的使用手册,帮助用户收集日志和系统信息以便调试。它会要求用户上传该文件,并添加 `Needs-Author-Feedback` 标签。 |
| `/feedbackhub` | 添加一条评论,附上 Windows 反馈中心应用的链接,用户可在那里提交关于 PowerToys 的反馈。会关闭该 issue 并添加 `Resolution-Please File on Feedback Hub` 标签。 |
| `/dup #...` / `/duplicate #...` / `/dup https://...` / `/duplicate https://...` | 将当前 issue 标记为另一个 issue 的重复项。会关闭当前 issue 并应用 `Resolution-Duplicate` 标签。把 `#...` 替换为 issue 编号或 issue 链接。 |
| `/needinfo` | 为 issue 或 PR 添加 `Needs-Author-Feedback` 标签,表示需要作者提供更多信息。 |
| `/helped` | 关闭该 issue 并添加 `Resolution-Helped User` 标签。同时会添加一条包含 PowerToys 用户文档链接的评论。 |
| `/loc` | 添加一条评论,告知用户该问题已转交本地化团队,很快会被修复。并添加 `Loc-Sent To Team` 标签。 |

## 定义新命令

这些命令大多由 [Microsoft GitHub Policy Service](https://github.com/apps/microsoft-github-policy-service) 机器人处理。其命令定义在 [PowerToys 策略配置文件](/.github/policies/resourceManagement.yml)中。

## 其他自动化任务

### AI 辅助的 issue 分诊

新建和更新的 issue 会由一个 GitHub Agentic Workflow 处理,它将确定性检查与有限的 GitHub Copilot 流程相结合。它维护一条分诊评论,添加匹配的主 `Product-*` 标签和版本标签,向作者请求阻塞性信息,建议升级较旧的 PowerToys 版本,提示疑似重复项,并分析经过脱敏的 PowerToys 诊断报告子集。

重复项关闭以 GitHub 原生建议的形式提交,必须由维护者接受或拒绝。接受建议会以重复项为由关闭该 issue,并将其链接到选定的规范 issue。

### `Needs-Author-Feedback` 标签

如果一个 issue 或拉取请求带着该标签且连续 7 天没有活动,机器人会将其关闭。作者发表评论会移除 issue 和 PR 上的该标签,作者推送代码会移除 PR 上的该标签。手动移除该标签也会停用计划关闭。

### 筛选想要贡献的用户

如果用户表达了贡献意愿(例如在 issue 或 PR 中说 "I want to contribute"),机器人会添加一条评论,附上["是否愿意为 PowerToys 做贡献?"讨论串](https://github.com/microsoft/PowerToys/issues/28769)的链接。
