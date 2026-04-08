# Wiki File Template

Use this template when creating a new Wiki category file at `$KB/Wiki/{category}.md`.
Replace all `{placeholders}` with actual values.

---

```markdown
---
category: {category}
updated: {YYYY-MM-DD}
card-count: 0
---

# {Category Title}

## Core Concepts

The most foundational, frequently-relevant cards in this category.

*(add entries as cards accumulate)*

## By Tech Stack

### {Stack Name}

- [[Cards/{slug}]] — {one-line description}

## By Scenario

### {Scenario Name}

- [[Cards/{slug}]] — {one-line description}

## Cross-Wiki Connections

Cards here that relate to other knowledge domains:

| Card | Connected To |
|------|-------------|
| [[Cards/{slug}]] | → [[Wiki/{other-category}]] |

## Recent Additions

- {YYYY-MM-DD}: [[Cards/{slug}]]
```

---

## Category Naming Guide

| Category | Use For |
|----------|---------|
| `frontend` | Vue3, Nuxt, React, SSR, CSS, browser APIs |
| `backend` | APIs, databases, server-side logic, caching |
| `infra` | Deployment, CI/CD, Docker, cloud services |
| `ai-tools` | Claude Code, LLM integrations, prompting, skills, hooks |
| `workflow` | Development process, git, code review, planning tools |
| `debugging` | Systematic diagnosis patterns, error types, tracing |
| `architecture` | System design decisions, patterns, tradeoffs |
| `knowledge-management` | Knowledge base, Obsidian, PKM systems |
| `business` | Non-technical context, client decisions, scope |

If a new domain emerges that doesn't fit these, create a new category with a clear, lowercase, hyphenated name.
