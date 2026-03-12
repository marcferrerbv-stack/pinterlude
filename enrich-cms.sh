#!/bin/bash
# Pinterlude — Enriched CMS fields
# Adds: cover image, author, content pillar, description

echo "Enriching CMS and templates..."

# --- Decap CMS Config ---
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
    sortable_fields: ["date", "title", "author", "pillar"]
    view_filters:
      - label: "Marc"
        field: author
        pattern: "Marc"
      - label: "Linda"
        field: author
        pattern: "Linda"
    view_groups:
      - label: "Pillar"
        field: pillar
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
        hint: "Which content pillar does this belong to?"
      - label: "Cover Image"
        name: "cover"
        widget: "image"
        required: false
        hint: "Optional cover image for the article"
      - { label: "Draft", name: "draft", widget: "boolean", default: false }
      - { label: "Body", name: "body", widget: "markdown" }
EOF

# --- Update test article with new fields ---
cat > content/blog/premier-article.md << 'EOF'
---
title: "On a quitté la Suisse"
date: 2026-03-12
description: "Nobody believed us. Two Swiss, settled and comfortable, with seven children between them — and one day, the decision: we leave."
author: "Marc & Linda"
pillar: "choice"
cover: ""
draft: false
---

Personne n'y croyait. Deux Suisses installés, confortables, avec sept enfants entre eux — et un jour, la décision : on part. Pas en vacances. On part vivre.

Ceci est le premier article de Pinterlude. Le vrai contenu arrive bientôt.
EOF

# --- Updated Home Page Template ---
cat > layouts/index.html << 'HTMLEOF'
{{ define "main" }}

  <!-- HERO -->
  <section class="hero">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="shape shape--4"></div>
    <div class="hero-content">
      <h1 class="hero-title">Pinterlude</h1>
      <p class="hero-tagline">The interlude between two lives</p>
      <p class="hero-desc">A couple of Swiss intellectuals left comfort behind to see the world before it's too late. This is not a travel blog. It's the journal of a radical life choice.</p>
      <a href="#articles" class="hero-cta">Read the journal</a>
    </div>
    <div class="scroll-hint">
      <svg viewBox="0 0 24 24"><path d="M12 5v14M5 12l7 7 7-7"/></svg>
    </div>
  </section>

  <!-- INTRO -->
  <div class="intro-band">
    <div class="intro-quote reveal">
      He runs ultramarathons and thinks in systems. She translates literature and sees the world through stories. Together, they chose <span class="highlight">freedom over comfort</span>.
    </div>
    <div class="intro-text reveal" style="transition-delay: 0.15s;">
      After nearly thirty years each in Switzerland — stable careers, mountains, excellent cheese — we made a decision no one understood. We moved to the United States, and from there, we plan to spend <strong>twenty years seeing the world</strong>. Working online, writing, running trails on other continents.
    </div>
  </div>

  <!-- ARTICLES -->
  <section class="articles-section" id="articles">
    <p class="section-label reveal">Latest</p>

    <ul class="articles-grid">
      {{ range $index, $page := (where .Site.RegularPages "Section" "blog").ByDate.Reverse }}
      <li class="article-card{{ if eq $index 0 }} featured{{ end }} reveal" style="transition-delay: {{ mul $index 0.1 }}s;">
        <a href="{{ .Permalink }}" style="text-decoration:none; color:inherit; display:block;">
          <div class="article-card-inner">
            <span class="article-number">{{ printf "%02d" (add $index 1) }}</span>
            {{ with .Params.pillar }}
            <span class="article-pillar article-pillar--{{ . }}">
              {{ if eq . "choice" }}The Choice
              {{ else if eq . "gaze" }}The Gaze
              {{ else if eq . "scenes" }}Behind the Scenes
              {{ else if eq . "motion" }}Body in Motion
              {{ else if eq . "words" }}Linda's Words
              {{ end }}
            </span>
            {{ end }}
            <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}</time>
            <h2 class="article-title">{{ .Title }}</h2>
            {{ with .Params.description }}
            <p class="article-summary">{{ . }}</p>
            {{ else }}
            {{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}
            {{ end }}
            <span class="article-readmore">Read more →</span>
          </div>
        </a>
      </li>
      {{ end }}
    </ul>
  </section>

{{ end }}
HTMLEOF

# --- Updated Single Article Template ---
cat > layouts/_default/single.html << 'HTMLEOF'
{{ define "main" }}

  {{ if .Params.cover }}
  <section class="single-hero single-hero--cover" style="background-image: linear-gradient(to bottom, rgba(26,23,20,0.55), rgba(26,23,20,0.85)), url('{{ .Params.cover }}');">
  {{ else }}
  <section class="single-hero">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
  {{ end }}
    <div class="single-hero-content">
      {{ with .Params.pillar }}
      <span class="article-pillar-single article-pillar--{{ . }}">
        {{ if eq . "choice" }}The Choice
        {{ else if eq . "gaze" }}The Gaze
        {{ else if eq . "scenes" }}Behind the Scenes
        {{ else if eq . "motion" }}Body in Motion
        {{ else if eq . "words" }}Linda's Words
        {{ end }}
      </span>
      {{ end }}
      <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}</time>
      <h1 class="article-title">{{ .Title }}</h1>
    </div>
  </section>

  <div class="article-body-wrap">
    <div class="article-body">
      {{ .Content }}
    </div>
  </div>

  <div class="article-end">
    <a href="/" class="back-link">← Back to journal</a>
  </div>

{{ end }}
HTMLEOF

# --- Add pillar styles to CSS ---
cat >> static/css/style.css << 'CSSEOF'

/* ─── PILLAR TAGS ─── */
.article-pillar {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  padding: 0.3em 0.9em;
  border-radius: 50px;
  display: inline-block;
  margin-bottom: 0.8rem;
}

.article-pillar--choice { background: rgba(200,85,61,0.15); color: var(--terracotta); }
.article-pillar--gaze { background: rgba(42,122,110,0.15); color: var(--teal); }
.article-pillar--scenes { background: rgba(200,150,62,0.15); color: var(--gold); }
.article-pillar--motion { background: rgba(42,122,110,0.15); color: var(--teal); }
.article-pillar--words { background: rgba(107,58,93,0.15); color: var(--plum); }

.article-card.featured .article-pillar--choice { background: rgba(200,85,61,0.25); }
.article-card.featured .article-pillar--gaze { background: rgba(42,122,110,0.25); }
.article-card.featured .article-pillar--scenes { background: rgba(200,150,62,0.25); }
.article-card.featured .article-pillar--motion { background: rgba(42,122,110,0.25); }
.article-card.featured .article-pillar--words { background: rgba(107,58,93,0.25); }

.article-pillar-single {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  padding: 0.3em 1em;
  border-radius: 50px;
  display: inline-block;
  margin-bottom: 1rem;
}

.article-pillar-single.article-pillar--choice { background: rgba(200,85,61,0.2); color: var(--terracotta); }
.article-pillar-single.article-pillar--gaze { background: rgba(42,122,110,0.2); color: var(--sage); }
.article-pillar-single.article-pillar--scenes { background: rgba(200,150,62,0.2); color: var(--gold); }
.article-pillar-single.article-pillar--motion { background: rgba(42,122,110,0.2); color: var(--sage); }
.article-pillar-single.article-pillar--words { background: rgba(107,58,93,0.2); color: var(--blush); }

/* ─── COVER IMAGE HERO ─── */
.single-hero--cover {
  background-size: cover;
  background-position: center;
}

/* ─── AUTHOR IN DATE LINE ─── */
.article-card.featured .article-date { color: rgba(250,246,241,0.4); }
CSSEOF

echo "✓ CMS enriched with: author, pillar, cover image, description"
echo "Run 'hugo server' to preview."
