#!/bin/bash
# Pinterlude — Final Enrichment
# Contact, Archives, World Map, Giscus comments, Parallax, Typewriter

echo "═══════════════════════════════════════"
echo "  PINTERLUDE — Final Enrichment"
echo "═══════════════════════════════════════"

# ─── 1. CONTACT PAGE ───
echo "→ Creating contact page with Netlify form..."
mkdir -p content/contact
cat > content/contact/_index.md << 'EOF'
---
title: "Contact"
description: "Get in touch with Marc & Linda"
layout: "contact"
---
EOF

mkdir -p layouts/contact
cat > layouts/contact/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:45vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:clamp(2.5rem,5vw,3.5rem);font-weight:900;color:var(--paper);">Let's talk</h1>
      <p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1.05rem;font-family:var(--font-display);font-style:italic;">A text to translate, a trail to recommend, an idea to share?</p>
    </div>
  </section>

  <div class="contact-page">
    <div class="contact-grid">
      <div class="contact-info reveal">
        <h2>Where to find us</h2>
        <div class="contact-item">
          <span class="contact-item-icon">✉</span>
          <div>
            <strong>Email</strong>
            <a href="mailto:hello@pinterlude.com">hello@pinterlude.com</a>
          </div>
        </div>
        <div class="contact-item">
          <span class="contact-item-icon">📍</span>
          <div>
            <strong>Currently based in</strong>
            <span>Colorado, USA</span>
          </div>
        </div>
        <div class="contact-item">
          <span class="contact-item-icon">✦</span>
          <div>
            <strong>Newsletter</strong>
            <a href="https://pinterlude.substack.com" target="_blank">pinterlude.substack.com</a>
          </div>
        </div>
      </div>

      <form name="contact" method="POST" data-netlify="true" netlify-honeypot="bot-field" class="contact-form reveal" style="transition-delay:0.15s;">
        <input type="hidden" name="form-name" value="contact">
        <p class="hidden" style="display:none;">
          <label>Don't fill this out: <input name="bot-field"></label>
        </p>
        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" required placeholder="Your name">
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required placeholder="your@email.com">
        </div>
        <div class="form-group">
          <label for="subject">Subject</label>
          <select id="subject" name="subject">
            <option value="general">General inquiry</option>
            <option value="translation">Translation project</option>
            <option value="collaboration">Collaboration</option>
            <option value="press">Press / Media</option>
            <option value="other">Other</option>
          </select>
        </div>
        <div class="form-group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="6" required placeholder="Your message..."></textarea>
        </div>
        <button type="submit" class="form-submit">Send message</button>
      </form>
    </div>
  </div>

{{ end }}
HTMLEOF

# ─── 2. ARCHIVES PAGE ───
echo "→ Creating archives page..."
mkdir -p content/archives
cat > content/archives/_index.md << 'EOF'
---
title: "Archives"
description: "All articles, organized by year"
layout: "archives"
---
EOF

mkdir -p layouts/archives
cat > layouts/archives/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:40vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:3rem;font-weight:900;color:var(--paper);">Archives</h1>
      <p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1rem;">Everything we've written, organized by year</p>
    </div>
  </section>

  <div class="archives-page">
    {{ $articles := where .Site.RegularPages "Section" "blog" }}
    {{ $byYear := $articles.GroupByDate "2006" }}
    {{ range $byYear }}
    <div class="archive-year reveal">
      <h2 class="archive-year-title">{{ .Key }}</h2>
      <span class="archive-year-count">{{ len .Pages }} article{{ if gt (len .Pages) 1 }}s{{ end }}</span>
      <ul class="archive-list">
        {{ range .Pages.ByDate.Reverse }}
        <li class="archive-item">
          <a href="{{ .Permalink }}">
            <time>{{ .Date.Format "Jan 2" }}</time>
            <div class="archive-item-main">
              <span class="archive-item-title">{{ .Title }}</span>
              <div class="archive-item-meta">
                {{ with .Params.author }}<span>{{ . }}</span>{{ end }}
                {{ with .Params.pillar }}
                <span class="article-pillar article-pillar--{{ . }}" style="font-size:0.55rem;padding:0.15em 0.5em;">
                  {{ if eq . "choice" }}The Choice
                  {{ else if eq . "gaze" }}The Gaze
                  {{ else if eq . "scenes" }}Behind the Scenes
                  {{ else if eq . "motion" }}Body in Motion
                  {{ else if eq . "words" }}Linda's Words
                  {{ end }}
                </span>
                {{ end }}
                {{ if eq .Params.language "fr" }}<span class="article-lang" style="font-size:0.5rem;">FR</span>{{ end }}
              </div>
            </div>
            <span class="archive-item-time">{{ .ReadingTime }} min</span>
          </a>
        </li>
        {{ end }}
      </ul>
    </div>
    {{ end }}
  </div>

{{ end }}
HTMLEOF

# ─── 3. WORLD MAP PAGE ───
echo "→ Creating world map page..."
mkdir -p content/map
cat > content/map/_index.md << 'EOF'
---
title: "World Map"
description: "Where our stories come from"
layout: "map"
---
EOF

mkdir -p layouts/map
cat > layouts/map/list.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <section class="single-hero" style="min-height:40vh;">
    <div class="shape shape--1"></div>
    <div class="shape shape--2"></div>
    <div class="shape shape--3"></div>
    <div class="single-hero-content" style="text-align:center;">
      <h1 class="article-title" style="font-family:var(--font-display);font-size:3rem;font-weight:900;color:var(--paper);">Where we write</h1>
      <p style="color:rgba(250,246,241,0.5);margin-top:1rem;font-size:1rem;">Every article is written somewhere. This is the map.</p>
    </div>
  </section>

  <div class="map-page">
    <div id="worldMap" class="world-map"></div>

    <div class="map-locations">
      {{ $articles := where .Site.RegularPages "Section" "blog" }}
      {{ $locations := slice }}
      {{ range $articles }}
        {{ with .Params.location }}
          {{ $locations = $locations | append . }}
        {{ end }}
      {{ end }}
      {{ $uniqueLocations := uniq $locations }}

      {{ range $loc := $uniqueLocations }}
      {{ $locArticles := where $articles "Params.location" $loc }}
      <div class="map-location reveal">
        <h3 class="map-location-name">{{ $loc }}</h3>
        <span class="map-location-count">{{ len $locArticles }} article{{ if gt (len $locArticles) 1 }}s{{ end }}</span>
        <ul class="map-location-articles">
          {{ range $locArticles }}
          <li><a href="{{ .Permalink }}">{{ .Title }}</a></li>
          {{ end }}
        </ul>
      </div>
      {{ end }}
    </div>
  </div>

  <!-- Simple interactive SVG world map -->
  <script>
    // Location data from Hugo
    const locations = [
      {{ $articles := where .Site.RegularPages "Section" "blog" }}
      {{ range $articles }}
      {{ with .Params.location }}
      { name: {{ . | jsonify }}, article: {{ $.Title | jsonify }}, url: {{ $.Permalink | jsonify }} },
      {{ end }}
      {{ end }}
    ];
  </script>

{{ end }}
HTMLEOF

# ─── 4. UPDATE NAV ───
echo "→ Updating nav with new pages..."
cat > layouts/partials/nav.html << 'HTMLEOF'
<nav class="site-nav-bar">
  <a href="/" class="nav-logo">Pinterlude</a>
  <div class="site-nav">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <a href="/map/">Map</a>
    <a href="/archives/">Archives</a>
    <a href="/contact/">Contact</a>
    <a href="/search/" class="nav-search" title="Search">&#x2315;</a>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle dark mode">&#x263E;</button>
  </div>
</nav>
HTMLEOF

# ─── 5. UPDATE FOOTER ───
echo "→ Updating footer..."
cat > layouts/partials/footer.html << 'HTMLEOF'
<footer class="site-footer">
  <div class="footer-stats reveal">
    {{ $articles := where .Site.RegularPages "Section" "blog" }}
    {{ $locations := slice }}
    {{ range $articles }}
      {{ with .Params.location }}{{ $locations = $locations | append . }}{{ end }}
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
      <span class="stat-number">&infin;</span>
      <span class="stat-label">roads ahead</span>
    </div>
  </div>
  <span class="footer-brand">Pinterlude</span>
  <p class="footer-text">&copy; 2026 — Marc &amp; Linda</p>
  <div class="footer-links">
    <a href="/">Journal</a>
    <a href="/about/">About</a>
    <a href="/pillars/">Pillars</a>
    <a href="/map/">Map</a>
    <a href="/archives/">Archives</a>
    <a href="/contact/">Contact</a>
    <a href="/search/">Search</a>
    <a href="/feed.xml">RSS</a>
  </div>
</footer>
HTMLEOF

# ─── 6. UPDATE HOME WITH PARALLAX + TYPEWRITER ───
echo "→ Adding parallax and typewriter to hero..."
cat > layouts/index.html << 'HTMLEOF'
{{ define "main" }}

  {{ partial "nav.html" . }}

  <!-- HERO with parallax -->
  <section class="hero" id="heroSection">
    <div class="shape shape--1" data-speed="0.3"></div>
    <div class="shape shape--2" data-speed="0.5"></div>
    <div class="shape shape--3" data-speed="0.2"></div>
    <div class="shape shape--4" data-speed="0.4"></div>
    <div class="hero-content">
      <h1 class="hero-title" id="heroTitle"></h1>
      <p class="hero-tagline" id="heroTagline" style="opacity:0;">The interlude between two lives</p>
      <p class="hero-desc" id="heroDesc" style="opacity:0;">A couple of Swiss intellectuals left comfort behind to see the world before it's too late. This is not a travel blog. It's the journal of a radical life choice.</p>
      <a href="#articles" class="hero-cta" id="heroCta" style="opacity:0;">Read the journal</a>
    </div>
    <div class="scroll-hint" id="heroScroll" style="opacity:0;">
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
      <span class="newsletter-icon">&#x2709;</span>
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
                {{ if eq . "choice" }}The Choice{{ else if eq . "gaze" }}The Gaze{{ else if eq . "scenes" }}Behind the Scenes{{ else if eq . "motion" }}Body in Motion{{ else if eq . "words" }}Linda's Words{{ end }}
              </span>
              {{ end }}
              {{ if eq .Params.language "fr" }}<span class="article-lang">FR</span>{{ end }}
            </div>
            <time class="article-date">{{ .Date.Format "January 2, 2006" }}{{ with .Params.author }} &middot; {{ . }}{{ end }}{{ with .Params.location }} &middot; {{ . }}{{ end }} &middot; {{ .ReadingTime }} min read</time>
            <h2 class="article-title">{{ .Title }}</h2>
            {{ with .Params.description }}<p class="article-summary">{{ . }}</p>{{ else }}{{ if .Summary }}<p class="article-summary">{{ .Summary | plainify | truncate 180 }}</p>{{ end }}{{ end }}
            {{ with .Params.tags }}
            <div class="article-card-footer"><div class="article-tags">
              {{ range first 3 . }}<span class="article-tag">{{ . }}</span>{{ end }}
            </div></div>
            {{ end }}
            <span class="article-readmore">Read more &#x2192;</span>
          </div>
        </a>
      </li>
      {{ end }}
    </ul>
  </section>

  <script>
    // Typewriter effect
    const title = 'Pinterlude';
    const el = document.getElementById('heroTitle');
    let i = 0;
    function typeChar() {
      if (i < title.length) {
        el.textContent += title[i];
        i++;
        setTimeout(typeChar, 120 + Math.random() * 80);
      } else {
        // Show rest of hero
        setTimeout(() => {
          document.getElementById('heroTagline').style.opacity = '1';
          document.getElementById('heroTagline').style.transform = 'translateY(0)';
          document.getElementById('heroTagline').style.transition = 'all 0.8s cubic-bezier(0.16, 1, 0.3, 1)';
        }, 200);
        setTimeout(() => {
          document.getElementById('heroDesc').style.opacity = '1';
          document.getElementById('heroDesc').style.transform = 'translateY(0)';
          document.getElementById('heroDesc').style.transition = 'all 0.8s cubic-bezier(0.16, 1, 0.3, 1)';
        }, 500);
        setTimeout(() => {
          document.getElementById('heroCta').style.opacity = '1';
          document.getElementById('heroCta').style.transform = 'translateY(0)';
          document.getElementById('heroCta').style.transition = 'all 0.8s cubic-bezier(0.16, 1, 0.3, 1)';
        }, 800);
        setTimeout(() => {
          document.getElementById('heroScroll').style.opacity = '1';
          document.getElementById('heroScroll').style.transition = 'opacity 1s';
        }, 1200);
      }
    }
    // Start after page loads
    setTimeout(typeChar, 500);

    // Parallax on hero shapes
    window.addEventListener('scroll', () => {
      const scrolled = window.scrollY;
      document.querySelectorAll('.hero .shape[data-speed]').forEach(shape => {
        const speed = parseFloat(shape.getAttribute('data-speed'));
        shape.style.transform = 'translateY(' + (scrolled * speed) + 'px)';
      });
    });
  </script>

{{ end }}
HTMLEOF

# ─── 7. GISCUS COMMENTS PARTIAL ───
echo "→ Creating comments partial (Giscus)..."
cat > layouts/partials/comments.html << 'HTMLEOF'
<!-- Giscus Comments — Replace data-repo and data-repo-id with your values -->
<!-- To set up: go to https://giscus.app, enable Discussions on your GitHub repo, and get your config -->
<div class="comments-section">
  <p class="comments-label">Comments</p>
  <p class="comments-setup-note">
    <em>Comments are powered by GitHub Discussions. 
    <a href="https://giscus.app" target="_blank">Set up Giscus</a> to enable them.</em>
  </p>
  <!--
  Uncomment this block after setting up Giscus:
  
  <script src="https://giscus.app/client.js"
    data-repo="marcferrerbv-stack/pinterlude"
    data-repo-id="YOUR_REPO_ID"
    data-category="Articles"
    data-category-id="YOUR_CATEGORY_ID"
    data-mapping="pathname"
    data-strict="0"
    data-reactions-enabled="1"
    data-emit-metadata="0"
    data-input-position="top"
    data-theme="preferred_color_scheme"
    data-lang="en"
    crossorigin="anonymous"
    async>
  </script>
  -->
</div>
HTMLEOF

# ─── 8. ADD COMMENTS TO SINGLE TEMPLATE ───
echo "→ Adding comments to single article..."
# Insert comments partial before article-end in single.html
sed -i 's|<div class="article-end">|{{ partial "comments.html" . }}\n\n  <div class="article-end">|' layouts/_default/single.html

# ─── 9. ALL NEW CSS ───
echo "→ Adding final styles..."
cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   FINAL ENRICHMENT STYLES
   ═══════════════════════════════════════ */

/* ─── TYPEWRITER CURSOR ─── */
#heroTitle::after {
  content: "|";
  animation: blink 0.8s step-end infinite;
  color: var(--terracotta);
}

@keyframes blink {
  50% { opacity: 0; }
}

/* ─── CONTACT PAGE ─── */
.contact-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.contact-grid {
  display: grid;
  grid-template-columns: 1fr 1.3fr;
  gap: 4rem;
  align-items: start;
}

.contact-info h2 {
  font-family: var(--font-display);
  font-size: 1.4rem;
  font-weight: 700;
  margin-bottom: 2rem;
}

.contact-item {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
  margin-bottom: 1.5rem;
}

.contact-item-icon {
  font-size: 1.3rem;
  flex-shrink: 0;
  margin-top: 0.1rem;
}

.contact-item strong {
  font-family: var(--font-body);
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-secondary);
  display: block;
  margin-bottom: 0.2rem;
}

.contact-item a, .contact-item span {
  font-family: var(--font-body);
  font-size: 1rem;
  color: var(--ink);
  text-decoration: none;
}

.contact-item a:hover { color: var(--terracotta); }

.contact-form {
  display: flex;
  flex-direction: column;
  gap: 1.2rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.form-group label {
  font-family: var(--font-mono);
  font-size: 0.68rem;
  font-weight: 500;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--text-secondary);
}

.form-group input,
.form-group select,
.form-group textarea {
  font-family: var(--font-body);
  font-size: 1rem;
  font-weight: 300;
  padding: 0.8rem 1rem;
  border: 1.5px solid var(--rule);
  border-radius: 8px;
  background: transparent;
  color: var(--ink);
  transition: border-color 0.3s;
  outline: none;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
  border-color: var(--terracotta);
}

[data-theme="dark"] .form-group input,
[data-theme="dark"] .form-group select,
[data-theme="dark"] .form-group textarea {
  border-color: #2A2725;
  color: #FAF6F1;
}

[data-theme="dark"] .form-group input:focus,
[data-theme="dark"] .form-group select:focus,
[data-theme="dark"] .form-group textarea:focus {
  border-color: var(--terracotta);
}

.form-group textarea { resize: vertical; min-height: 140px; }

.form-submit {
  font-family: var(--font-body);
  font-size: 0.85rem;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  padding: 0.9em 2em;
  border: none;
  border-radius: 50px;
  background: var(--terracotta);
  color: #fff;
  cursor: pointer;
  transition: all 0.3s;
  align-self: flex-start;
}

.form-submit:hover {
  background: var(--terracotta-dark);
  transform: translateY(-2px);
}

/* ─── ARCHIVES PAGE ─── */
.archives-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.archive-year {
  margin-bottom: 3rem;
}

.archive-year-title {
  font-family: var(--font-display);
  font-size: 3rem;
  font-weight: 900;
  color: var(--terracotta);
  line-height: 1;
  display: inline-block;
  margin-right: 1rem;
}

.archive-year-count {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-secondary);
  vertical-align: super;
}

.archive-list {
  list-style: none;
  margin-top: 1rem;
}

.archive-item { border-bottom: 1px solid rgba(26,23,20,0.06); }
[data-theme="dark"] .archive-item { border-bottom-color: #2A2725; }

.archive-item a {
  display: flex;
  align-items: center;
  gap: 1.2rem;
  padding: 1rem 0;
  text-decoration: none;
  color: inherit;
  transition: all 0.3s;
}

.archive-item a:hover { padding-left: 0.5rem; }

.archive-item time {
  font-family: var(--font-mono);
  font-size: 0.72rem;
  color: var(--text-secondary);
  min-width: 55px;
  flex-shrink: 0;
}

.archive-item-main { flex: 1; }

.archive-item-title {
  font-family: var(--font-display);
  font-size: 1.05rem;
  font-weight: 700;
  display: block;
  margin-bottom: 0.2rem;
}

.archive-item-meta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.archive-item-meta > span {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  color: var(--text-secondary);
}

.archive-item-time {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  color: var(--text-secondary);
  flex-shrink: 0;
}

/* ─── MAP PAGE ─── */
.map-page {
  max-width: 900px;
  margin: 0 auto;
  padding: 3rem 2rem 5rem;
}

.world-map {
  width: 100%;
  height: 350px;
  background: rgba(26,23,20,0.03);
  border-radius: 12px;
  margin-bottom: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-style: italic;
  font-size: 1.1rem;
  color: var(--text-secondary);
  position: relative;
  overflow: hidden;
}

.world-map::after {
  content: "Map grows as we travel";
  opacity: 0.5;
}

[data-theme="dark"] .world-map { background: rgba(250,246,241,0.03); }

.map-locations {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 1.5rem;
}

.map-location {
  padding: 1.5rem;
  border-radius: 12px;
  background: rgba(26,23,20,0.03);
  transition: all 0.3s;
}

[data-theme="dark"] .map-location { background: rgba(250,246,241,0.03); }

.map-location:hover { transform: translateY(-3px); }

.map-location-name {
  font-family: var(--font-display);
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 0.2rem;
}

.map-location-count {
  font-family: var(--font-mono);
  font-size: 0.65rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-secondary);
  display: block;
  margin-bottom: 0.8rem;
}

.map-location-articles {
  list-style: none;
}

.map-location-articles li { margin-bottom: 0.3rem; }

.map-location-articles a {
  font-family: var(--font-body);
  font-size: 0.9rem;
  color: var(--terracotta);
  text-decoration: none;
}

.map-location-articles a:hover { text-decoration: underline; }

/* ─── COMMENTS ─── */
.comments-section {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid var(--rule);
}

.comments-label {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  font-weight: 500;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--terracotta);
  margin-bottom: 1rem;
}

.comments-setup-note {
  font-family: var(--font-body);
  font-size: 0.9rem;
  color: var(--text-secondary);
  font-style: italic;
}

.comments-setup-note a { color: var(--terracotta); }

/* ─── PARALLAX ADJUSTMENTS ─── */
.hero .shape {
  will-change: transform;
  transition: none;
}

/* ─── HERO TAGLINE/DESC INITIAL STATE FOR TYPEWRITER ─── */
#heroTagline, #heroDesc, #heroCta {
  transform: translateY(20px);
}

/* ─── RESPONSIVE FINAL ─── */
@media (max-width: 900px) {
  .contact-grid { grid-template-columns: 1fr; gap: 2.5rem; }
  .map-locations { grid-template-columns: 1fr; }
  .site-nav { gap: 1rem; flex-wrap: wrap; }
  .site-nav a { font-size: 0.7rem; letter-spacing: 0.08em; }
}

@media (max-width: 600px) {
  .archive-item a { flex-wrap: wrap; gap: 0.4rem; }
  .archive-item time { min-width: auto; }
  .archive-item-time { width: 100%; }
  .archive-year-title { font-size: 2.2rem; }
  .contact-page { padding: 2rem 1.5rem 4rem; }
  .site-nav a.nav-search { display: none; }
}
CSSEOF

echo ""
echo "═══════════════════════════════════════"
echo "  ✓ Final Enrichment complete!"
echo "═══════════════════════════════════════"
echo ""
echo "New features:"
echo "  📬  Contact page with Netlify form"
echo "  📚  Archives page by year"
echo "  🗺   World map page (locations)"
echo "  💬  Comments section (Giscus ready)"
echo "  🎬  Parallax on hero shapes"
echo "  ⌨   Typewriter effect on title"
echo ""
echo "New pages:"
echo "  /contact/   — Contact form"
echo "  /archives/  — All articles by year"  
echo "  /map/       — Writing locations"
echo ""
echo "To enable comments: go to https://giscus.app"
echo "and follow the setup, then edit layouts/partials/comments.html"
echo ""
echo "Run 'hugo server --buildDrafts' to preview."
