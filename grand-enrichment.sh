#!/bin/bash
# Pinterlude — Grand Enrichment
# Everything: About, pillars, authors, newsletter, dark mode, 
# reading time, RSS, Open Graph, favicon

echo "═══════════════════════════════════════"
echo "  PINTERLUDE — Grand Enrichment"
echo "═══════════════════════════════════════"

# ─── 1. HUGO CONFIG ───
echo "→ Updating Hugo config..."
cat > hugo.toml << 'EOF'
baseURL = "https://pinterlude.com/"
languageCode = "en"
title = "Pinterlude"

[params]
  tagline = "The interlude between two lives"
  description = "The journal of a radical life choice — by Marc & Linda"
  ogImage = "/images/og-default.jpg"

[taxonomies]
  tag = "tags"

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true

[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS"]

[outputFormats]
  [outputFormats.RSS]
    mediaType = "application/rss+xml"
    baseName = "feed"
EOF

# ─── 2. BASE TEMPLATE ───
echo "→ Building base template (dark mode, OG, reading time)..."
cat > layouts/_default/baseof.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ if .IsHome }}Pinterlude — The interlude between two lives{{ else }}{{ .Title }} — Pinterlude{{ end }}</title>
  <meta name="description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">

  <!-- Open Graph -->
  <meta property="og:title" content="{{ if .IsHome }}Pinterlude{{ else }}{{ .Title }}{{ end }}">
  <meta property="og:description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
  <meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
  <meta property="og:url" content="{{ .Permalink }}">
  <meta property="og:image" content="{{ with .Params.cover }}{{ . | absURL }}{{ else }}{{ .Site.Params.ogImage | absURL }}{{ end }}">
  <meta property="og:site_name" content="Pinterlude">
  {{ if .IsPage }}
  <meta property="article:published_time" content="{{ .Date.Format "2006-01-02T15:04:05Z07:00" }}">
  {{ with .Params.author }}<meta property="article:author" content="{{ . }}">{{ end }}
  {{ with .Params.tags }}{{ range . }}<meta property="article:tag" content="{{ . }}">{{ end }}{{ end }}
  {{ end }}

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="{{ if .IsHome }}Pinterlude{{ else }}{{ .Title }}{{ end }}">
  <meta name="twitter:description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
  <meta name="twitter:image" content="{{ with .Params.cover }}{{ . | absURL }}{{ else }}{{ .Site.Params.ogImage | absURL }}{{ end }}">

  <!-- RSS -->
  {{ range .AlternativeOutputFormats }}
  <link rel="{{ .Rel }}" type="{{ .MediaType.Type }}" href="{{ .Permalink }}" title="{{ $.Site.Title }}">
  {{ end }}

  <!-- Favicon -->
  <link rel="icon" type="image/svg+xml" href="/favicon.svg">

  <link rel="stylesheet" href="/css/style.css">
  <script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
</head>
<body>

  {{ block "main" . }}{{ end }}

  <footer class="site-footer">
    <span class="footer-brand">Pinterlude</span>
    <p class="footer-text">&copy; 2026 — Marc &amp; Linda</p>
    <div class="footer-links">
      <a href="/">Journal</a>
      <a href="/about/">About</a>
      <a href="/feed.xml" title="RSS Feed">RSS</a>
    </div>
  </footer>

  <script>
    // Dark mode
    const theme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', theme);
    function toggleTheme() {
      const current = document.documentElement.getAttribute('data-theme');
      const next = current === 'light' ? 'dark' : 'light';
      document.documentElement.setAttribute('data-theme', next);
      localStorage.setItem('theme', next);
      document.querySelector('.theme-toggle').textContent = next === 'dark' ? '☀' : '☾';
    }

    // Scroll reveal
    const reveals = document.querySelectorAll('.reveal');
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) entry.target.classList.add('visible');
      });
    }, { threshold: 0.15 });
    reveals.forEach(el => observer.observe(el));

    // Netlify Identity
    if (window.netlifyIdentity) {
      window.netlifyIdentity.on("init", user => {
        if (!user) {
          window.netlifyIdentity.on("login", () => {
            document.location.href = "/admin/";
          });
        }
      });
    }
  </script>
</body>
</html>
HTMLEOF

# ─── 3. NAV PARTIAL ───
echo "→ Creating nav partial..."
cat > layouts/partials/nav.html << 'HTMLEOF'
<nav class="site-nav-bar">
  <a href="/" class="nav-logo">Pinterlude</a>
  <div class="site-nav">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle dark mode">☾</button>
  </div>
</nav>
HTMLEOF

# ─── 4. HOME PAGE ───
echo "→ Building home page..."
cat > layouts/index.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

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

  <!-- NEWSLETTER -->
  <div class="newsletter-band reveal">
    <div class="newsletter-inner">
      <span class="newsletter-icon">✉</span>
      <h3 class="newsletter-title">Follow the journey</h3>
      <p class="newsletter-desc">Long essays, honest dispatches, and the occasional existential crisis — delivered to your inbox.</p>
      <a href="https://pinterlude.substack.com" target="_blank" rel="noopener" class="newsletter-btn">Subscribe on Substack</a>
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
            <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}{{ with .Params.location }} · {{ . }}{{ end }} · {{ .ReadingTime }} min read</time>
            <h2 class="article-title">{{ .Title }}</h2>
            {{ with .Params.description }}
            <p class="article-summary">{{ . }}</p>
            {{ else }}
            {{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}
            {{ end }}
            {{ with .Params.tags }}
            <div class="article-card-footer">
              <div class="article-tags">
                {{ range first 3 . }}<span class="article-tag">{{ . }}</span>{{ end }}
              </div>
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

# ─── 5. SINGLE ARTICLE ───
echo "→ Building single article template..."
cat > layouts/_default/single.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

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
      <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}{{ with .Params.location }} · {{ . }}{{ end }} · {{ .ReadingTime }} min read</time>
      <h1 class="article-title">{{ .Title }}</h1>
    </div>
  </section>

  <div class="article-body-wrap">
    <div class="article-body">
      {{ .Content }}
    </div>

    {{ with .Params.tags }}
    <div class="article-tags-full">
      {{ range . }}<a href="/tags/{{ . | urlize }}/" class="article-tag-link">{{ . }}</a>{{ end }}
    </div>
    {{ end }}

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

    <!-- Author card -->
    <div class="author-card">
      <div class="author-card-inner">
        <span class="author-card-name">{{ with .Params.author }}{{ . }}{{ else }}Marc & Linda{{ end }}</span>
        <p class="author-card-bio">
          {{ if eq .Params.author "Marc" }}Sports scientist, ultrarunner, and systems thinker. Currently somewhere between a trail and a spreadsheet.
          {{ else if eq .Params.author "Linda" }}Literary translator across three languages. Sees the world through stories, words, and the spaces between them.
          {{ else }}A sports scientist and a literary translator who left Switzerland to see the world before it's too late.
          {{ end }}
        </p>
        <a href="/about/" class="author-card-link">About us →</a>
      </div>
    </div>
  </div>

  <div class="article-end">
    <a href="/" class="back-link">← Back to journal</a>
  </div>

{{ end }}
HTMLEOF

# ─── 6. LIST TEMPLATE ───
echo "→ Building list template..."
cat > layouts/_default/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:40vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="single-hero-content">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:3rem;font-weight:900;color:var(--paper);">{{ .Title }}</h1>
      {{ with .Description }}<p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1rem;">{{ . }}</p>{{ end }}
    </div>
  </section>

  <div class="article-body-wrap">
    {{ .Content }}
    <section class="articles-section" style="padding:2rem 0;">
      <ul class="articles-grid">
        {{ range $index, $page := .Pages.ByDate.Reverse }}
        <li class="article-card reveal" style="transition-delay: {{ mul $index 0.1 }}s;">
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
              <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }} · {{ .ReadingTime }} min read</time>
              <h2 class="article-title">{{ .Title }}</h2>
              {{ with .Params.description }}
              <p class="article-summary">{{ . }}</p>
              {{ end }}
              <span class="article-readmore">Read more →</span>
            </div>
          </a>
        </li>
        {{ end }}
      </ul>
    </section>
  </div>

{{ end }}
HTMLEOF

# ─── 7. PILLARS INDEX PAGE ───
echo "→ Creating pillar pages..."
mkdir -p content/pillars
cat > content/pillars/_index.md << 'EOF'
---
title: "Content Pillars"
description: "The five lenses through which we tell our story"
---
EOF

mkdir -p layouts/pillars
cat > layouts/pillars/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:50vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:3rem;font-weight:900;color:var(--paper);">Five ways<br>to tell a story</h1>
      <p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1rem;max-width:500px;margin-left:auto;margin-right:auto;">Every article belongs to a pillar — a lens through which we see and share our life.</p>
    </div>
  </section>

  <div class="pillars-page">
    {{ $pages := where .Site.RegularPages "Section" "blog" }}

    {{ $pillars := slice
      (dict "id" "choice" "name" "The Choice" "desc" "The chronicle of the big decision. Leaving Switzerland, the uncertainty, the quiet victories." "color" "terracotta")
      (dict "id" "gaze" "name" "The Gaze" "desc" "Understanding a place, not just visiting it. The double lens: Marc scientific, Linda literary." "color" "teal")
      (dict "id" "scenes" "name" "Behind the Scenes" "desc" "Nomad life unfiltered. Money, logistics, green cards, subletting." "color" "gold")
      (dict "id" "motion" "name" "Body in Motion" "desc" "Sport, health and travel. Trail running, altitude, exercise physiology on the move." "color" "teal")
      (dict "id" "words" "name" "Linda's Words" "desc" "The literary voice. Discoveries, translation, mood pieces." "color" "plum")
    }}

    {{ range $pillars }}
    {{ $pillarID := .id }}
    {{ $articles := where $pages "Params.pillar" $pillarID }}
    <div class="pillar-section reveal">
      <div class="pillar-header pillar-header--{{ .color }}">
        <h2 class="pillar-name">{{ .name }}</h2>
        <p class="pillar-desc">{{ .desc }}</p>
        <span class="pillar-count">{{ len $articles }} article{{ if gt (len $articles) 1 }}s{{ end }}</span>
      </div>
      {{ if $articles }}
      <ul class="pillar-articles">
        {{ range $articles }}
        <li>
          <a href="{{ .Permalink }}">
            <time>{{ .Date.Format "Jan 2006" }}</time>
            <span>{{ .Title }}</span>
            {{ with .Params.author }}<em>{{ . }}</em>{{ end }}
          </a>
        </li>
        {{ end }}
      </ul>
      {{ end }}
    </div>
    {{ end }}
  </div>

{{ end }}
HTMLEOF

# ─── 8. ABOUT PAGE ───
echo "→ Creating enriched About page..."
mkdir -p content/about
cat > content/about/index.md << 'MDEOF'
---
title: "About"
description: "The story behind Pinterlude — who we are, why we left, and where we're going."
---

<div class="about-intro">
  <div class="about-intro-text">
    <h2>We are Marc & Linda.</h2>
    <p class="about-lead">Two Swiss. Seven children between us. Nearly sixty years of combined life in one of the most comfortable countries on earth. And one day, a decision that nobody around us understood.</p>
  </div>
</div>

---

## Marc

Three master's degrees and a doctorate in exercise physiology. Affiliated researcher at the University of Lausanne. Ultramarathon runner — 10 to 15 hours of training per week across trails, swimming, and cycling. Speaks French, English, Russian, and increasingly passable Spanish.

Currently building online education platforms, preparing for the ACSM-EP certification, and trying to convince his body that altitude in Colorado is "character building."

## Linda

A bachelor's and master's in English, earned while teaching and raising seven children. Ten years managing luxury construction projects. Now a literary translator across three languages — French, English, and Russian.

Launching her translation career in New York starting April 2026. The kind of person who reads Dostoevsky on the subway and doesn't think that's unusual.

---

## The plan

We left Switzerland in 2024. We're currently based in Colorado. Starting 2027, we begin traveling — six months a year at first, more after Marc gets his U.S. citizenship. South America first (Colombia, Argentina, Peru), then Southeast Asia, then wherever the roads lead.

We work online. We write. We run. We translate. And we document the whole thing here.

**Pinterlude** is a portmanteau: a *pin* dropped between two lives, an *interlude* that might just last twenty years.

---

## Find us elsewhere

- **Newsletter**: [Substack](https://pinterlude.substack.com)
- **Video essays**: [YouTube](#)
- **Contact**: hello@pinterlude.com
MDEOF

# ─── 9. FAVICON ───
echo "→ Creating favicon..."
cat > static/favicon.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect width="100" height="100" rx="20" fill="#1a1714"/>
  <text x="50" y="68" text-anchor="middle" font-family="Georgia, serif" font-size="55" font-weight="bold" fill="#FAF6F1">P</text>
</svg>
EOF

# ─── 10. DARK MODE + NEW STYLES ───
echo "→ Adding dark mode, newsletter, pillars, author card styles..."
cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   DARK MODE
   ═══════════════════════════════════════ */

[data-theme="dark"] {
  --ink: #FAF6F1;
  --paper: #141210;
  --terracotta: #E8755A;
  --terracotta-dark: #F09080;
  --text-secondary: #9E968D;
  --rule: #2A2725;
}

[data-theme="dark"] body { background: #141210; color: #FAF6F1; }

[data-theme="dark"] .intro-band { background: #1A1714; }
[data-theme="dark"] .intro-text { color: #9E968D; }
[data-theme="dark"] .intro-text strong { color: #FAF6F1; }
[data-theme="dark"] .intro-quote { color: #FAF6F1; }

[data-theme="dark"] .article-card-inner {
  background: #1E1B18 !important;
}
[data-theme="dark"] .article-card .article-title { color: #FAF6F1; }
[data-theme="dark"] .article-card .article-summary { color: #9E968D; }
[data-theme="dark"] .article-card .article-date { color: #6B635A; }
[data-theme="dark"] .article-card .article-number { color: #FAF6F1; }
[data-theme="dark"] .article-card .article-readmore { color: #E8755A; }

[data-theme="dark"] .article-card:nth-child(4n+1) .article-card-inner { background: linear-gradient(160deg, #2A1F1C 0%, #1E1B18 100%) !important; }
[data-theme="dark"] .article-card:nth-child(4n+2) .article-card-inner { background: linear-gradient(160deg, #1C2A26 0%, #1E1B18 100%) !important; }
[data-theme="dark"] .article-card:nth-child(4n+3) .article-card-inner { background: linear-gradient(160deg, #251C2A 0%, #1E1B18 100%) !important; }
[data-theme="dark"] .article-card:nth-child(4n+4) .article-card-inner { background: linear-gradient(160deg, #2A251C 0%, #1E1B18 100%) !important; }

[data-theme="dark"] .article-tag { background: rgba(250,246,241,0.08); color: #9E968D; }
[data-theme="dark"] .article-lang { background: rgba(250,246,241,0.08); color: #9E968D; }

[data-theme="dark"] .article-body { color: #D6CFC6; }
[data-theme="dark"] .article-body h2, [data-theme="dark"] .article-body h3 { color: #FAF6F1; }
[data-theme="dark"] .article-body blockquote { color: #9E968D; }
[data-theme="dark"] .article-body code { background: rgba(250,246,241,0.06); }

[data-theme="dark"] .site-footer { border-top-color: #2A2725; }
[data-theme="dark"] .footer-brand { color: #FAF6F1; }
[data-theme="dark"] .footer-text { color: #6B635A; }
[data-theme="dark"] .footer-links a { color: #6B635A; }

[data-theme="dark"] .article-tags-full { border-top-color: #2A2725; }
[data-theme="dark"] .article-tag-link { background: rgba(250,246,241,0.06); color: #9E968D; }
[data-theme="dark"] .article-crosslinks { background: rgba(250,246,241,0.03); }
[data-theme="dark"] .author-card { background: rgba(250,246,241,0.03); }
[data-theme="dark"] .author-card-name { color: #FAF6F1; }
[data-theme="dark"] .author-card-bio { color: #9E968D; }
[data-theme="dark"] .article-end { border-top-color: #2A2725; }
[data-theme="dark"] .back-link { color: #9E968D; }
[data-theme="dark"] .newsletter-band { background: #1A1714; }
[data-theme="dark"] .newsletter-desc { color: #9E968D; }

/* ─── THEME TOGGLE ─── */
.theme-toggle {
  background: none;
  border: 1.5px solid rgba(255,255,255,0.15);
  color: #fff;
  font-size: 1rem;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  justify-content: center;
  mix-blend-mode: difference;
}

.theme-toggle:hover {
  border-color: var(--terracotta);
  transform: scale(1.1);
}

/* ─── NEWSLETTER BAND ─── */
.newsletter-band {
  padding: 4rem 3rem;
  text-align: center;
  background: rgba(26,23,20,0.03);
}

.newsletter-inner {
  max-width: 500px;
  margin: 0 auto;
}

.newsletter-icon {
  font-size: 2rem;
  display: block;
  margin-bottom: 1rem;
}

.newsletter-title {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  color: var(--ink);
}

.newsletter-desc {
  font-family: var(--font-body);
  font-size: 0.95rem;
  font-weight: 300;
  color: var(--text-secondary);
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.newsletter-btn {
  display: inline-block;
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  color: #fff;
  background: var(--terracotta);
  padding: 0.8em 2em;
  border-radius: 50px;
  transition: all 0.3s;
}

.newsletter-btn:hover {
  background: var(--terracotta-dark);
  transform: translateY(-2px);
}

/* ─── AUTHOR CARD ─── */
.author-card {
  margin-top: 2.5rem;
  padding: 2rem;
  background: rgba(26,23,20,0.03);
  border-radius: 12px;
}

.author-card-inner {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.author-card-name {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--ink);
}

.author-card-bio {
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 300;
  line-height: 1.6;
  color: var(--text-secondary);
}

.author-card-link {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  color: var(--terracotta);
  text-decoration: none;
  transition: color 0.3s;
}

.author-card-link:hover { color: var(--terracotta-dark); }

/* ─── PILLARS PAGE ─── */
.pillars-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.pillar-section {
  margin-bottom: 2.5rem;
}

.pillar-header {
  padding: 2rem;
  border-radius: 12px;
  margin-bottom: 0.5rem;
}

.pillar-header--terracotta { background: linear-gradient(135deg, rgba(200,85,61,0.1), rgba(200,85,61,0.05)); border-left: 4px solid var(--terracotta); }
.pillar-header--teal { background: linear-gradient(135deg, rgba(42,122,110,0.1), rgba(42,122,110,0.05)); border-left: 4px solid var(--teal); }
.pillar-header--gold { background: linear-gradient(135deg, rgba(200,150,62,0.1), rgba(200,150,62,0.05)); border-left: 4px solid var(--gold); }
.pillar-header--plum { background: linear-gradient(135deg, rgba(107,58,93,0.1), rgba(107,58,93,0.05)); border-left: 4px solid var(--plum); }

.pillar-name {
  font-family: var(--font-display);
  font-size: 1.4rem;
  font-weight: 700;
  margin-bottom: 0.3rem;
}

.pillar-desc {
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 300;
  color: var(--text-secondary);
  line-height: 1.5;
}

.pillar-count {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-secondary);
  display: inline-block;
  margin-top: 0.8rem;
}

.pillar-articles {
  list-style: none;
  padding: 0 0 0 1.5rem;
}

.pillar-articles li {
  border-bottom: 1px solid rgba(26,23,20,0.06);
}

.pillar-articles a {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.8rem 0;
  text-decoration: none;
  color: var(--ink);
  transition: color 0.3s;
}

.pillar-articles a:hover { color: var(--terracotta); }

.pillar-articles time {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  color: var(--text-secondary);
  min-width: 70px;
}

.pillar-articles span {
  font-family: var(--font-display);
  font-size: 1rem;
  font-weight: 600;
  flex: 1;
}

.pillar-articles em {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-style: normal;
  color: var(--text-secondary);
}

/* ─── ABOUT PAGE ─── */
.about-intro {
  margin-bottom: 2rem;
}

.about-intro h2 {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 900;
  margin-bottom: 1rem;
}

.about-lead {
  font-family: var(--font-display);
  font-size: 1.2rem;
  font-style: italic;
  line-height: 1.6;
  color: var(--text-secondary);
}

/* ─── READING TIME ─── */
/* Already handled by Hugo's .ReadingTime — no extra CSS needed */

/* ─── RESPONSIVE ADDITIONS ─── */
@media (max-width: 900px) {
  .newsletter-band { padding: 3rem 1.5rem; }
  .pillars-page { padding: 2rem 1.5rem 4rem; }
}

@media (max-width: 600px) {
  .pillar-articles a { flex-wrap: wrap; gap: 0.3rem; }
  .pillar-articles time { min-width: auto; }
  .pillar-articles em { width: 100%; }
}
CSSEOF

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ Grand Enrichment complete!"
echo "═══════════════════════════════════════"
echo ""
echo "New features:"
echo "  ☾  Dark/Light mode toggle"
echo "  ✉  Newsletter Substack band"
echo "  📖  Reading time on articles"
echo "  🏷  Pillar pages: pinterlude.com/pillars/"
echo "  👤  Author cards on articles"
echo "  📡  RSS feed at /feed.xml"
echo "  🔗  Open Graph + Twitter Cards"
echo "  🎨  Favicon"
echo "  📄  Enriched About page"
echo ""
echo "Run 'hugo server --buildDrafts' to preview."
