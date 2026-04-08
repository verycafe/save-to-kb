# save-to-kb

一个 Claude Code Skill，自动将 Claude 对话中产生的知识提炼到结构化 Obsidian 知识库，并在开始新任务前主动查询已有知识。

## 它做什么

每次有价值的 Claude 对话都会产生可复用的知识：调试方案、发现的 API 行为、架构决策、工作流模式。没有沉淀系统，这些知识在会话结束时就消失了。

`save-to-kb` 让 Claude 成为知识编译器：

- **自动保存**：在有价值的对话结束时提炼知识，无需手动触发
- **任务前查询**：开始新任务前读取已有知识，不重复探索
- **健康检查**：扫描整个知识库，修复断链和不一致
- **历史回放**：处理从未保存过的历史会话

## 知识库结构

```
LLM-Brain-Bases/
├── Claude.md        主索引（知识地图 + 场景快查表）
├── Bases/           会话来源记录
├── Cards/           原子知识卡片（一概念一卡片）
└── Wiki/            分类索引文件
```

卡片使用 Obsidian `[[wikilinks]]` 建立 N:N 关联。主索引（`Claude.md`）是 Claude 每次任务前读取的入口。

## 命令

| 命令 | 说明 |
|------|------|
| `save-to-kb init` | 首次初始化：询问路径、创建目录结构、配置全局 CLAUDE.md |
| `save-to-kb` | 自动保存：从当前对话提炼知识，写入 Cards + Base + Wiki |
| `save-to-kb check` | 健康检查：扫描所有文件，发现断链/不一致/缺失字段，确认后修复 |
| `save-to-kb replay` | 历史回放：处理从未保存的历史会话 |

## 安装

将 `SKILL.md` 和 `references/` 文件夹复制到：

```
~/.claude/skills/save-to-kb/
```

然后运行首次初始化：

```
save-to-kb init
```

Claude 会询问知识库路径（macOS 终端中可直接拖拽文件夹插入路径），创建目录结构，并在全局 `~/.claude/CLAUDE.md` 中写入自动保存和任务前查询规则。

## 自动保存工作原理

任何产生了可复用知识的对话结束时，Claude 会自动调用 `save-to-kb`，无需手动触发。保存流程：

1. 提炼知识点（可复用 + 非显而易见 + 已验证）
2. 查重，有重复则更新已有卡片
3. 写入原子 Card 文件（结构化 frontmatter）
4. 写入 Base 记录（来源档案）
5. 更新相关 Wiki 分类索引
6. 更新主索引 `Claude.md`

## 卡片格式

每张卡片记录一个概念：

```yaml
---
title: "Vue3 SSR Hydration Mismatch"
slug: vue3-ssr-hydration-mismatch
category: frontend
tags: [vue3, nuxt, ssr]
scenario: [debugging]
created: 2026-04-09
confidence: high       # high | medium | low
related:
  - nuxt-server-middleware
sources:
  - "[[Bases/2026-04-09-session]]"
---

## What          一句话描述
## Why It Matters 为什么重要
## How           具体做法/代码
## Gotchas       边界情况
## Connections   叙述性关联说明，使用 [[wikilinks]]
## References    来源会话链接
```

## 健康检查

```
save-to-kb check
```

扫描 Cards、Bases、Wiki 文件和主索引，检查：
- 断裂的 `[[wikilinks]]` 和 `related:` 引用
- 缺失的必填 frontmatter 字段和 body 章节
- Wiki 文件中的 `card-count` 与实际不符
- 主索引统计数字不准确

以编号列表展示所有问题，确认后自动修复。

## 历史回放

```
save-to-kb replay
```

读取 Claude Code 本地 session JSONL 文件，将 session ID 与已有 Base 记录对比，列出从未保存的历史会话供用户选择处理。无外部依赖，直接读取本地文件。

## 配置说明

- **KB 路径**：存储在 `~/.claude/skills/save-to-kb/.config`（由 `init` 写入，勿手动修改）
- **自动保存规则**：由 `init` 写入 `~/.claude/CLAUDE.md`
- **修改路径**：重新运行 `save-to-kb init`，可选将现有文件复制到新位置（复制不删除源文件）

## 依赖

- Claude Code CLI
- Obsidian（推荐查看器，非必须）
- `jq`（`replay` 命令使用）
