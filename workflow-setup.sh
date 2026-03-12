#!/bin/bash
# Pinterlude — Workflow Setup
# Templates, backup, shortcut, analytics, email notifications

echo "═══════════════════════════════════════"
echo "  PINTERLUDE — Workflow Setup"
echo "═══════════════════════════════════════"

# ─── 1. ARTICLE TEMPLATES IN CMS ───
echo "→ Adding article templates per pillar..."
cat > static/admin/config.yml << 'EOF'
backend:
  name: git-gateway
  branch: main

media_folder: "static/images"
public_folder: "/images"

collections:
  - name: "blog"
    label: "Articles"
    folder: "content/blog"
    create: true
    slug: "{{slug}}"
    sortable_fields: ["date", "title", "author", "pillar", "language"]
    view_filters:
      - label: "Marc"
        field: author
        pattern: "Marc"
      - label: "Linda"
        field: author
        pattern: "Linda"
      - label: "English"
        field: language
        pattern: "en"
      - label: "Français"
        field: language
        pattern: "fr"
      - label: "Featured"
        field: featured
        pattern: true
      - label: "Drafts"
        field: draft
        pattern: true
    view_groups:
      - label: "Pillar"
        field: pillar
      - label: "Language"
        field: language
      - label: "Author"
        field: author
    fields:
      - { label: "Title", name: "title", widget: "string" }
      - { label: "Date", name: "date", widget: "datetime" }
      - { label: "Description", name: "description", widget: "text", required: false, hint: "Short summary for previews and SEO (1-2 sentences)" }
      - label: "Author"
        name: "author"
        widget: "select"
        options:
          - { label: "Marc", value: "Marc" }
          - { label: "Linda", value: "Linda" }
          - { label: "Marc & Linda", value: "Marc & Linda" }
        default: "Marc"
      - label: "Language"
        name: "language"
        widget: "select"
        options:
          - { label: "English", value: "en" }
          - { label: "Français", value: "fr" }
        default: "en"
      - label: "Pillar"
        name: "pillar"
        widget: "select"
        options:
          - { label: "The Choice — Life decisions", value: "choice" }
          - { label: "The Gaze — Understanding places", value: "gaze" }
          - { label: "Behind the Scenes — Nomad logistics", value: "scenes" }
          - { label: "Body in Motion — Sport & travel", value: "motion" }
          - { label: "Linda's Words — Literary voice", value: "words" }
        required: false
      - label: "Tags"
        name: "tags"
        widget: "list"
        required: false
        hint: "Keywords separated by commas"
      - label: "Location"
        name: "location"
        widget: "string"
        required: false
        hint: "Where was this written?"
      - label: "Cover Image"
        name: "cover"
        widget: "image"
        required: false
      - label: "Featured"
        name: "featured"
        widget: "boolean"
        default: false
      - label: "Substack URL"
        name: "substack_url"
        widget: "string"
        required: false
      - label: "YouTube URL"
        name: "youtube_url"
        widget: "string"
        required: false
      - { label: "Draft", name: "draft", widget: "boolean", default: true }
      - { label: "Body", name: "body", widget: "markdown" }

  # ── EDITORIAL CALENDAR ──
  - name: "calendar"
    label: "Editorial Calendar"
    folder: "content/calendar"
    create: true
    slug: "{{slug}}"
    fields:
      - { label: "Title", name: "title", widget: "string", hint: "Working title for the article" }
      - label: "Target Date"
        name: "date"
        widget: "datetime"
        hint: "When do you plan to publish this?"
      - label: "Author"
        name: "author"
        widget: "select"
        options: ["Marc", "Linda", "Marc & Linda"]
        default: "Marc"
      - label: "Pillar"
        name: "pillar"
        widget: "select"
        options:
          - { label: "The Choice", value: "choice" }
          - { label: "The Gaze", value: "gaze" }
          - { label: "Behind the Scenes", value: "scenes" }
          - { label: "Body in Motion", value: "motion" }
          - { label: "Linda's Words", value: "words" }
        required: false
      - label: "Status"
        name: "status"
        widget: "select"
        options:
          - { label: "Idea", value: "idea" }
          - { label: "Outline", value: "outline" }
          - { label: "Writing", value: "writing" }
          - { label: "Review", value: "review" }
          - { label: "Ready", value: "ready" }
          - { label: "Published", value: "published" }
        default: "idea"
      - { label: "Notes", name: "body", widget: "markdown", required: false, hint: "Outline, notes, ideas for this article" }
EOF

mkdir -p content/calendar

# ─── 2. PLAUSIBLE ANALYTICS ───
echo "→ Adding Plausible Analytics (privacy-friendly)..."
# Add script to baseof.html head
sed -i 's|<link rel="stylesheet" href="/css/style.css">|<link rel="stylesheet" href="/css/style.css">\
  <!-- Analytics (uncomment when ready) -->\
  <!-- <script defer data-domain="pinterlude.com" src="https://plausible.io/js/script.js"></script> -->|' layouts/_default/baseof.html

# ─── 3. EMAIL NOTIFICATIONS ───
echo "→ Adding deploy notification config..."
cat >> netlify.toml << 'EOF'

# Email notification on deploy (configure in Netlify dashboard)
# Go to: Site settings > Build & deploy > Deploy notifications
# Add: "Email notification" for "Deploy succeeded"
# Enter: marc.ferrer.bv@gmail.com
EOF

# ─── 4. TERMINAL SHORTCUT SCRIPT ───
echo "→ Creating terminal shortcut..."
cat > pinterlude.sh << 'BASH'
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
BASH

chmod +x pinterlude.sh

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ Workflow Setup complete!"
echo "═══════════════════════════════════════"
echo ""
echo "New features:"
echo "  📝  Editorial Calendar in CMS (/admin → Editorial Calendar)"
echo "  📊  Plausible Analytics ready (uncomment when subscribed)"
echo "  📧  Deploy notification config added"
echo "  🖥   Terminal shortcuts: bash pinterlude.sh [preview|publish|backup|status]"
echo ""
echo "To set up email notifications:"
echo "  Go to Netlify → Site settings → Build & deploy → Deploy notifications"
echo "  Add 'Email notification' for 'Deploy succeeded'"
echo ""
echo "To set up analytics:"
echo "  Sign up at plausible.io (free trial, then \$9/month)"
echo "  Uncomment the script tag in layouts/_default/baseof.html"
echo ""
echo "Run 'hugo server --buildDrafts' to preview."
