# save-to-kb

A Claude Code skill that automatically distills knowledge from your Claude conversations into a structured Obsidian knowledge base — and queries it before starting new tasks.

## What It Does

Every significant conversation with Claude produces reusable knowledge: debugging solutions, discovered API behaviors, architectural decisions, workflow patterns. Without a system, this knowledge disappears when the session ends.

`save-to-kb` turns Claude into a knowledge compiler:

- **Auto-saves** durable knowledge at the end of significant conversations (no manual trigger needed)
- **Queries** the knowledge base before starting new tasks, so Claude builds on prior work
- **Health-checks** the entire knowledge base for broken links and inconsistencies
- **Replays** historical sessions to retroactively populate the knowledge base

## Knowledge Base Structure

```
LLM-Brain-Bases/
├── Claude.md        Master index (knowledge map + scenario quick-lookup)
├── Bases/           Session provenance records
├── Cards/           Atomic knowledge cards (one concept per card)
└── Wiki/            Category index files
```

Cards use Obsidian `[[wikilinks]]` for N:N relationships. The master index (`Claude.md`) is what Claude reads before each task.

## Commands

| Command | Description |
|---------|-------------|
| `save-to-kb init` | First-time setup: asks for KB path, creates directory structure, configures global CLAUDE.md |
| `save-to-kb` | Auto-save: extracts knowledge from current session, writes Cards + Base + Wiki updates |
| `save-to-kb check` | Health check: scans all files for broken links, inconsistencies, missing fields — fixes with confirmation |
| `save-to-kb replay` | Retroactively process historical sessions never saved to the KB |

## Installation

Copy `SKILL.md` and the `references/` folder to:

```
~/.claude/skills/save-to-kb/
```

Then run your first init:

```
save-to-kb init
```

Claude will ask for your knowledge base path (drag a folder into the terminal on macOS to insert the path), create the directory structure, and update your global `~/.claude/CLAUDE.md` with auto-save and pre-task query rules.

## How Auto-Save Works

At the end of any conversation that produced reusable knowledge, Claude automatically calls `save-to-kb` — no manual trigger required. The save procedure:

1. Extracts knowledge points (reusable + non-obvious + resolved)
2. Checks for duplicates before creating new cards
3. Writes atomic Cards with structured frontmatter
4. Writes a Base record (session provenance)
5. Updates relevant Wiki category indexes
6. Updates the master `Claude.md` index

## Card Format

Each card captures one concept:

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

## What
## Why It Matters
## How
## Gotchas
## Connections   ← prose with [[wikilinks]] to related concepts
## References
```

## Health Check

```
save-to-kb check
```

Scans Cards, Bases, Wiki files, and the master index for:
- Broken `[[wikilinks]]` and `related:` references
- Missing required frontmatter fields and body sections
- `card-count` mismatches in Wiki files
- Stats inaccuracies in the master index

Presents a numbered issue list and applies fixes after confirmation.

## Replay Historical Sessions

```
save-to-kb replay
```

Reads Claude Code's local session JSONL files, compares session IDs against existing Base records, and offers to process any sessions that were never saved. No external dependencies — reads session files directly.

## Configuration

- **KB path**: stored in `~/.claude/skills/save-to-kb/.config` (set by `init`, never edit manually)
- **Auto-save rules**: written to `~/.claude/CLAUDE.md` by `init`
- **KB path change**: re-run `save-to-kb init` — optionally migrates existing files to the new location (copy, not move)

## Requirements

- Claude Code CLI
- Obsidian (recommended viewer, not required)
- `jq` (for `replay` command)
