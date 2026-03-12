#!/bin/bash
# Pinterlude — Readability Fixes
echo "→ Fixing readability issues..."

# 1. CSS fixes
cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   READABILITY FIXES
   ═══════════════════════════════════════ */

/* Hero ALWAYS dark regardless of theme */
.hero, .single-hero { background: #1a1714 !important; }
.hero .hero-title, .hero h1 { color: #FAF6F1 !important; }
.hero .hero-tagline { color: #F0D9CC !important; }
.hero .hero-desc { color: rgba(250,246,241,0.5) !important; }
.hero .hero-cta { color: #FAF6F1 !important; border-color: rgba(255,255,255,0.2) !important; }
.hero .hero-cta:hover { color: #E8755A !important; border-color: #E8755A !important; }
.hero .shape--1 { background: #C8553D !important; }
.hero .shape--2 { background: #2A7A6E !important; }
.hero .shape--3 { background: #6B3A5D !important; }
.hero .shape--4 { background: #C8963E !important; }
.single-hero .article-title { color: #FAF6F1 !important; }
.single-hero .article-date { color: rgba(250,246,241,0.4) !important; }
.scroll-hint svg { stroke: #F0D9CC !important; opacity: 0.35; }
#heroTitle::after { color: #C8553D !important; }

/* Nav: white text over hero, dark text when scrolled past */
.site-nav-bar { mix-blend-mode: normal; transition: background 0.3s, box-shadow 0.3s; }
.nav-logo { color: #FAF6F1 !important; transition: color 0.3s; }
.site-nav a { color: #FAF6F1 !important; transition: color 0.3s; }
.theme-toggle { color: #FAF6F1 !important; border-color: rgba(255,255,255,0.15) !important; }

.site-nav-bar.scrolled { background: var(--paper); box-shadow: 0 1px 10px rgba(0,0,0,0.06); }
.site-nav-bar.scrolled .nav-logo { color: var(--ink) !important; }
.site-nav-bar.scrolled .site-nav a { color: var(--ink) !important; }
.site-nav-bar.scrolled .site-nav a:hover { color: var(--terracotta) !important; }
.site-nav-bar.scrolled .theme-toggle { color: var(--ink) !important; border-color: var(--rule) !important; }

/* Featured card always dark */
.article-card.featured .article-card-inner { background: linear-gradient(160deg, #1a1714 0%, #2a2320 100%) !important; }
.article-card.featured .article-title { color: #FAF6F1 !important; }
.article-card.featured .article-summary { color: rgba(250,246,241,0.5) !important; }
.article-card.featured .article-date { color: rgba(250,246,241,0.4) !important; }
.article-card.featured .article-number { color: rgba(250,246,241,0.07) !important; }
.article-card.featured .article-readmore { color: #F0D9CC !important; }
.article-card.featured .article-tag { background: rgba(250,246,241,0.08) !important; color: rgba(250,246,241,0.4) !important; }
.article-card.featured .article-lang { background: rgba(250,246,241,0.12) !important; color: rgba(250,246,241,0.5) !important; }

/* Dark mode card borders */
[data-theme="dark"] .article-card:not(.featured) .article-card-inner { border: 1px solid rgba(250,246,241,0.06); }
[data-theme="dark"] .newsletter-title { color: #FAF6F1; }
[data-theme="dark"] .stat-number { color: #E8755A; }
CSSEOF

# 2. Add nav scroll JS by replacing the script in baseof.html
# We insert the scroll logic before the Identity comment
sed -i 's|// Netlify|// Nav scroll\n    const navEl = document.querySelector(".site-nav-bar");\n    if (navEl) {\n      window.addEventListener("scroll", () => {\n        navEl.classList.toggle("scrolled", window.scrollY > window.innerHeight * 0.7);\n      });\n      if (!document.querySelector(".hero")) navEl.classList.add("scrolled");\n    }\n\n    // Netlify|' layouts/_default/baseof.html

echo "✓ Readability fixes applied!"
echo "Run 'hugo server --buildDrafts' to preview."
