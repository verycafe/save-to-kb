#!/bin/bash
set -e
mkdir -p ~/.claude/skills/save-to-kb/references
curl -fsSL https://raw.githubusercontent.com/verycafe/save-to-kb/main/SKILL.md \
  -o ~/.claude/skills/save-to-kb/SKILL.md
curl -fsSL https://raw.githubusercontent.com/verycafe/save-to-kb/main/references/wiki-template.md \
  -o ~/.claude/skills/save-to-kb/references/wiki-template.md
echo "✓ save-to-kb installed. Run /save-to-kb and select init to get started."
