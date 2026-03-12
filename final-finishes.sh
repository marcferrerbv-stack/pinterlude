#!/bin/bash
# Pinterlude — Final Finishes
# Hamburger mobile menu, social page, visual reading time bar

echo "═══════════════════════════════════════"
echo "  PINTERLUDE — Final Finishes"
echo "═══════════════════════════════════════"

# ─── 1. NAV WITH HAMBURGER ───
echo "→ Upgrading nav with hamburger menu..."
cat > layouts/partials/nav.html << 'HTMLEOF'
<nav class="site-nav-bar">
  <a href="/" class="nav-logo">Pinterlude</a>
  <div class="site-nav" id="siteNav">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <a href="/map/">Map</a>
    <a href="/archives/">Archives</a>
    <a href="/contact/">Contact</a>
    <a href="/search/" class="nav-search" title="Search">&#x2315;</a>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle dark mode">&#x263E;</button>
  </div>
  <button class="hamburger" id="hamburger" onclick="toggleMenu()" aria-label="Menu">
    <span></span>
    <span></span>
    <span></span>
  </button>
</nav>

<!-- Mobile overlay menu -->
<div class="mobile-menu" id="mobileMenu">
  <div class="mobile-menu-inner">
    <a href="/" onclick="closeMenu()">Journal</a>
    <a href="/about/" onclick="closeMenu()">About</a>
    <a href="/pillars/" onclick="closeMenu()">Pillars</a>
    <a href="/map/" onclick="closeMenu()">Map</a>
    <a href="/archives/" onclick="closeMenu()">Archives</a>
    <a href="/contact/" onclick="closeMenu()">Contact</a>
    <a href="/search/" onclick="closeMenu()">Search</a>
    <div class="mobile-menu-footer">
      <a href="/feed.xml">RSS</a>
      <button class="theme-toggle-mobile" onclick="toggleTheme()">&#x263E; Toggle theme</button>
    </div>
  </div>
</div>

<script>
function toggleMenu() {
  const menu = document.getElementById('mobileMenu');
  const btn = document.getElementById('hamburger');
  menu.classList.toggle('open');
  btn.classList.toggle('open');
  document.body.classList.toggle('menu-open');
}
function closeMenu() {
  document.getElementById('mobileMenu').classList.remove('open');
  document.getElementById('hamburger').classList.remove('open');
  document.body.classList.remove('menu-open');
}
</script>
HTMLEOF

# ─── 2. SOCIAL / FOLLOW PAGE ───
echo "→ Creating social page..."
mkdir -p content/follow
cat > content/follow/_index.md << 'EOF'
---
title: "Follow"
description: "All the places you can find Pinterlude"
layout: "follow"
---
EOF

mkdir -p layouts/follow
cat > layouts/follow/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:45vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:clamp(2.5rem,5vw,3.5rem);font-weight:900;color:var(--paper);">Follow the journey</h1>
      <p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1.05rem;font-family:var(--font-display);font-style:italic;">Find us wherever you prefer to read, watch, or scroll</p>
    </div>
  </section>

  <div class="follow-page">

    <div class="follow-grid">
      <a href="https://pinterlude.substack.com" target="_blank" rel="noopener" class="follow-card follow-card--substack reveal">
        <div class="follow-card-icon">✉</div>
        <h3>Newsletter</h3>
        <p class="follow-card-platform">Substack</p>
        <p class="follow-card-desc">Long essays and honest dispatches, delivered to your inbox. The fullest version of what we write.</p>
        <span class="follow-card-cta">Subscribe →</span>
      </a>

      <a href="#" target="_blank" rel="noopener" class="follow-card follow-card--youtube reveal" style="transition-delay:0.1s;">
        <div class="follow-card-icon">▶</div>
        <h3>Video Essays</h3>
        <p class="follow-card-platform">YouTube</p>
        <p class="follow-card-desc">12-20 minute filmed essays. Not vlogs — think visual storytelling with substance.</p>
        <span class="follow-card-cta">Watch →</span>
      </a>

      <a href="#" target="_blank" rel="noopener" class="follow-card follow-card--instagram reveal" style="transition-delay:0.2s;">
        <div class="follow-card-icon">◻</div>
        <h3>Photos & Stories</h3>
        <p class="follow-card-platform">Instagram</p>
        <p class="follow-card-desc">Long captions, intentional photos, teasers for new articles. The visual side of the journal.</p>
        <span class="follow-card-cta">Follow →</span>
      </a>

      <a href="/feed.xml" class="follow-card follow-card--rss reveal" style="transition-delay:0.3s;">
        <div class="follow-card-icon">◉</div>
        <h3>RSS Feed</h3>
        <p class="follow-card-platform">Any reader</p>
        <p class="follow-card-desc">Old school, no algorithm. Get every article in your favorite RSS reader.</p>
        <span class="follow-card-cta">Subscribe →</span>
      </a>
    </div>

    <div class="follow-contact reveal">
      <h3>Direct contact</h3>
      <p>For translation projects, press inquiries, trail recommendations, or just to say hello:</p>
      <a href="mailto:hello@pinterlude.com" class="follow-email">hello@pinterlude.com</a>
    </div>

  </div>

{{ end }}
HTMLEOF

# ─── 3. UPDATE SINGLE ARTICLE WITH VISUAL READING BAR ───
echo "→ Adding visual reading time bar to articles..."
# We add a visual bar below the date line in single.html
sed -i 's|<h1 class="article-title">{{ .Title }}</h1>|<h1 class="article-title">{{ .Title }}</h1>\
      <div class="reading-time-visual">\
        <div class="reading-time-bar">\
          <div class="reading-time-fill" style="width: {{ mul .ReadingTime 10 }}%;max-width:100%;"></div>\
        </div>\
        <span class="reading-time-label">{{ .ReadingTime }} min read</span>\
      </div>|' layouts/_default/single.html

# Also add to article cards on homepage
sed -i 's|<span class="article-readmore">Read more|{{ if .ReadingTime }}<div class="reading-time-mini"><div class="reading-time-mini-bar" style="width:{{ mul .ReadingTime 10 }}%;max-width:100%;"></div><span>{{ .ReadingTime }} min</span></div>{{ end }}\
            <span class="article-readmore">Read more|' layouts/index.html

# ─── 4. ADD NAV LINK FOR FOLLOW ───
echo "→ Updating footer with Follow link..."
sed -i 's|<a href="/contact/">Contact</a>|<a href="/contact/">Contact</a>\n    <a href="/follow/">Follow</a>|' layouts/partials/footer.html

# ─── 5. ALL NEW CSS ───
echo "→ Adding final styles..."
cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   FINAL FINISHES
   ═══════════════════════════════════════ */

/* ─── HAMBURGER BUTTON ─── */
.hamburger {
  display: none;
  flex-direction: column;
  justify-content: center;
  gap: 5px;
  width: 36px;
  height: 36px;
  background: none;
  border: none;
  cursor: pointer;
  z-index: 1002;
  padding: 4px;
}

.hamburger span {
  display: block;
  width: 100%;
  height: 2px;
  background: #FAF6F1;
  border-radius: 2px;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.site-nav-bar.scrolled .hamburger span { background: var(--ink); }

.hamburger.open span:nth-child(1) { transform: rotate(45deg) translate(5px, 5px); }
.hamburger.open span:nth-child(2) { opacity: 0; }
.hamburger.open span:nth-child(3) { transform: rotate(-45deg) translate(5px, -5px); }

/* ─── MOBILE MENU OVERLAY ─── */
.mobile-menu {
  position: fixed;
  inset: 0;
  background: var(--ink);
  z-index: 1001;
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

[data-theme="dark"] .mobile-menu { background: #0D0C0A; }

.mobile-menu.open {
  opacity: 1;
  pointer-events: all;
}

body.menu-open { overflow: hidden; }

.mobile-menu-inner {
  text-align: center;
  display: flex;
  flex-direction: column;
  gap: 0;
}

.mobile-menu-inner a {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 700;
  color: #FAF6F1;
  text-decoration: none;
  padding: 0.6em 0;
  display: block;
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.4s, transform 0.4s, color 0.3s;
}

.mobile-menu.open .mobile-menu-inner a {
  opacity: 1;
  transform: translateY(0);
}

/* Stagger the animations */
.mobile-menu.open .mobile-menu-inner a:nth-child(1) { transition-delay: 0.05s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(2) { transition-delay: 0.1s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(3) { transition-delay: 0.15s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(4) { transition-delay: 0.2s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(5) { transition-delay: 0.25s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(6) { transition-delay: 0.3s; }
.mobile-menu.open .mobile-menu-inner a:nth-child(7) { transition-delay: 0.35s; }

.mobile-menu-inner a:hover { color: var(--terracotta); }

.mobile-menu-footer {
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid rgba(250,246,241,0.1);
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
}

.mobile-menu-footer a {
  font-family: var(--font-mono) !important;
  font-size: 0.8rem !important;
  font-weight: 400 !important;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(250,246,241,0.4) !important;
}

.theme-toggle-mobile {
  font-family: var(--font-mono);
  font-size: 0.8rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  background: none;
  border: 1px solid rgba(250,246,241,0.15);
  color: rgba(250,246,241,0.5);
  padding: 0.5em 1.5em;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.3s;
}

.theme-toggle-mobile:hover {
  border-color: var(--terracotta);
  color: var(--terracotta);
}

/* Show hamburger on mobile */
@media (max-width: 900px) {
  .site-nav { display: none !important; }
  .hamburger { display: flex; }
}

/* ─── FOLLOW / SOCIAL PAGE ─── */
.follow-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.follow-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  margin-bottom: 3rem;
}

.follow-card {
  padding: 2rem;
  border-radius: 16px;
  text-decoration: none;
  color: inherit;
  transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}

.follow-card:hover { transform: translateY(-5px); }

.follow-card--substack { background: linear-gradient(160deg, #FFF3E8, #FFE5CC); }
.follow-card--youtube { background: linear-gradient(160deg, #FFE8E8, #FFCCCC); }
.follow-card--instagram { background: linear-gradient(160deg, #F0E8FF, #E0CCFF); }
.follow-card--rss { background: linear-gradient(160deg, #E8F4F0, #CCE8E0); }

[data-theme="dark"] .follow-card--substack { background: linear-gradient(160deg, #2A2018, #1E1810); }
[data-theme="dark"] .follow-card--youtube { background: linear-gradient(160deg, #2A1818, #1E1010); }
[data-theme="dark"] .follow-card--instagram { background: linear-gradient(160deg, #20182A, #18101E); }
[data-theme="dark"] .follow-card--rss { background: linear-gradient(160deg, #182A22, #101E18); }

.follow-card-icon {
  font-size: 2rem;
  margin-bottom: 1rem;
  opacity: 0.7;
}

.follow-card h3 {
  font-family: var(--font-display);
  font-size: 1.4rem;
  font-weight: 700;
  margin-bottom: 0.2rem;
}

.follow-card-platform {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-bottom: 0.8rem;
}

.follow-card-desc {
  font-size: 0.9rem;
  font-weight: 300;
  line-height: 1.6;
  color: var(--text-secondary);
  flex: 1;
}

.follow-card-cta {
  font-family: var(--font-accent);
  font-size: 1.1rem;
  margin-top: 1rem;
  opacity: 0;
  transform: translateX(-10px);
  transition: all 0.4s;
}

.follow-card:hover .follow-card-cta {
  opacity: 0.7;
  transform: translateX(0);
}

.follow-contact {
  text-align: center;
  padding: 2.5rem;
  border-radius: 16px;
  background: rgba(26,23,20,0.03);
}

[data-theme="dark"] .follow-contact { background: rgba(250,246,241,0.03); }

.follow-contact h3 {
  font-family: var(--font-display);
  font-size: 1.3rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.follow-contact p {
  font-size: 0.95rem;
  font-weight: 300;
  color: var(--text-secondary);
  margin-bottom: 1rem;
}

.follow-email {
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--terracotta);
  text-decoration: none;
  transition: color 0.3s;
}

.follow-email:hover { color: var(--terracotta-dark); }

/* ─── VISUAL READING TIME BAR (single article hero) ─── */
.reading-time-visual {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  margin-top: 1.5rem;
}

.reading-time-bar {
  width: 120px;
  height: 3px;
  background: rgba(250,246,241,0.15);
  border-radius: 3px;
  overflow: hidden;
}

.reading-time-fill {
  height: 100%;
  background: var(--terracotta);
  border-radius: 3px;
  transition: width 0.8s cubic-bezier(0.16, 1, 0.3, 1);
}

.reading-time-label {
  font-family: var(--font-mono);
  font-size: 0.68rem;
  letter-spacing: 0.05em;
  color: rgba(250,246,241,0.4);
}

/* ─── MINI READING TIME BAR (article cards) ─── */
.reading-time-mini {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-top: 0.6rem;
  margin-bottom: 0.2rem;
}

.reading-time-mini-bar {
  width: 60px;
  height: 2px;
  background: rgba(26,23,20,0.08);
  border-radius: 2px;
  position: relative;
  overflow: hidden;
}

.reading-time-mini-bar::after {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  width: 100%;
  background: var(--terracotta);
  border-radius: 2px;
}

.reading-time-mini span {
  font-family: var(--font-mono);
  font-size: 0.6rem;
  color: var(--text-secondary);
  letter-spacing: 0.05em;
}

.article-card.featured .reading-time-mini-bar { background: rgba(250,246,241,0.1); }
.article-card.featured .reading-time-mini span { color: rgba(250,246,241,0.35); }

[data-theme="dark"] .reading-time-mini-bar { background: rgba(250,246,241,0.06); }

/* ─── RESPONSIVE ─── */
@media (max-width: 640px) {
  .follow-grid { grid-template-columns: 1fr; }
  .mobile-menu-inner a { font-size: 1.6rem; padding: 0.5em 0; }
}
CSSEOF

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ Final Finishes complete!"
echo "═══════════════════════════════════════"
echo ""
echo "New features:"
echo "  ☰   Hamburger mobile menu with animated overlay"
echo "  📱  Follow page: /follow/"
echo "  📊  Visual reading time bars on cards & articles"
echo ""
echo "Run 'hugo server --buildDrafts' to preview."
echo "Test mobile: resize browser to < 900px width."
