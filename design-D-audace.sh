#!/bin/bash
# Pinterlude Design D — "Audace" (Bold Editorial)
# Inspired by Whims & Words energy, adapted for a literary journal

echo "Installing Pinterlude design D — Audace..."

# --- CSS ---
cat > static/css/style.css << 'CSSEOF'
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=Outfit:wght@300;400;500;600&family=Caveat:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500&display=swap');

:root {
  --ink: #1a1714;
  --paper: #FAF6F1;
  --terracotta: #C8553D;
  --terracotta-dark: #A13E2B;
  --teal: #2A7A6E;
  --gold: #C8963E;
  --plum: #6B3A5D;
  --blush: #F0D9CC;
  --sage: #a8c5b0;
  --rule: #D6CFC6;
  --text-secondary: #6B635A;
  --font-display: 'Playfair Display', Georgia, serif;
  --font-body: 'Outfit', sans-serif;
  --font-accent: 'Caveat', cursive;
  --font-mono: 'IBM Plex Mono', monospace;
  --max-width: 1100px;
  --content-width: 720px;
}

*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html { scroll-behavior: smooth; }

body {
  font-family: var(--font-body);
  font-weight: 300;
  background: var(--paper);
  color: var(--ink);
  overflow-x: hidden;
  line-height: 1.7;
}

/* Grain overlay */
body::before {
  content: '';
  position: fixed;
  inset: 0;
  z-index: 9999;
  pointer-events: none;
  opacity: 0.02;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
  background-size: 150px;
}

::selection { background: var(--terracotta); color: #fff; }

/* ─── NAVIGATION ─── */
.site-nav-bar {
  position: fixed;
  top: 0; left: 0; right: 0;
  z-index: 1000;
  padding: 1.5rem 3rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  mix-blend-mode: difference;
}

.nav-logo {
  font-family: var(--font-accent);
  font-size: 1.5rem;
  font-weight: 700;
  color: #fff;
  text-decoration: none;
  letter-spacing: 0.02em;
}

.site-nav {
  display: flex;
  gap: 2.5rem;
  margin-top: 0;
}

.site-nav a {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  color: #fff;
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  transition: opacity 0.3s;
}

.site-nav a:hover { opacity: 0.6; }

/* ─── HERO ─── */
.hero {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
  padding: 2rem;
  background: var(--ink);
  overflow: hidden;
}

.shape {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.45;
  animation: drift 20s ease-in-out infinite;
}

.shape--1 {
  width: 500px; height: 500px;
  background: var(--terracotta);
  top: -10%; right: -5%;
  animation-delay: -3s;
}

.shape--2 {
  width: 400px; height: 400px;
  background: var(--teal);
  bottom: -15%; left: -8%;
  animation-delay: -8s;
  animation-duration: 25s;
}

.shape--3 {
  width: 350px; height: 350px;
  background: var(--plum);
  top: 40%; left: 50%;
  animation-delay: -12s;
  animation-duration: 22s;
}

.shape--4 {
  width: 250px; height: 250px;
  background: var(--gold);
  top: 20%; left: 15%;
  animation-delay: -6s;
  animation-duration: 18s;
}

@keyframes drift {
  0%, 100% { transform: translate(0, 0) scale(1); }
  25% { transform: translate(40px, -30px) scale(1.05); }
  50% { transform: translate(-20px, 40px) scale(0.95); }
  75% { transform: translate(30px, 20px) scale(1.02); }
}

.hero-content {
  position: relative;
  z-index: 2;
  text-align: center;
}

.hero-title {
  font-family: var(--font-display);
  font-weight: 900;
  font-size: clamp(4rem, 11vw, 9rem);
  color: var(--paper);
  line-height: 0.9;
  letter-spacing: -0.02em;
  animation: revealUp 1.2s cubic-bezier(0.16, 1, 0.3, 1) forwards;
  opacity: 0;
}

.hero-tagline {
  font-family: var(--font-display);
  font-style: italic;
  font-weight: 400;
  font-size: clamp(1.1rem, 2.5vw, 1.5rem);
  color: var(--blush);
  margin-top: 1.5rem;
  letter-spacing: 0.05em;
  animation: revealUp 1s cubic-bezier(0.16, 1, 0.3, 1) 0.3s forwards;
  opacity: 0;
}

.hero-desc {
  font-family: var(--font-body);
  font-weight: 300;
  font-size: clamp(0.85rem, 1.5vw, 1rem);
  color: rgba(250,246,241,0.5);
  margin-top: 2rem;
  max-width: 500px;
  margin-left: auto;
  margin-right: auto;
  line-height: 1.7;
  animation: revealUp 1s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;
  opacity: 0;
}

.hero-cta {
  display: inline-block;
  margin-top: 2.5rem;
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--paper);
  border: 1.5px solid rgba(255,255,255,0.2);
  padding: 0.8em 2.5em;
  border-radius: 50px;
  transition: all 0.4s;
  animation: revealUp 1s cubic-bezier(0.16, 1, 0.3, 1) 0.7s forwards;
  opacity: 0;
}

.hero-cta:hover {
  background: rgba(255,255,255,0.08);
  border-color: var(--terracotta);
  color: var(--terracotta);
  transform: translateY(-2px);
}

.scroll-hint {
  position: absolute;
  bottom: 2.5rem;
  left: 50%;
  transform: translateX(-50%);
  z-index: 2;
  animation: revealUp 1s cubic-bezier(0.16, 1, 0.3, 1) 1s forwards, bob 2.5s ease-in-out 2.5s infinite;
  opacity: 0;
}

.scroll-hint svg {
  width: 28px; height: 28px;
  stroke: var(--blush);
  opacity: 0.35;
  fill: none;
  stroke-width: 2;
  stroke-linecap: round;
}

@keyframes bob {
  0%, 100% { transform: translateX(-50%) translateY(0); }
  50% { transform: translateX(-50%) translateY(10px); }
}

@keyframes revealUp {
  from { opacity: 0; transform: translateY(40px); }
  to { opacity: 1; transform: translateY(0); }
}

/* ─── INTRO BAND ─── */
.intro-band {
  padding: 5rem 3rem;
  max-width: var(--max-width);
  margin: 0 auto;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  align-items: center;
}

.intro-quote {
  font-family: var(--font-display);
  font-size: 2rem;
  font-style: italic;
  font-weight: 400;
  line-height: 1.4;
  color: var(--ink);
}

.intro-quote .highlight {
  color: var(--terracotta);
}

.intro-text {
  font-size: 1rem;
  line-height: 1.8;
  color: var(--text-secondary);
}

.intro-text strong {
  font-weight: 500;
  color: var(--ink);
}

/* ─── SECTION COMMON ─── */
.section-label {
  font-family: var(--font-body);
  font-size: 0.72rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.25em;
  color: var(--terracotta);
  margin-bottom: 1rem;
}

/* ─── ARTICLES SECTION ─── */
.articles-section {
  padding: 5rem 3rem;
  max-width: var(--max-width);
  margin: 0 auto;
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
  margin-top: 2rem;
  list-style: none;
}

.article-card {
  border-radius: 16px;
  overflow: hidden;
  transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
  cursor: pointer;
  text-decoration: none;
  color: var(--ink);
  display: block;
}

.article-card:hover { transform: translateY(-5px); }

.article-card-inner {
  padding: 2.5rem;
  min-height: 260px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  position: relative;
}

.article-card:nth-child(4n+1) .article-card-inner { background: linear-gradient(160deg, #f7e8df 0%, #f0d1c0 100%); }
.article-card:nth-child(4n+2) .article-card-inner { background: linear-gradient(160deg, #d9ede5 0%, #a8d5c5 100%); }
.article-card:nth-child(4n+3) .article-card-inner { background: linear-gradient(160deg, #e8dff0 0%, #c9b6de 100%); }
.article-card:nth-child(4n+4) .article-card-inner { background: linear-gradient(160deg, #fce8c8 0%, #f0d49b 100%); }

.article-card .article-number {
  font-family: var(--font-display);
  font-size: 5rem;
  font-weight: 900;
  position: absolute;
  top: 0.8rem; right: 1.2rem;
  opacity: 0.07;
  line-height: 1;
}

.article-card .article-date {
  font-family: var(--font-mono);
  font-size: 0.68rem;
  letter-spacing: 0.08em;
  color: rgba(26,23,20,0.45);
  margin-bottom: 0.6rem;
}

.article-card .article-title {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1.25;
  margin-bottom: 0.6rem;
  color: var(--ink);
}

.article-card .article-summary {
  font-size: 0.9rem;
  line-height: 1.6;
  color: rgba(26,23,20,0.55);
  font-weight: 300;
}

.article-card .article-readmore {
  font-family: var(--font-accent);
  font-size: 1.15rem;
  color: var(--ink);
  margin-top: 0.8rem;
  display: inline-block;
  opacity: 0;
  transform: translateX(-10px);
  transition: all 0.4s;
}

.article-card:hover .article-readmore {
  opacity: 0.7;
  transform: translateX(0);
}

/* Featured first article spans full width */
.article-card.featured {
  grid-column: 1 / -1;
}

.article-card.featured .article-card-inner {
  min-height: 300px;
  background: linear-gradient(160deg, var(--ink) 0%, #2a2320 100%) !important;
}

.article-card.featured .article-date { color: rgba(250,246,241,0.4); }
.article-card.featured .article-title { color: var(--paper); font-size: 2.2rem; max-width: 600px; }
.article-card.featured .article-summary { color: rgba(250,246,241,0.5); max-width: 500px; }
.article-card.featured .article-readmore { color: var(--blush); }
.article-card.featured .article-number { color: var(--paper); }

/* ─── SINGLE ARTICLE ─── */
.single-hero {
  min-height: 60vh;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 6rem 3rem 4rem;
  background: var(--ink);
  position: relative;
  overflow: hidden;
}

.single-hero .shape { opacity: 0.25; }

.single-hero-content {
  position: relative;
  z-index: 2;
  max-width: var(--content-width);
  margin: 0 auto;
  width: 100%;
}

.single-hero .article-date {
  font-family: var(--font-mono);
  font-size: 0.72rem;
  letter-spacing: 0.08em;
  color: rgba(250,246,241,0.4);
  display: block;
  margin-bottom: 1rem;
}

.single-hero .article-title {
  font-family: var(--font-display);
  font-size: clamp(2.2rem, 5vw, 3.5rem);
  font-weight: 900;
  line-height: 1.1;
  color: var(--paper);
}

.article-body-wrap {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 4rem 2rem 6rem;
}

.article-body {
  font-family: var(--font-body);
  font-size: 1.08rem;
  font-weight: 300;
  line-height: 1.85;
  color: #3a3530;
}

.article-body p { margin-bottom: 1.6rem; }

.article-body h2 {
  font-family: var(--font-display);
  font-size: 1.7rem;
  font-weight: 700;
  margin-top: 3rem;
  margin-bottom: 1rem;
  color: var(--ink);
}

.article-body h3 {
  font-family: var(--font-display);
  font-size: 1.3rem;
  font-weight: 700;
  margin-top: 2rem;
  margin-bottom: 0.5rem;
  color: var(--ink);
}

.article-body blockquote {
  margin: 2rem 0;
  padding: 1.5rem 0 1.5rem 2rem;
  border-left: 3px solid var(--terracotta);
  font-family: var(--font-display);
  font-style: italic;
  font-size: 1.2rem;
  line-height: 1.6;
  color: var(--text-secondary);
}

.article-body a {
  color: var(--terracotta);
  text-decoration: underline;
  text-underline-offset: 3px;
  transition: color 0.3s;
}

.article-body a:hover { color: var(--terracotta-dark); }

.article-body img {
  max-width: 100%;
  height: auto;
  margin: 2rem 0;
  border-radius: 12px;
}

.article-body ul, .article-body ol { margin-bottom: 1.5rem; padding-left: 1.5rem; }
.article-body li { margin-bottom: 0.5rem; }

.article-body code {
  font-family: var(--font-mono);
  font-size: 0.85em;
  background: rgba(26,23,20,0.05);
  padding: 0.15em 0.4em;
  border-radius: 4px;
}

.article-body pre {
  background: var(--ink);
  color: var(--paper);
  padding: 2rem;
  overflow-x: auto;
  margin: 2rem 0;
  border-radius: 12px;
}

.article-body pre code { background: none; padding: 0; color: inherit; }

.article-body hr {
  border: none;
  text-align: center;
  margin: 3rem 0;
}

.article-body hr::after {
  content: "· · ·";
  color: var(--rule);
  letter-spacing: 0.5em;
}

.article-end {
  max-width: var(--content-width);
  margin: 0 auto;
  padding: 0 2rem 5rem;
  border-top: 1px solid var(--rule);
  padding-top: 2rem;
}

.back-link {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  color: var(--text-secondary);
  transition: color 0.3s;
}

.back-link:hover { color: var(--terracotta); }

/* ─── ABOUT PAGE ─── */
.about-body {
  font-family: var(--font-body);
  font-size: 1.08rem;
  font-weight: 300;
  line-height: 1.85;
  color: #3a3530;
}

.about-body p { margin-bottom: 1.6rem; }
.about-body strong { font-weight: 500; color: var(--ink); }

.about-body h2 {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 700;
  margin-top: 3rem;
  margin-bottom: 1rem;
  color: var(--ink);
}

/* ─── FOOTER ─── */
.site-footer {
  padding: 3rem;
  text-align: center;
  border-top: 1px solid rgba(26,23,20,0.06);
}

.footer-brand {
  font-family: var(--font-accent);
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--ink);
  display: block;
  margin-bottom: 0.5rem;
}

.footer-text {
  font-size: 0.78rem;
  color: rgba(26,23,20,0.35);
  font-weight: 300;
  letter-spacing: 0.05em;
}

.footer-links {
  margin-top: 1rem;
  display: flex;
  justify-content: center;
  gap: 2rem;
}

.footer-links a {
  font-family: var(--font-body);
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  text-decoration: none;
  color: rgba(26,23,20,0.4);
  transition: color 0.3s;
}

.footer-links a:hover { color: var(--terracotta); }

/* ─── SCROLL ANIMATIONS ─── */
.reveal {
  opacity: 0;
  transform: translateY(30px);
  transition: opacity 0.8s cubic-bezier(0.16, 1, 0.3, 1), transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
}

.reveal.visible {
  opacity: 1;
  transform: translateY(0);
}

/* ─── RESPONSIVE ─── */
@media (max-width: 900px) {
  .site-nav-bar { padding: 1rem 1.5rem; }
  .site-nav { gap: 1.5rem; }
  .site-nav a { font-size: 0.72rem; }
  .intro-band { grid-template-columns: 1fr; gap: 2rem; padding: 3rem 1.5rem; }
  .articles-section { padding: 3rem 1.5rem; }
  .articles-grid { grid-template-columns: 1fr; }
  .article-card.featured .article-title { font-size: 1.8rem; }
  .single-hero { padding: 5rem 1.5rem 3rem; min-height: 50vh; }
  .article-body-wrap { padding: 3rem 1.5rem 4rem; }
}

@media (max-width: 600px) {
  .hero-title { font-size: clamp(3rem, 14vw, 5rem); }
  .site-nav { display: none; }
  .intro-quote { font-size: 1.5rem; }
  .article-card .article-title { font-size: 1.3rem; }
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

  <nav class="site-nav-bar">
    <a href="/" class="nav-logo">Pinterlude</a>
    <div class="site-nav">
      <a href="/">Journal</a>
      <a href="/about/">About</a>
    </div>
  </nav>

  {{ block "main" . }}{{ end }}

  <footer class="site-footer">
    <span class="footer-brand">Pinterlude</span>
    <p class="footer-text">&copy; 2026 — Marc &amp; Linda</p>
    <div class="footer-links">
      <a href="/">Journal</a>
      <a href="/about/">About</a>
    </div>
  </footer>

  <script>
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

# --- Home Page ---
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
            <time class="article-date">{{ .Date.Format "January 2, 2006" }}</time>
            <h2 class="article-title">{{ .Title }}</h2>
            {{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}
            <span class="article-readmore">Read more →</span>
          </div>
        </a>
      </li>
      {{ end }}
    </ul>
  </section>

{{ end }}
HTMLEOF

# --- List Template ---
cat > layouts/_default/list.html << 'HTMLEOF'
{{ define "main" }}

  <section class="single-hero">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="single-hero-content">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:3rem;font-weight:900;color:var(--paper);">{{ .Title }}</h1>
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
              <time class="article-date">{{ .Date.Format "January 2, 2006" }}</time>
              <h2 class="article-title">{{ .Title }}</h2>
              {{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}
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

# --- Single Article ---
cat > layouts/_default/single.html << 'HTMLEOF'
{{ define "main" }}

  <section class="single-hero">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="single-hero-content">
      <time class="article-date">{{ .Date.Format "January 2, 2006" }}</time>
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

echo "✓ Design D (Audace) installed!"
echo "Run 'hugo server' to preview."
