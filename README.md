# save-to-kb

A Claude Code skill that extracts reusable technical knowledge from your conversations and files into a structured Obsidian knowledge base.

## Install

```bash
mkdir -p ~/.claude/skills/save-to-kb/references
curl -o ~/.claude/skills/save-to-kb/SKILL.md \
  https://raw.githubusercontent.com/verycafe/save-to-kb/main/SKILL.md
curl -o ~/.claude/skills/save-to-kb/references/wiki-template.md \
  https://raw.githubusercontent.com/verycafe/save-to-kb/main/references/wiki-template.md
```

Then run `/save-to-kb` and select **init** to set up your knowledge base.

## Usage

Type `/save-to-kb` — a menu appears:

| Option | What it does |
|--------|-------------|
| `save` | Extract knowledge from the current conversation |
| `file` | Analyze a file (PDF / Markdown / txt) and extract cards |
| `init` | Set up or reconfigure the knowledge base path |
| `check` | Health-check: scan for broken links and inconsistencies |
| `replay` | Retroactively process past sessions that were never saved |

You can also call modes directly: `/save-to-kb check`, `/save-to-kb init`, etc.

## What gets saved

Cards must be **technical**, **non-obvious**, **resolved**, and **transferable** — meaning a future engineer or AI hitting the same problem would benefit from reading it.

**Not saved:** AI workflow methodology, process templates, project-specific decisions, mainstream best practices.

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

After significant conversations, Claude automatically calls this skill when the session produces:
- A non-obvious root cause for a bug
- Undocumented API or library behavior
- An architecture decision with clear reasoning
- A workflow pattern that makes repeated tasks faster
- A confirmed failure path worth avoiding
