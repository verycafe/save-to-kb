# save-to-kb

[![license](https://img.shields.io/badge/license-MIT-b0e8ff?style=flat-square&labelColor=0a0e14)](./LICENSE)
[![platform](https://img.shields.io/badge/Claude_Code-Skill-d4a8ff?style=flat-square&labelColor=0a0e14)](https://github.com/anthropics/claude-code)
[![obsidian](https://img.shields.io/badge/Obsidian-compatible-7c3aed?style=flat-square&labelColor=0a0e14)](https://obsidian.md)

> English docs: [README.md](./README.md)

从 Claude 对话和文件中提取可复用的知识，自动整理到结构化的 Obsidian 知识库。

## 安装

```bash
curl -fsSL https://raw.githubusercontent.com/verycafe/save-to-kb/main/install.sh | bash
```

安装后运行 `/save-to-kb`，选择 **init** 完成初始化。

## 使用

输入 `/save-to-kb`，弹出两级菜单：

| 选项 | 功能 |
|------|------|
| `save` | 从当前对话提取知识并保存 |
| `file` | 分析指定文件（PDF / Markdown / txt）并提取知识卡片 |
| `check` | 健康检查：扫描断链和数据不一致 |
| `管理知识库…` | 进入二级菜单 → `init` / `replay` |

也可直接带参数调用：`/save-to-kb check`、`/save-to-kb init` 等。

## 什么内容会被保存

卡片必须**非显而易见**且**可复用** —— 即未来遇到类似情况的人读到后能受益。四个类别符合条件：

| 类别 | 典型内容 |
|------|---------|
| **Technical** | Bug 根因、API 未记录行为、集成陷阱、性能规律 |
| **Architecture & Design** | 有推理依据的设计决策、技术选型取舍 |
| **Product & Requirements** | 用户行为洞察、需求误读教训、产品决策模式 |
| **AI & Vibe Coding** | Claude/LLM 行为规律、Skill/Hook 配置技巧、AI 辅助开发工作流 |

**不保存：** 通用流程模板、无法泛化的项目特定决策、教科书级基础知识、结论未明确的探索。

## 知识库结构

```
LLM-Brain-Bases/
  Cards/     # 每个知识点一个 .md 文件
  Bases/     # 对话和文件导入记录
  Wiki/      # 分类索引文件
  Sources/   # file 模式导入的原始文件
  Claude.md  # 主索引（自动维护）
```

## file 模式工作方式

1. 菜单选 `file`（或直接 `/save-to-kb file <路径>`）
2. 输入文件路径，支持 PDF、Markdown、txt
3. Skill 将文件复制到 `Sources/`，读取内容，展示候选知识点预览
4. 确认后写入 Cards，并创建引用本地副本的 Base 记录

## 自动保存触发条件

对话产出以下任何一项时，Claude 会自动调用此 Skill：

- 发现了 bug 的非显而易见根因
- 某 API 或库的文档未记录行为
- 有明确推理依据的架构或设计决策
- 揭示了非显而易见用户行为或需求的产品洞察
- 值得记录的 AI/LLM 行为规律
- 让 AI 辅助开发明显更高效的 Vibe Coding 工作流
- 已验证的失败路径，值得避免重蹈
