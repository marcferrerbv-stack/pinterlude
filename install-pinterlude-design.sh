#!/bin/bash
# Pinterlude Design Installation Script
# Run this from your ~/Documents/pinterlude directory

echo "Installing Pinterlude editorial design..."

# --- CSS ---
cat > static/css/style.css << 'CSSEOF'
/* ============================================
   PINTERLUDE — Editorial Design
   "The interlude between two lives"
   ============================================ */

@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Source+Serif+4:ital,opsz,wght@0,8..60,300;0,8..60,400;0,8..60,600;1,8..60,300;1,8..60,400&family=JetBrains+Mono:wght@400&display=swap');

:root {
  --color-bg: #FAF9F6;
  --color-text: #1C1917;
  --color-text-secondary: #78716C;
  --color-accent: #9A3412;
  --color-rule: #D6D3D1;
  --color-rule-dark: #A8A29E;
  --color-hover: #7C2D12;
  --color-surface: #F5F5F0;
  --font-display: 'Playfair Display', Georgia, serif;
  --font-body: 'Source Serif 4', Georgia, serif;
  --font-mono: 'JetBrains Mono', monospace;
  --max-width: 720px;
  --space-xs: 0.5rem;
  --space-sm: 1rem;
  --space-md: 2rem;
  --space-lg: 3rem;
  --space-xl: 5rem;
}

*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

html {
  font-size: 18px;
  scroll-behavior: smooth;
  -webkit-font-smoothing: antialiased;
}

body {
  font-family: var(--font-body);
  font-weight: 300;
  color: var(--color-text);
  background-color: var(--color-bg);
  line-height: 1.75;
}

::selection { background: var(--color-accent); color: #fff; }

/* --- Header --- */
.site-header {
  padding: var(--space-xl) var(--space-md) var(--space-lg);
  text-align: center;
  border-bottom: 1px solid var(--color-rule);
}

.site-title {
  font-family: var(--font-display);
  font-size: 3rem;
  font-weight: 900;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--color-text);
  text-decoration: none;
  display: inline-block;
  line-height: 1.1;
}

.site-title:hover { color: var(--color-accent); }

.site-tagline {
  font-family: var(--font-display);
  font-style: italic;
  font-weight: 400;
  font-size: 1.15rem;
  color: var(--color-text-secondary);
  margin-top: var(--space-xs);
  letter-spacing: 0.02em;
}

.site-nav {
  margin-top: var(--space-md);
  display: flex;
  justify-content: center;
  gap: var(--space-md);
}

.site-nav a {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text-secondary);
  padding-bottom: 2px;
  border-bottom: 1px solid transparent;
  transition: color 0.3s, border-color 0.3s;
}

.site-nav a:hover {
  color: var(--color-accent);
  border-bottom-color: var(--color-accent);
}

/* --- Main --- */
.site-main {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-lg) var(--space-md);
}

/* --- Home Intro --- */
.page-intro {
  padding: var(--space-xl) 0;
  border-bottom: 1px solid var(--color-rule);
  margin-bottom: var(--space-lg);
}

.page-intro p {
  font-family: var(--font-display);
  font-size: 1.3rem;
  font-weight: 400;
  font-style: italic;
  line-height: 1.65;
  color: var(--color-text);
  max-width: 600px;
}

/* --- Section Label --- */
.section-label {
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--color-accent);
  margin-bottom: var(--space-md);
}

/* --- Article List --- */
.article-list { list-style: none; }

.article-item {
  padding: var(--space-lg) 0;
  border-bottom: 1px solid var(--color-rule);
}

.article-item:first-child { padding-top: 0; }

.article-date {
  font-family: var(--font-mono);
  font-size: 0.72rem;
  letter-spacing: 0.05em;
  color: var(--color-text-secondary);
  display: block;
  margin-bottom: var(--space-xs);
}

.article-title {
  font-family: var(--font-display);
  font-size: 1.8rem;
  font-weight: 700;
  line-height: 1.25;
  margin-bottom: 0.6rem;
}

.article-title a {
  color: var(--color-text);
  text-decoration: none;
  transition: color 0.3s;
}

.article-title a:hover { color: var(--color-accent); }

.article-summary {
  font-size: 1rem;
  font-weight: 300;
  line-height: 1.7;
  color: var(--color-text-secondary);
}

.article-read-more {
  display: inline-block;
  margin-top: var(--space-sm);
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-accent);
  border-bottom: 1px solid var(--color-accent);
  padding-bottom: 1px;
  transition: color 0.3s, border-color 0.3s;
}

.article-read-more:hover {
  color: var(--color-hover);
  border-color: var(--color-hover);
}

/* --- Featured Article --- */
.article-item.featured .article-title { font-size: 2.4rem; }
.article-item.featured .article-summary { font-size: 1.1rem; }

/* --- Single Article --- */
.article-header {
  padding: var(--space-xl) 0 var(--space-lg);
  border-bottom: 1px solid var(--color-rule);
  margin-bottom: var(--space-lg);
}

.article-header .article-date { margin-bottom: var(--space-sm); }

.article-header .article-title {
  font-size: 2.6rem;
  font-weight: 900;
  line-height: 1.15;
  margin-bottom: 0;
  max-width: 650px;
}

/* --- Article Body --- */
.article-body { font-size: 1.05rem; line-height: 1.8; }
.article-body p { margin-bottom: 1.5rem; }

.article-body h2 {
  font-family: var(--font-display);
  font-size: 1.6rem;
  font-weight: 700;
  margin-top: var(--space-lg);
  margin-bottom: var(--space-sm);
  line-height: 1.3;
}

.article-body h3 {
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 700;
  margin-top: var(--space-md);
  margin-bottom: var(--space-xs);
}

.article-body blockquote {
  margin: var(--space-md) 0;
  padding: var(--space-sm) 0 var(--space-sm) var(--space-md);
  border-left: 3px solid var(--color-accent);
  font-family: var(--font-display);
  font-style: italic;
  font-size: 1.15rem;
  line-height: 1.65;
  color: var(--color-text-secondary);
}

.article-body a {
  color: var(--color-accent);
  text-decoration: underline;
  text-underline-offset: 3px;
  transition: color 0.3s;
}

.article-body a:hover { color: var(--color-hover); }
.article-body img { max-width: 100%; height: auto; margin: var(--space-md) 0; }
.article-body ul, .article-body ol { margin-bottom: 1.5rem; padding-left: 1.5rem; }
.article-body li { margin-bottom: 0.5rem; }

.article-body code {
  font-family: var(--font-mono);
  font-size: 0.85em;
  background: var(--color-surface);
  padding: 0.15em 0.4em;
  border-radius: 3px;
}

.article-body pre {
  background: var(--color-text);
  color: var(--color-bg);
  padding: var(--space-md);
  overflow-x: auto;
  margin: var(--space-md) 0;
  border-radius: 4px;
}

.article-body pre code { background: none; padding: 0; color: inherit; }

.article-body hr {
  border: none;
  border-top: 1px solid var(--color-rule);
  margin: var(--space-lg) 0;
}

/* --- Separator --- */
.separator {
  text-align: center;
  margin: var(--space-lg) 0;
  color: var(--color-rule-dark);
  font-size: 1.2rem;
  letter-spacing: 0.5em;
}

/* --- Article Footer --- */
.article-footer {
  margin-top: var(--space-xl);
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-rule);
}

.back-link {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text-secondary);
  transition: color 0.3s;
}

.back-link:hover { color: var(--color-accent); }

/* --- About Page --- */
.about-body { font-size: 1.05rem; line-height: 1.8; }
.about-body p { margin-bottom: 1.5rem; }

.about-body h2 {
  font-family: var(--font-display);
  font-size: 1.4rem;
  font-weight: 700;
  margin-top: var(--space-lg);
  margin-bottom: var(--space-sm);
}

/* --- Site Footer --- */
.site-footer {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-xl) var(--space-md) var(--space-lg);
  border-top: 1px solid var(--color-rule);
  text-align: center;
}

.footer-text {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  letter-spacing: 0.05em;
  color: var(--color-text-secondary);
}

.footer-links {
  margin-top: var(--space-sm);
  display: flex;
  justify-content: center;
  gap: var(--space-md);
}

.footer-links a {
  font-family: var(--font-body);
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text-secondary);
  transition: color 0.3s;
}

.footer-links a:hover { color: var(--color-accent); }

/* --- Responsive --- */
@media (max-width: 640px) {
  html { font-size: 16px; }
  .site-header { padding: var(--space-lg) var(--space-sm) var(--space-md); }
  .site-title { font-size: 2rem; }
  .site-tagline { font-size: 1rem; }
  .site-nav { gap: var(--space-sm); }
  .site-main { padding: var(--space-md) var(--space-sm); }
  .article-title { font-size: 1.5rem; }
  .article-item.featured .article-title { font-size: 1.8rem; }
  .article-header .article-title { font-size: 2rem; }
  .page-intro p { font-size: 1.1rem; }
}
CSSEOF

# --- Base Template ---
cat > layouts/_default/baseof.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{ if .IsHome }}Pinterlude — The interlude between two lives{{ else }}{{ .Title }} — Pinterlude{{ end }}</title>
  <meta name="description" content="{{ with .Params.description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
  <link rel="stylesheet" href="/css/style.css">
  <script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
</head>
<body>
  <header class="site-header">
    <a href="/" class="site-title">Pinterlude</a>
    <p class="site-tagline">The interlude between two lives</p>
    <nav class="site-nav">
      <a href="/">Journal</a>
      <a href="/about/">About</a>
    </nav>
  </header>
  <main class="site-main">
    {{ block "main" . }}{{ end }}
  </main>
  <footer class="site-footer">
    <p class="footer-text">&copy; 2026 Pinterlude — Marc &amp; Linda</p>
    <div class="footer-links">
      <a href="/">Journal</a>
      <a href="/about/">About</a>
    </div>
  </footer>
  <script>
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

# --- Home Page Template ---
cat > layouts/index.html << 'HTMLEOF'
{{ define "main" }}
  <div class="page-intro">
    <p>A couple of Swiss intellectuals — a sports scientist and a literary translator — left comfort behind to see the world before it's too late. This is not a travel blog. It's the journal of a radical life choice.</p>
  </div>
  <p class="section-label">Latest</p>
  <ul class="article-list">
    {{ range $index, $page := (where .Site.RegularPages "Section" "blog").ByDate.Reverse }}
    <li class="article-item{{ if eq $index 0 }} featured{{ end }}">
      <time class="article-date" datetime="{{ .Date.Format "2006-01-02" }}">{{ .Date.Format "January 2, 2006" }}</time>
      <h2 class="article-title"><a href="{{ .Permalink }}">{{ .Title }}</a></h2>
      {{ if .Summary }}
      <p class="article-summary">{{ .Summary | plainify | truncate 200 }}</p>
      {{ end }}
      <a href="{{ .Permalink }}" class="article-read-more">Read →</a>
    </li>
    {{ end }}
  </ul>
{{ end }}
HTMLEOF

# --- List Template ---
cat > layouts/_default/list.html << 'HTMLEOF'
{{ define "main" }}
  <h1 class="article-title" style="margin-bottom: var(--space-lg);">{{ .Title }}</h1>
  {{ .Content }}
  <ul class="article-list">
    {{ range .Pages.ByDate.Reverse }}
    <li class="article-item">
      <time class="article-date" datetime="{{ .Date.Format "2006-01-02" }}">{{ .Date.Format "January 2, 2006" }}</time>
      <h2 class="article-title"><a href="{{ .Permalink }}">{{ .Title }}</a></h2>
      {{ if .Summary }}
      <p class="article-summary">{{ .Summary | plainify | truncate 200 }}</p>
      {{ end }}
      <a href="{{ .Permalink }}" class="article-read-more">Read →</a>
    </li>
    {{ end }}
  </ul>
{{ end }}
HTMLEOF

# --- Single Article Template ---
cat > layouts/_default/single.html << 'HTMLEOF'
{{ define "main" }}
  <article>
    <header class="article-header">
      <time class="article-date" datetime="{{ .Date.Format "2006-01-02" }}">{{ .Date.Format "January 2, 2006" }}</time>
      <h1 class="article-title">{{ .Title }}</h1>
    </header>
    <div class="article-body">
      {{ .Content }}
    </div>
    <div class="separator">· · ·</div>
    <footer class="article-footer">
      <a href="/" class="back-link">← Back to journal</a>
    </footer>
  </article>
{{ end }}
HTMLEOF

# --- About Page ---
mkdir -p content/about
cat > content/about/index.md << 'MDEOF'
---
title: "About"
---

We are Marc and Linda.

He has a doctorate in exercise physiology, runs ultramarathons, and thinks in systems. She translates literature across three languages and sees the world through stories. Together, we have seven children between us.

After nearly thirty years each in Switzerland — stable careers, beautiful mountains, excellent cheese — we made a decision that no one around us understood: we left.

Not for a vacation. Not for a sabbatical. We moved to the United States, and from there, we plan to spend the next twenty years seeing the world. Working online, writing, running trails on other continents, translating books in rented apartments with unfamiliar light.

**Pinterlude** is the journal of that choice. The word is a portmanteau — a *pin* dropped between two lives, an *interlude* that might last forever.

## What we write about

We write about the decision itself — why comfort is not the same as life. We write about places, but not the way guidebooks do: what a city smells like at dawn, what the altitude does to your lungs, what it means to be foreign. We write about money, logistics, visas, and the bureaucracy of freedom. And sometimes, we just write because the light was good and the coffee was strong.

## Where to find us

This site is our home base. We also publish a newsletter on [Substack](#) and occasional essays on [YouTube](#).

If you want to reach us: hello@pinterlude.com
MDEOF

echo "✓ Design installed successfully!"
echo "Run 'hugo server' to preview locally."
