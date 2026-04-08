# save-to-kb

从 Claude 对话和文件中提取可复用的技术知识，自动整理到结构化的 Obsidian 知识库。

## 安装

```bash
mkdir -p ~/.claude/skills/save-to-kb/references
curl -o ~/.claude/skills/save-to-kb/SKILL.md \
  https://raw.githubusercontent.com/verycafe/save-to-kb/main/SKILL.md
curl -o ~/.claude/skills/save-to-kb/references/wiki-template.md \
  https://raw.githubusercontent.com/verycafe/save-to-kb/main/references/wiki-template.md
```

安装后运行 `/save-to-kb`，选择 **init** 完成初始化。

## 使用

输入 `/save-to-kb`，弹出菜单：

| 选项 | 功能 |
|------|------|
| `save` | 从当前对话提取知识并保存 |
| `file` | 分析指定文件（PDF / Markdown / txt）并提取知识卡片 |
| `init` | 初始化知识库或更改路径 |
| `check` | 健康检查：扫描断链和数据不一致 |
| `replay` | 回溯历史 session，补录遗漏的知识 |

也可直接带参数调用：`/save-to-kb check`、`/save-to-kb init` 等。

## 什么内容会被保存

卡片必须同时满足：**技术性**、**非显而易见**、**已验证**、**可复用** —— 即未来遇到相同技术问题的工程师或 AI 读到后能受益。

**不保存：** AI 协作方法论、流程模板、项目特定决策、教科书级基础知识。

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
- 有明确推理的架构/设计决策
- 让重复任务更高效的工作流模式
- 已验证的失败路径，值得避免重蹈
