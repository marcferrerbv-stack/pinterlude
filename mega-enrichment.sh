#!/bin/bash
# Pinterlude — Mega Enrichment
# Reading bar, share, TOC, related, 404, search, lightbox, pull quotes, stats, transitions

echo "═══════════════════════════════════════"
echo "  PINTERLUDE — Mega Enrichment"
echo "═══════════════════════════════════════"

# ─── 1. UPDATED SINGLE ARTICLE TEMPLATE ───
echo "→ Upgrading single article template..."
cat > layouts/_default/single.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <!-- Reading Progress Bar -->
  <div class="reading-progress" id="readingProgress"></div>

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

    <!-- Table of Contents -->
    {{ if .TableOfContents }}
    {{ if gt (len .TableOfContents) 100 }}
    <details class="toc" open>
      <summary class="toc-title">Table of contents</summary>
      <div class="toc-inner">
        {{ .TableOfContents }}
      </div>
    </details>
    {{ end }}
    {{ end }}

    <!-- Share buttons (top) -->
    <div class="share-bar share-bar--top">
      <span class="share-label">Share</span>
      <a href="https://twitter.com/intent/tweet?url={{ .Permalink }}&text={{ .Title | urlquery }}" target="_blank" rel="noopener" class="share-btn share-btn--twitter" title="Share on Twitter">𝕏</a>
      <a href="https://wa.me/?text={{ .Title | urlquery }}%20{{ .Permalink }}" target="_blank" rel="noopener" class="share-btn share-btn--whatsapp" title="Share on WhatsApp">W</a>
      <a href="mailto:?subject={{ .Title | urlquery }}&body=Check%20this%20out:%20{{ .Permalink }}" class="share-btn share-btn--email" title="Share via email">✉</a>
      <button class="share-btn share-btn--copy" onclick="copyLink()" title="Copy link">⎘</button>
      <span class="share-copied" id="shareCopied">Copied!</span>
    </div>

    <div class="article-body">
      {{ .Content }}
    </div>

    <!-- Share buttons (bottom) -->
    <div class="share-bar share-bar--bottom">
      <span class="share-label">Share this article</span>
      <div class="share-btns">
        <a href="https://twitter.com/intent/tweet?url={{ .Permalink }}&text={{ .Title | urlquery }}" target="_blank" rel="noopener" class="share-btn-full share-btn--twitter">𝕏 Twitter</a>
        <a href="https://wa.me/?text={{ .Title | urlquery }}%20{{ .Permalink }}" target="_blank" rel="noopener" class="share-btn-full share-btn--whatsapp">WhatsApp</a>
        <a href="mailto:?subject={{ .Title | urlquery }}&body=Check%20this%20out:%20{{ .Permalink }}" class="share-btn-full share-btn--email">✉ Email</a>
        <button class="share-btn-full share-btn--copy" onclick="copyLink()">⎘ Copy link</button>
      </div>
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

    <!-- Related Articles -->
    {{ $related := first 3 (where (where .Site.RegularPages "Section" "blog") ".Permalink" "!=" .Permalink) }}
    {{ if $related }}
    <div class="related-articles">
      <p class="related-label">Keep reading</p>
      <div class="related-grid">
        {{ range $related }}
        <a href="{{ .Permalink }}" class="related-card">
          <div class="related-card-meta">
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
          </div>
          <h3>{{ .Title }}</h3>
          <time>{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} · {{ . }}{{ end }}</time>
        </a>
        {{ end }}
      </div>
    </div>
    {{ end }}
  </div>

  <div class="article-end">
    <a href="/" class="back-link">← Back to journal</a>
  </div>

  <!-- Scroll to top -->
  <button class="scroll-top" id="scrollTop" onclick="window.scrollTo({top:0,behavior:'smooth'})" aria-label="Back to top">↑</button>

  <script>
    // Reading progress bar
    window.addEventListener('scroll', () => {
      const bar = document.getElementById('readingProgress');
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      const scrolled = (window.scrollY / docHeight) * 100;
      bar.style.width = scrolled + '%';

      // Scroll to top visibility
      const btn = document.getElementById('scrollTop');
      if (window.scrollY > 600) { btn.classList.add('visible'); }
      else { btn.classList.remove('visible'); }
    });

    // Copy link
    function copyLink() {
      navigator.clipboard.writeText(window.location.href).then(() => {
        const el = document.getElementById('shareCopied');
        el.classList.add('visible');
        setTimeout(() => el.classList.remove('visible'), 2000);
      });
    }

    // Lightbox
    document.querySelectorAll('.article-body img').forEach(img => {
      img.style.cursor = 'zoom-in';
      img.addEventListener('click', () => {
        const lb = document.createElement('div');
        lb.className = 'lightbox';
        lb.innerHTML = '<img src="' + img.src + '" alt="' + (img.alt || '') + '"><button class="lightbox-close">&times;</button>';
        lb.addEventListener('click', () => lb.remove());
        document.body.appendChild(lb);
        requestAnimationFrame(() => lb.classList.add('visible'));
      });
    });
  </script>

{{ end }}
HTMLEOF

# ─── 2. CUSTOM 404 ───
echo "→ Creating custom 404 page..."
cat > layouts/404.html << 'HTMLEOF'
{{ define "main" }}{{ end }}
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Lost — Pinterlude</title>
  <link rel="stylesheet" href="/css/style.css">
  <link rel="icon" type="image/svg+xml" href="/favicon.svg">
</head>
<body>
  <section class="hero" style="min-height:100vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="shape shape--4"></div>
    <div class="hero-content" style="text-align:center;">
      <p style="font-family:var(--font-mono);font-size:0.8rem;letter-spacing:0.2em;text-transform:uppercase;color:rgba(250,246,241,0.4);margin-bottom:1rem;">404</p>
      <h1 style="font-family:var(--font-display);font-size:clamp(2.5rem,6vw,4.5rem);font-weight:900;color:var(--paper);line-height:1.1;margin-bottom:1.5rem;">Not all who wander<br>are lost.</h1>
      <p style="font-family:var(--font-display);font-style:italic;font-size:1.1rem;color:rgba(250,246,241,0.5);margin-bottom:2.5rem;">But this page is.</p>
      <a href="/" class="hero-cta">Back to the journal</a>
    </div>
  </section>
  <script>
    const theme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', theme);
  </script>
</body>
</html>
HTMLEOF

# ─── 3. SEARCH PAGE ───
echo "→ Creating search page..."
mkdir -p content/search
cat > content/search/_index.md << 'EOF'
---
title: "Search"
layout: "search"
---
EOF

mkdir -p layouts/search
cat > layouts/search/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:35vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:2.5rem;font-weight:900;color:var(--paper);">Search</h1>
    </div>
  </section>

  <div class="search-page">
    <input type="text" id="searchInput" class="search-input" placeholder="Search articles..." autofocus>
    <div id="searchResults" class="search-results"></div>
  </div>

  <!-- Search index -->
  <script>
    const searchIndex = [
      {{ range (where .Site.RegularPages "Section" "blog") }}
      {
        title: {{ .Title | jsonify }},
        url: {{ .Permalink | jsonify }},
        content: {{ .Plain | truncate 500 | jsonify }},
        description: {{ with .Params.description }}{{ . | jsonify }}{{ else }}""{{ end }},
        author: {{ with .Params.author }}{{ . | jsonify }}{{ else }}""{{ end }},
        pillar: {{ with .Params.pillar }}{{ . | jsonify }}{{ else }}""{{ end }},
        tags: {{ with .Params.tags }}{{ . | jsonify }}{{ else }}[]{{ end }},
        date: {{ .Date.Format "January 2, 2006" | jsonify }},
        location: {{ with .Params.location }}{{ . | jsonify }}{{ else }}""{{ end }},
        readingTime: {{ .ReadingTime }}
      },
      {{ end }}
    ];

    const input = document.getElementById('searchInput');
    const results = document.getElementById('searchResults');

    input.addEventListener('input', function() {
      const query = this.value.toLowerCase().trim();
      if (query.length < 2) { results.innerHTML = ''; return; }

      const matches = searchIndex.filter(item => {
        return item.title.toLowerCase().includes(query) ||
               item.content.toLowerCase().includes(query) ||
               item.description.toLowerCase().includes(query) ||
               item.author.toLowerCase().includes(query) ||
               (item.tags && item.tags.some(t => t.toLowerCase().includes(query))) ||
               (item.location && item.location.toLowerCase().includes(query));
      });

      if (matches.length === 0) {
        results.innerHTML = '<p class="search-empty">No articles found for "' + query + '"</p>';
        return;
      }

      results.innerHTML = matches.map(item => 
        '<a href="' + item.url + '" class="search-result">' +
          '<h3>' + item.title + '</h3>' +
          '<p class="search-result-meta">' + item.date + (item.author ? ' · ' + item.author : '') + ' · ' + item.readingTime + ' min read</p>' +
          (item.description ? '<p class="search-result-desc">' + item.description + '</p>' : '') +
        '</a>'
      ).join('');
    });
  </script>

{{ end }}
HTMLEOF

# ─── 4. UPDATE NAV WITH SEARCH ───
echo "→ Updating nav with search link..."
cat > layouts/partials/nav.html << 'HTMLEOF'
<nav class="site-nav-bar">
  <a href="/" class="nav-logo">Pinterlude</a>
  <div class="site-nav">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <a href="/search/" class="nav-search" title="Search">⌕</a>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle dark mode">☾</button>
  </div>
</nav>
HTMLEOF

# ─── 5. UPDATE FOOTER WITH STATS ───
echo "→ Updating footer with stats..."
cat > layouts/partials/footer.html << 'HTMLEOF'
<footer class="site-footer">
  <div class="footer-stats reveal">
    {{ $articles := where .Site.RegularPages "Section" "blog" }}
    {{ $authors := slice }}
    {{ $locations := slice }}
    {{ range $articles }}
      {{ with .Params.location }}
        {{ $locations = $locations | append . }}
      {{ end }}
    {{ end }}
    {{ $uniqueLocations := uniq $locations }}
    <div class="stat">
      <span class="stat-number">{{ len $articles }}</span>
      <span class="stat-label">article{{ if gt (len $articles) 1 }}s{{ end }}</span>
    </div>
    <div class="stat">
      <span class="stat-number">{{ len $uniqueLocations }}</span>
      <span class="stat-label">location{{ if gt (len $uniqueLocations) 1 }}s{{ end }}</span>
    </div>
    <div class="stat">
      <span class="stat-number">2</span>
      <span class="stat-label">writers</span>
    </div>
    <div class="stat">
      <span class="stat-number">∞</span>
      <span class="stat-label">roads ahead</span>
    </div>
  </div>
  <span class="footer-brand">Pinterlude</span>
  <p class="footer-text">&copy; 2026 — Marc &amp; Linda</p>
  <div class="footer-links">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <a href="/search/">Search</a>
    <a href="/feed.xml" title="RSS Feed">RSS</a>
  </div>
</footer>
HTMLEOF

# ─── 6. UPDATE BASEOF TO USE FOOTER PARTIAL ───
echo "→ Updating base template with footer partial..."
cat > layouts/_default/baseof.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ if .IsHome }}Pinterlude — The interlude between two lives{{ else }}{{ .Title }} — Pinterlude{{ end }}</title>
  <meta name="description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
  <meta property="og:title" content="{{ if .IsHome }}Pinterlude{{ else }}{{ .Title }}{{ end }}">
  <meta property="og:description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
  <meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
  <meta property="og:url" content="{{ .Permalink }}">
  <meta property="og:image" content="{{ with .Params.cover }}{{ . | absURL }}{{ else }}{{ .Site.Params.ogImage | absURL }}{{ end }}">
  <meta property="og:site_name" content="Pinterlude">
  <meta name="twitter:card" content="summary_large_image">
  {{ range .AlternativeOutputFormats }}
  <link rel="{{ .Rel }}" type="{{ .MediaType.Type }}" href="{{ .Permalink }}" title="{{ $.Site.Title }}">
  {{ end }}
  <link rel="icon" type="image/svg+xml" href="/favicon.svg">
  <link rel="stylesheet" href="/css/style.css">
  <script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
</head>
<body>

  <!-- Page transition overlay -->
  <div class="page-transition" id="pageTransition"></div>

  {{ block "main" . }}{{ end }}

  {{ partial "footer.html" . }}

  <script>
    // Theme
    const theme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', theme);
    document.querySelectorAll('.theme-toggle').forEach(btn => {
      btn.textContent = theme === 'dark' ? '☀' : '☾';
    });
    function toggleTheme() {
      const current = document.documentElement.getAttribute('data-theme');
      const next = current === 'light' ? 'dark' : 'light';
      document.documentElement.setAttribute('data-theme', next);
      localStorage.setItem('theme', next);
      document.querySelectorAll('.theme-toggle').forEach(btn => {
        btn.textContent = next === 'dark' ? '☀' : '☾';
      });
    }

    // Reveal
    const reveals = document.querySelectorAll('.reveal');
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) entry.target.classList.add('visible');
      });
    }, { threshold: 0.15 });
    reveals.forEach(el => observer.observe(el));

    // Page transitions
    document.querySelectorAll('a[href^="/"]').forEach(link => {
      link.addEventListener('click', function(e) {
        const href = this.getAttribute('href');
        if (href === window.location.pathname) return;
        e.preventDefault();
        document.getElementById('pageTransition').classList.add('active');
        setTimeout(() => { window.location.href = href; }, 300);
      });
    });

    // Identity
    if (window.netlifyIdentity) {
      window.netlifyIdentity.on("init", user => {
        if (!user) {
          window.netlifyIdentity.on("login", () => { document.location.href = "/admin/"; });
        }
      });
    }
  </script>
</body>
</html>
HTMLEOF

# ─── 7. MEGA CSS ADDITIONS ───
echo "→ Adding all new styles..."
cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   MEGA ENRICHMENT STYLES
   ═══════════════════════════════════════ */

/* ─── READING PROGRESS BAR ─── */
.reading-progress {
  position: fixed;
  top: 0;
  left: 0;
  height: 3px;
  background: var(--terracotta);
  z-index: 10000;
  width: 0%;
  transition: width 0.1s linear;
}

/* ─── SCROLL TO TOP ─── */
.scroll-top {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--terracotta);
  color: #fff;
  border: none;
  font-size: 1.2rem;
  cursor: pointer;
  z-index: 999;
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
  box-shadow: 0 4px 20px rgba(200,85,61,0.3);
}

.scroll-top.visible {
  opacity: 1;
  transform: translateY(0);
}

.scroll-top:hover {
  transform: translateY(-3px) scale(1.05);
  box-shadow: 0 6px 25px rgba(200,85,61,0.4);
}

/* ─── TABLE OF CONTENTS ─── */
.toc {
  margin-bottom: 2.5rem;
  padding: 1.5rem 2rem;
  background: rgba(26,23,20,0.03);
  border-radius: 12px;
  border-left: 3px solid var(--terracotta);
}

[data-theme="dark"] .toc {
  background: rgba(250,246,241,0.03);
}

.toc-title {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--terracotta);
  cursor: pointer;
  list-style: none;
  padding: 0;
}

.toc-title::-webkit-details-marker { display: none; }
.toc-title::before { content: "▸ "; }
details[open] > .toc-title::before { content: "▾ "; }

.toc-inner {
  margin-top: 1rem;
}

.toc-inner nav > ul {
  list-style: none;
  padding: 0;
}

.toc-inner li {
  margin-bottom: 0.4rem;
}

.toc-inner a {
  font-family: var(--font-body);
  font-size: 0.88rem;
  font-weight: 400;
  color: var(--text-secondary);
  text-decoration: none;
  transition: color 0.2s;
}

.toc-inner a:hover { color: var(--terracotta); }

.toc-inner ul ul {
  padding-left: 1.2rem;
  margin-top: 0.3rem;
}

.toc-inner ul ul a { font-size: 0.82rem; }

/* ─── SHARE BUTTONS (top - inline) ─── */
.share-bar--top {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  margin-bottom: 2rem;
  padding-bottom: 1.5rem;
  border-bottom: 1px solid var(--rule);
  position: relative;
}

.share-label {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-right: 0.3rem;
}

.share-btn {
  width: 34px;
  height: 34px;
  border-radius: 50%;
  border: 1.5px solid var(--rule);
  background: none;
  color: var(--text-secondary);
  font-size: 0.85rem;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  text-decoration: none;
  transition: all 0.3s;
}

.share-btn:hover {
  border-color: var(--terracotta);
  color: var(--terracotta);
  transform: translateY(-2px);
}

.share-copied {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  color: var(--teal);
  opacity: 0;
  transition: opacity 0.3s;
  position: absolute;
  right: 0;
}

.share-copied.visible { opacity: 1; }

/* ─── SHARE BUTTONS (bottom - full width) ─── */
.share-bar--bottom {
  margin-top: 2.5rem;
  padding: 2rem;
  background: rgba(26,23,20,0.03);
  border-radius: 12px;
  text-align: center;
}

[data-theme="dark"] .share-bar--bottom { background: rgba(250,246,241,0.03); }

.share-bar--bottom .share-label {
  display: block;
  margin-bottom: 1rem;
  font-size: 0.7rem;
}

.share-btns {
  display: flex;
  justify-content: center;
  gap: 0.6rem;
  flex-wrap: wrap;
}

.share-btn-full {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  padding: 0.6em 1.2em;
  border-radius: 8px;
  border: 1.5px solid var(--rule);
  background: none;
  color: var(--text-secondary);
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s;
  display: inline-flex;
  align-items: center;
  gap: 0.3rem;
}

.share-btn-full:hover {
  border-color: var(--terracotta);
  color: var(--terracotta);
  transform: translateY(-2px);
}

/* ─── RELATED ARTICLES ─── */
.related-articles {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid var(--rule);
}

.related-label {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--terracotta);
  margin-bottom: 1.2rem;
}

.related-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.related-card {
  padding: 1.2rem;
  border-radius: 10px;
  background: rgba(26,23,20,0.03);
  text-decoration: none;
  color: inherit;
  transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

[data-theme="dark"] .related-card { background: rgba(250,246,241,0.03); }

.related-card:hover {
  transform: translateY(-3px);
  background: rgba(26,23,20,0.06);
}

[data-theme="dark"] .related-card:hover { background: rgba(250,246,241,0.06); }

.related-card-meta { margin-bottom: 0.5rem; }

.related-card h3 {
  font-family: var(--font-display);
  font-size: 1rem;
  font-weight: 700;
  line-height: 1.3;
  margin-bottom: 0.4rem;
}

.related-card time {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  color: var(--text-secondary);
}

/* ─── LIGHTBOX ─── */
.lightbox {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.92);
  z-index: 10001;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: zoom-out;
  opacity: 0;
  transition: opacity 0.3s;
}

.lightbox.visible { opacity: 1; }

.lightbox img {
  max-width: 90vw;
  max-height: 90vh;
  object-fit: contain;
  border-radius: 4px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5);
}

.lightbox-close {
  position: absolute;
  top: 1.5rem;
  right: 1.5rem;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  border: none;
  background: rgba(255,255,255,0.1);
  color: #fff;
  font-size: 1.5rem;
  cursor: pointer;
  transition: background 0.3s;
}

.lightbox-close:hover { background: rgba(255,255,255,0.2); }

/* ─── PULL QUOTES ─── */
.article-body .pull-quote,
.article-body blockquote.pull-quote {
  border-left: none;
  padding: 2rem 0;
  margin: 2.5rem 0;
  text-align: center;
  font-family: var(--font-display);
  font-size: 1.6rem;
  font-weight: 400;
  font-style: italic;
  line-height: 1.45;
  color: var(--terracotta);
  position: relative;
}

.article-body .pull-quote::before {
  content: "";
  display: block;
  width: 60px;
  height: 2px;
  background: var(--terracotta);
  margin: 0 auto 1.5rem;
}

.article-body .pull-quote::after {
  content: "";
  display: block;
  width: 60px;
  height: 2px;
  background: var(--terracotta);
  margin: 1.5rem auto 0;
}

/* ─── PAGE TRANSITIONS ─── */
.page-transition {
  position: fixed;
  inset: 0;
  background: var(--ink);
  z-index: 99999;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.3s ease;
}

.page-transition.active {
  opacity: 1;
  pointer-events: all;
}

/* ─── SEARCH PAGE ─── */
.search-page {
  max-width: 700px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.search-input {
  width: 100%;
  font-family: var(--font-body);
  font-size: 1.2rem;
  font-weight: 300;
  padding: 1rem 0;
  border: none;
  border-bottom: 2px solid var(--rule);
  background: transparent;
  color: var(--ink);
  outline: none;
  transition: border-color 0.3s;
}

.search-input:focus { border-bottom-color: var(--terracotta); }
.search-input::placeholder { color: var(--text-secondary); }

[data-theme="dark"] .search-input { color: #FAF6F1; border-bottom-color: #2A2725; }
[data-theme="dark"] .search-input:focus { border-bottom-color: var(--terracotta); }

.search-results { margin-top: 2rem; }

.search-result {
  display: block;
  padding: 1.2rem 0;
  border-bottom: 1px solid var(--rule);
  text-decoration: none;
  color: inherit;
  transition: all 0.3s;
}

.search-result:hover { padding-left: 0.5rem; }

.search-result h3 {
  font-family: var(--font-display);
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 0.3rem;
  color: var(--ink);
}

[data-theme="dark"] .search-result h3 { color: #FAF6F1; }

.search-result-meta {
  font-family: var(--font-mono);
  font-size: 0.68rem;
  color: var(--text-secondary);
  margin-bottom: 0.3rem;
}

.search-result-desc {
  font-size: 0.9rem;
  font-weight: 300;
  color: var(--text-secondary);
  line-height: 1.5;
}

.search-empty {
  font-family: var(--font-display);
  font-style: italic;
  font-size: 1.1rem;
  color: var(--text-secondary);
  margin-top: 2rem;
}

/* ─── NAV SEARCH ICON ─── */
.nav-search {
  font-size: 1.2rem !important;
  letter-spacing: 0 !important;
}

/* ─── FOOTER STATS ─── */
.footer-stats {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-bottom: 2rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid rgba(26,23,20,0.06);
}

[data-theme="dark"] .footer-stats { border-bottom-color: #2A2725; }

.stat {
  text-align: center;
}

.stat-number {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 900;
  color: var(--terracotta);
  display: block;
  line-height: 1;
}

.stat-label {
  font-family: var(--font-mono);
  font-size: 0.6rem;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-top: 0.3rem;
  display: block;
}

/* ─── RESPONSIVE ADDITIONS ─── */
@media (max-width: 900px) {
  .related-grid { grid-template-columns: 1fr; }
  .footer-stats { gap: 1.5rem; }
  .stat-number { font-size: 1.5rem; }
  .search-page { padding: 2rem 1.5rem 4rem; }
}

@media (max-width: 600px) {
  .share-bar--top { flex-wrap: wrap; }
  .share-btns { flex-direction: column; }
  .share-btn-full { justify-content: center; }
  .scroll-top { bottom: 1rem; right: 1rem; width: 38px; height: 38px; }
  .footer-stats { flex-wrap: wrap; gap: 1.5rem; }
  .stat { min-width: 80px; }
}
CSSEOF

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ Mega Enrichment complete!"
echo "═══════════════════════════════════════"
echo ""
echo "New features:"
echo "  📊  Reading progress bar"
echo "  📤  Share buttons (Twitter, WhatsApp, email, copy)"
echo "  📑  Auto table of contents"
echo "  📎  Related articles"
echo "  🚫  Custom 404 page"
echo "  ⬆   Scroll to top button"
echo "  🔍  Search page"
echo "  ✨  Page transitions"
echo "  🖼  Photo lightbox"
echo "  💬  Pull quotes (use <blockquote class='pull-quote'>)"
echo "  📈  Footer stats"
echo ""
echo "To use pull quotes in articles:"
echo '  <blockquote class="pull-quote">Your quote here</blockquote>'
echo ""
echo "Run 'hugo server --buildDrafts' to preview."
