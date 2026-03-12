#!/bin/bash
# Pinterlude quick commands
# Usage: bash pinterlude.sh [command]

case "$1" in
  preview)
    cd ~/Documents/pinterlude
    git pull
    hugo server --buildDrafts
    ;;
  publish)
    cd ~/Documents/pinterlude
    git add -A
    git commit -m "${2:-Update}"
    git push
    ;;
  pull)
    cd ~/Documents/pinterlude
    git pull
    ;;
  backup)
    cd ~/Documents/pinterlude
    BACKUP_DIR=~/Documents/pinterlude-backups/$(date +%Y-%m-%d_%H%M)
    mkdir -p "$BACKUP_DIR"
    cp -r content/ static/ layouts/ hugo.toml netlify.toml "$BACKUP_DIR/"
    echo "✓ Backup saved to $BACKUP_DIR"
    ;;
  status)
    cd ~/Documents/pinterlude
    echo "── Git status ──"
    git status -s
    echo ""
    echo "── Recent commits ──"
    git log --oneline -5
    echo ""
    echo "── Articles ──"
    ls -1 content/blog/*.md 2>/dev/null | wc -l | xargs echo "Total articles:"
    ls -1 content/blog/*.md 2>/dev/null | while read f; do
      title=$(grep "^title:" "$f" | head -1 | sed 's/title: *"*//' | sed 's/"*$//')
      draft=$(grep "^draft:" "$f" | head -1 | grep -c "true")
      if [ "$draft" = "1" ]; then
        echo "  [DRAFT] $title"
      else
        echo "  [LIVE]  $title"
      fi
    done
    ;;
  *)
    echo "Pinterlude CLI"
    echo ""
    echo "Usage: bash pinterlude.sh [command]"
    echo ""
    echo "Commands:"
    echo "  preview   Pull latest + start local server with drafts"
    echo "  publish   Commit and push all changes (optional: message)"
    echo "  pull      Pull latest from GitHub"
    echo "  backup    Create a local backup"
    echo "  status    Show site status and articles"
    echo ""
    echo "Examples:"
    echo "  bash pinterlude.sh preview"
    echo "  bash pinterlude.sh publish \"New article about Medellin\""
    echo "  bash pinterlude.sh backup"
    ;;
esac
