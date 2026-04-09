# save-to-kb

<p align="center">
  <img src="./assets/cover.jpeg" alt="save-to-kb" width="600">
</p>

<p align="center">
  <a href="./README.zh.md">中文文档</a>
</p>

[![license](https://img.shields.io/badge/license-MIT-b0e8ff?style=flat-square&labelColor=0a0e14)](./LICENSE)
[![platform](https://img.shields.io/badge/Claude_Code-Skill-d4a8ff?style=flat-square&labelColor=0a0e14)](https://github.com/anthropics/claude-code)
[![obsidian](https://img.shields.io/badge/Obsidian-compatible-7c3aed?style=flat-square&labelColor=0a0e14)](https://obsidian.md)

> 中文文档：[README.zh.md](./README.zh.md)

A Claude Code skill that extracts reusable knowledge from your conversations and files into a structured Obsidian knowledge base.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/verycafe/save-to-kb/main/install.sh | bash
```

Then run `/save-to-kb` and select **init** to set up your knowledge base.

## Usage

Type `/save-to-kb` — a two-level menu appears:

| Option | What it does |
|--------|-------------|
| `save` | Extract knowledge from the current conversation |
| `file` | Analyze a file (PDF / Markdown / txt) and extract cards |
| `check` | Health-check: scan for broken links and inconsistencies |
| `管理知识库…` | Open submenu → `init` / `replay` |

You can also call modes directly: `/save-to-kb check`, `/save-to-kb init`, etc.

## What gets saved

A card must be **non-obvious** and **transferable** — someone hitting a similar situation in the future would genuinely benefit. Four categories qualify:

| Category | Examples |
|----------|---------|
| **Technical** | Bug root causes, undocumented API behavior, integration constraints, performance quirks |
| **Architecture & Design** | Design decisions with clear reasoning, tradeoff conclusions |
| **Product & Requirements** | Non-obvious user behavior insights, requirement misread lessons, product decision patterns |
| **AI & Vibe Coding** | Claude/LLM behavioral quirks, effective Skill/Hook patterns, AI-assisted development workflows |

**Not saved:** generic process templates, project-specific decisions with no generalizable signal, mainstream best practices, unresolved explorations.

## Knowledge base structure

```
LLM-Brain-Bases/
  Cards/     # One .md file per knowledge point
  Bases/     # Session and file import records
  Wiki/      # Category index files
  Sources/   # Original files imported via the `file` mode
  Claude.md  # Master index (auto-maintained)
```

## How `file` mode works

1. Select `file` from the menu (or run `/save-to-kb file <path>`)
2. Provide the file path — PDF, Markdown, or txt
3. The skill copies the file to `Sources/`, reads it, and shows candidate knowledge areas
4. On confirmation, writes Cards + a Base record referencing the local copy

## Auto-save behavior

Claude automatically triggers this skill at the end of conversations that produce:

- A non-obvious bug root cause
- Undocumented API or library behavior
- An architecture or design decision with clear reasoning
- A product insight revealing non-obvious user behavior or requirements
- An AI/LLM behavioral pattern worth remembering
- A vibe coding workflow that meaningfully improves AI-assisted development
- A confirmed failure path worth avoiding
