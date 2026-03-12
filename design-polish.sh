#!/bin/bash
# Pinterlude — Design Polish
echo "→ Polishing design..."

cat >> static/css/style.css << 'CSSEOF'

/* ═══════════════════════════════════════
   DESIGN POLISH
   ═══════════════════════════════════════ */

/* Tagline: more presence, less ghost */
.hero .hero-tagline {
  color: #F0D9CC !important;
  opacity: 0.9 !important;
  font-size: clamp(1.2rem, 2.8vw, 1.6rem) !important;
  letter-spacing: 0.06em !important;
}

/* Remove typewriter cursor after animation completes */
.hero-title.typed::after {
  display: none;
}

/* Nav z-index fix */
.site-nav-bar {
  z-index: 1000;
  position: fixed;
}

.site-nav-bar.scrolled {
  z-index: 1000;
}

/* Newsletter band should not overlap nav */
.newsletter-band {
  position: relative;
  z-index: 1;
}

/* Hero desc slightly brighter */
.hero .hero-desc {
  color: rgba(250,246,241,0.6) !important;
}

/* Hero CTA slightly more visible */
.hero .hero-cta {
  border-color: rgba(255,255,255,0.3) !important;
}

/* Scroll hint more subtle */
.scroll-hint {
  opacity: 0.5;
}
CSSEOF

# Fix typewriter: add class 'typed' when done to remove cursor
sed -i "s|document.getElementById('heroScroll').style.transition = 'opacity 1s';|document.getElementById('heroScroll').style.transition = 'opacity 1s';\n          el.classList.add('typed');|" layouts/index.html

echo "✓ Design polished!"
echo "  - Tagline brighter and larger"
echo "  - Typewriter cursor disappears after typing"
echo "  - Nav z-index fixed"
echo "  - Hero description brighter"
echo "Run 'hugo server --buildDrafts' to preview."
