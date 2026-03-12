#!/bin/bash
# Pinterlude Design C — "Clarté" (Modern Editorial)
# Clean, contemporary, Monocle-inspired

echo "Installing Pinterlude design C — Clarté..."

cat > static/css/style.css << 'CSSEOF'
@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Newsreader:ital,opsz,wght@0,6..72,300;0,6..72,400;0,6..72,500;1,6..72,300;1,6..72,400&family=Space+Mono:wght@400;700&display=swap');

:root {
  --color-bg: #FFFFFF;
  --color-text: #111111;
  --color-text-secondary: #666666;
  --color-accent: #CC4400;
  --color-rule: #E5E5E5;
  --color-rule-dark: #999999;
  --color-hover: #993300;
  --color-surface: #F7F7F7;
  --font-display: 'DM Serif Display', Georgia, serif;
  --font-body: 'Newsreader', Georgia, serif;
  --font-mono: 'Space Mono', monospace;
  --max-width: 700px;
  --space-xs: 0.5rem;
  --space-sm: 1rem;
  --space-md: 2rem;
  --space-lg: 3rem;
  --space-xl: 5rem;
}

*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html { font-size: 18px; scroll-behavior: smooth; -webkit-font-smoothing: antialiased; }

body {
  font-family: var(--font-body);
  font-weight: 300;
  color: var(--color-text);
  background-color: var(--color-bg);
  line-height: 1.75;
}

::selection { background: var(--color-text); color: #fff; }

.site-header {
  padding: var(--space-lg) var(--space-md);
  max-width: var(--max-width);
  margin: 0 auto;
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  border-bottom: 3px solid var(--color-text);
}

.site-title {
  font-family: var(--font-display);
  font-size: 1.8rem;
  font-weight: 400;
  color: var(--color-text);
  text-decoration: none;
  line-height: 1;
}

.site-title:hover { color: var(--color-accent); }

.site-tagline { display: none; }

.site-nav {
  display: flex;
  gap: var(--space-md);
}

.site-nav a {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 700;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text);
  transition: color 0.2s;
}

.site-nav a:hover { color: var(--color-accent); }

.site-main {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-lg) var(--space-md);
}

.page-intro {
  padding: var(--space-lg) 0 var(--space-xl);
  margin-bottom: 0;
  border-bottom: none;
}

.page-intro p {
  font-family: var(--font-display);
  font-size: 2.2rem;
  font-weight: 400;
  font-style: italic;
  line-height: 1.35;
  color: var(--color-text);
}

.section-label {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 700;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--color-text);
  margin-bottom: var(--space-sm);
  padding-bottom: var(--space-xs);
  border-bottom: 1px solid var(--color-rule);
}

.article-list { list-style: none; }

.article-item {
  padding: var(--space-md) 0;
  border-bottom: 1px solid var(--color-rule);
  display: grid;
  grid-template-columns: 140px 1fr;
  grid-template-rows: auto auto auto;
  gap: 0 var(--space-md);
  align-items: start;
}

.article-item:first-child { padding-top: var(--space-sm); }

.article-date {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  letter-spacing: 0.05em;
  color: var(--color-text-secondary);
  grid-column: 1;
  grid-row: 1;
  padding-top: 0.35rem;
}

.article-title {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 400;
  line-height: 1.25;
  margin-bottom: 0.4rem;
  grid-column: 2;
  grid-row: 1;
}

.article-title a {
  color: var(--color-text);
  text-decoration: none;
  transition: color 0.2s;
}

.article-title a:hover { color: var(--color-accent); }

.article-summary {
  font-size: 0.9rem;
  font-weight: 300;
  line-height: 1.65;
  color: var(--color-text-secondary);
  grid-column: 2;
  grid-row: 2;
}

.article-read-more {
  display: inline-block;
  margin-top: 0.6rem;
  font-family: var(--font-mono);
  font-size: 0.6rem;
  font-weight: 700;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-accent);
  grid-column: 2;
  grid-row: 3;
  transition: color 0.2s;
}

.article-read-more:hover { color: var(--color-hover); }

.article-item.featured .article-title { font-size: 1.8rem; }

.article-header {
  padding: var(--space-xl) 0 var(--space-lg);
  border-bottom: 3px solid var(--color-text);
  margin-bottom: var(--space-lg);
}

.article-header .article-date { margin-bottom: var(--space-sm); }

.article-header .article-title {
  font-size: 2.8rem;
  line-height: 1.1;
  margin-bottom: 0;
}

.article-body { font-size: 1.05rem; line-height: 1.8; }
.article-body p { margin-bottom: 1.5rem; }

.article-body h2 {
  font-family: var(--font-display);
  font-size: 1.6rem;
  font-weight: 400;
  margin-top: var(--space-lg);
  margin-bottom: var(--space-sm);
}

.article-body h3 {
  font-family: var(--font-mono);
  font-size: 0.75rem;
  font-weight: 700;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  margin-top: var(--space-md);
  margin-bottom: var(--space-xs);
}

.article-body blockquote {
  margin: var(--space-md) 0;
  padding: var(--space-sm) 0 var(--space-sm) var(--space-md);
  border-left: 3px solid var(--color-text);
  font-family: var(--font-display);
  font-style: italic;
  font-size: 1.2rem;
  line-height: 1.5;
  color: var(--color-text);
}

.article-body a {
  color: var(--color-accent);
  text-decoration: underline;
  text-underline-offset: 3px;
}

.article-body a:hover { color: var(--color-hover); }
.article-body img { max-width: 100%; height: auto; margin: var(--space-md) 0; }
.article-body ul, .article-body ol { margin-bottom: 1.5rem; padding-left: 1.5rem; }
.article-body li { margin-bottom: 0.5rem; }

.article-body code {
  font-family: var(--font-mono);
  font-size: 0.82em;
  background: var(--color-surface);
  padding: 0.15em 0.4em;
}

.article-body pre {
  background: var(--color-text);
  color: #fff;
  padding: var(--space-md);
  overflow-x: auto;
  margin: var(--space-md) 0;
}

.article-body pre code { background: none; padding: 0; color: inherit; }

.article-body hr {
  border: none;
  border-top: 1px solid var(--color-rule);
  margin: var(--space-lg) 0;
}

.separator {
  text-align: center;
  margin: var(--space-lg) 0;
  font-family: var(--font-mono);
  font-size: 0.7rem;
  color: var(--color-rule-dark);
  letter-spacing: 0.3em;
}

.article-footer {
  margin-top: var(--space-xl);
  padding-top: var(--space-lg);
  border-top: 3px solid var(--color-text);
}

.back-link {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  font-weight: 700;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text);
  transition: color 0.2s;
}

.back-link:hover { color: var(--color-accent); }

.about-body { font-size: 1.05rem; line-height: 1.8; }
.about-body p { margin-bottom: 1.5rem; }
.about-body h2 {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 400;
  margin-top: var(--space-lg);
  margin-bottom: var(--space-sm);
}

.site-footer {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-lg) var(--space-md);
  border-top: 3px solid var(--color-text);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer-text {
  font-family: var(--font-mono);
  font-size: 0.6rem;
  font-weight: 700;
  letter-spacing: 0.05em;
  color: var(--color-text-secondary);
  text-transform: uppercase;
}

.footer-links {
  display: flex;
  gap: var(--space-md);
}

.footer-links a {
  font-family: var(--font-mono);
  font-size: 0.6rem;
  font-weight: 700;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--color-text-secondary);
  transition: color 0.2s;
}

.footer-links a:hover { color: var(--color-accent); }

@media (max-width: 640px) {
  html { font-size: 16px; }
  .site-header { flex-direction: column; align-items: flex-start; gap: var(--space-sm); padding: var(--space-md) var(--space-sm); }
  .site-main { padding: var(--space-md) var(--space-sm); }
  .article-item { grid-template-columns: 1fr; }
  .article-date { grid-column: 1; margin-bottom: 0.2rem; }
  .article-title { grid-column: 1; grid-row: 2; font-size: 1.3rem; }
  .article-summary { grid-column: 1; grid-row: 3; }
  .article-read-more { grid-column: 1; grid-row: 4; }
  .article-item.featured .article-title { font-size: 1.5rem; }
  .article-header .article-title { font-size: 2rem; }
  .page-intro p { font-size: 1.6rem; }
  .site-footer { flex-direction: column; gap: var(--space-sm); text-align: center; }
}
CSSEOF

echo "✓ Design C (Clarté) installed!"
echo "Run 'hugo server' to preview."
