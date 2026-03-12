#!/bin/bash
# Pinterlude — Enriched CMS v2
# Adds: language, tags, location, featured, substack/youtube links

echo "Enriching CMS v2..."

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
    view_groups:
      - label: "Pillar"
        field: pillar
      - label: "Language"
        field: language
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
        hint: "Primary language of this article"
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
      - label: "Tags"
        name: "tags"
        widget: "list"
        required: false
        hint: "Keywords separated by commas (e.g. Switzerland, ultratrail, New York)"
      - label: "Location"
        name: "location"
        widget: "string"
        required: false
        hint: "Where was this written? (e.g. Boulder, CO / Queens, NYC / Medellín)"
      - label: "Cover Image"
        name: "cover"
        widget: "image"
        required: false
        hint: "Optional cover image for the article"
      - label: "Featured"
        name: "featured"
        widget: "boolean"
        default: false
        hint: "Featured articles appear larger on the homepage"
      - label: "Substack URL"
        name: "substack_url"
        widget: "string"
        required: false
        hint: "Link to the Substack version of this article"
      - label: "YouTube URL"
        name: "youtube_url"
        widget: "string"
        required: false
        hint: "Link to a related YouTube video"
      - { label: "Draft", name: "draft", widget: "boolean", default: false }
      - { label: "Body", name: "body", widget: "markdown" }
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
      <li class="article-card{{ if .Params.featured }} featured{{ else if eq $index 0 }} featured{{ end }} reveal" style="transition-delay: {{ mul $index 0.1 }}s;">
        <a href="{{ .Permalink }}" style="text-decoration:none; color:inherit; display:block;">
          <div class="article-card-inner">
            <span class="article-number">{{ printf "%02d" (add $index 1) }}</span>
            <div class="article-card-meta">
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
              {{ if eq .Params.language "fr" }}<span class="article-lang">FR</span>{{ end }}
            </div>
            <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}{{ with .Params.location }} · {{ . }}{{ end }}</time>
            <h2 class="article-title">{{ .Title }}</h2>
            {{ with .Params.description }}
            <p class="article-summary">{{ . }}</p>
            {{ else }}
            {{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}
            {{ end }}
            {{ if or .Params.tags .Params.substack_url .Params.youtube_url }}
            <div class="article-card-footer">
              {{ with .Params.tags }}
              <div class="article-tags">
                {{ range first 3 . }}<span class="article-tag">{{ . }}</span>{{ end }}
              </div>
              {{ end }}
            </div>
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
      <div class="single-hero-meta">
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
        {{ if eq .Params.language "fr" }}<span class="article-lang-single">FR</span>{{ end }}
      </div>
      <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}{{ with .Params.location }} · {{ . }}{{ end }}</time>
      <h1 class="article-title">{{ .Title }}</h1>
    </div>
  </section>

  <div class="article-body-wrap">
    <div class="article-body">
      {{ .Content }}
    </div>

    <!-- Tags -->
    {{ with .Params.tags }}
    <div class="article-tags-full">
      {{ range . }}<a href="/tags/{{ . | urlize }}/" class="article-tag-link">{{ . }}</a>{{ end }}
    </div>
    {{ end }}

    <!-- Cross-links: Substack / YouTube -->
    {{ if or .Params.substack_url .Params.youtube_url }}
    <div class="article-crosslinks">
      <p class="crosslinks-label">Also available on</p>
      {{ with .Params.substack_url }}
      <a href="{{ . }}" target="_blank" rel="noopener" class="crosslink crosslink--substack">
        <span class="crosslink-icon">✉</span> Read on Substack
      </a>
      {{ end }}
      {{ with .Params.youtube_url }}
      <a href="{{ . }}" target="_blank" rel="noopener" class="crosslink crosslink--youtube">
        <span class="crosslink-icon">▶</span> Watch on YouTube
      </a>
      {{ end }}
    </div>
    {{ end }}
  </div>

  <div class="article-end">
    <a href="/" class="back-link">← Back to journal</a>
  </div>

{{ end }}
HTMLEOF

# --- Add new styles to CSS ---
cat >> static/css/style.css << 'CSSEOF'

/* ─── LANGUAGE TAG ─── */
.article-lang {
  font-family: var(--font-mono);
  font-size: 0.6rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  padding: 0.2em 0.6em;
  border-radius: 3px;
  background: rgba(26,23,20,0.08);
  color: var(--text-secondary);
  display: inline-block;
  margin-left: 0.5rem;
  vertical-align: middle;
}

.article-card.featured .article-lang {
  background: rgba(250,246,241,0.12);
  color: rgba(250,246,241,0.5);
}

.article-lang-single {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  padding: 0.25em 0.7em;
  border-radius: 3px;
  background: rgba(250,246,241,0.1);
  color: rgba(250,246,241,0.5);
  display: inline-block;
  margin-left: 0.5rem;
  vertical-align: middle;
}

/* ─── CARD META ROW ─── */
.article-card-meta {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.4rem;
  margin-bottom: 0.5rem;
}

/* ─── TAGS ON CARDS ─── */
.article-card-footer {
  margin-top: 0.8rem;
}

.article-tags {
  display: flex;
  gap: 0.4rem;
  flex-wrap: wrap;
}

.article-tag {
  font-family: var(--font-mono);
  font-size: 0.58rem;
  letter-spacing: 0.05em;
  padding: 0.2em 0.6em;
  border-radius: 3px;
  background: rgba(26,23,20,0.06);
  color: var(--text-secondary);
}

.article-card.featured .article-tag {
  background: rgba(250,246,241,0.08);
  color: rgba(250,246,241,0.4);
}

/* ─── TAGS ON SINGLE ARTICLE ─── */
.article-tags-full {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid var(--rule);
}

.article-tag-link {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  letter-spacing: 0.05em;
  padding: 0.3em 0.8em;
  border-radius: 4px;
  background: rgba(26,23,20,0.05);
  color: var(--text-secondary);
  text-decoration: none;
  transition: all 0.3s;
}

.article-tag-link:hover {
  background: var(--terracotta);
  color: white;
}

/* ─── CROSS-LINKS (Substack / YouTube) ─── */
.article-crosslinks {
  margin-top: 2rem;
  padding: 1.5rem;
  background: rgba(26,23,20,0.03);
  border-radius: 12px;
}

.crosslinks-label {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-bottom: 0.8rem;
}

.crosslink {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 500;
  text-decoration: none;
  padding: 0.6em 1.2em;
  border-radius: 8px;
  margin-right: 0.8rem;
  margin-bottom: 0.5rem;
  transition: all 0.3s;
}

.crosslink--substack {
  background: rgba(255,106,0,0.08);
  color: #FF6A00;
}

.crosslink--substack:hover {
  background: rgba(255,106,0,0.15);
  transform: translateY(-2px);
}

.crosslink--youtube {
  background: rgba(255,0,0,0.06);
  color: #CC0000;
}

.crosslink--youtube:hover {
  background: rgba(255,0,0,0.12);
  transform: translateY(-2px);
}

.crosslink-icon {
  font-size: 1.1rem;
}

/* ─── HERO META ROW ─── */
.single-hero-meta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}
CSSEOF

# --- Update test article ---
cat > content/blog/premier-article.md << 'EOF'
---
title: "On a quitté la Suisse"
date: 2026-03-12
description: "Nobody believed us. Two Swiss, settled and comfortable, with seven children between them — and one day, the decision: we leave."
author: "Marc & Linda"
language: "fr"
pillar: "choice"
tags:
  - Switzerland
  - life change
  - Colorado
location: "Highlands Ranch, CO"
cover: ""
featured: true
substack_url: ""
youtube_url: ""
draft: false
---

Personne n'y croyait. Deux Suisses installés, confortables, avec sept enfants entre eux — et un jour, la décision : on part. Pas en vacances. On part vivre.

Ceci est le premier article de Pinterlude. Le vrai contenu arrive bientôt.
EOF

echo "✓ CMS v2 enriched!"
echo "New fields: language, tags, location, featured, substack URL, youtube URL"
echo "Run 'hugo server --buildDrafts' to preview."
