# Figma to Deployable Website: A Complete Guide

This guide walks through the entire process of turning a Figma design into a live, deployable website — using this portfolio project as a concrete example.

---

## Table of Contents

1. [Overview](#overview)
2. [Phase 1: Inspect and Extract from Figma](#phase-1-inspect-and-extract-from-figma)
3. [Phase 2: Set Up Your Project Structure](#phase-2-set-up-your-project-structure)
4. [Phase 3: Translate Design to HTML and CSS](#phase-3-translate-design-to-html-and-css)
5. [Phase 4: Add Interactivity](#phase-4-add-interactivity)
6. [Phase 5: Test and Refine](#phase-5-test-and-refine)
7. [Phase 6: Deploy](#phase-6-deploy)
8. [Using Cursor AI to Speed Up the Process](#using-cursor-ai-to-speed-up-the-process)
9. [Quick Reference: Figma CSS Mapping](#quick-reference-figma-css-mapping)

---

## Overview

The workflow has three major phases:

```
Figma Design  -->  Code (HTML/CSS/JS)  -->  Live Website
```

**What you need:**
- A Figma account (free tier works)
- A code editor (Cursor recommended)
- A GitHub account (for free hosting via GitHub Pages)
- Basic knowledge of HTML, CSS, and optionally JavaScript

**What this project uses:**
- Plain HTML, CSS, and vanilla JavaScript (no build tools or frameworks)
- Google Fonts (Inter)
- GitHub Pages for hosting

---

## Phase 1: Inspect and Extract from Figma

### 1.1 Use Dev Mode (or Inspect Panel)

Open your Figma file and switch to **Dev Mode** (toggle in the top-right toolbar). This gives you:

- **Dimensions**: Width, height, padding, margins for each element
- **Typography**: Font family, size, weight, line height, letter spacing
- **Colors**: Hex/RGB/HSL values, opacity
- **Spacing**: Gaps between elements, padding within containers
- **Border radius**: Corner rounding values
- **Shadows**: Box shadow parameters

### 1.2 Extract Design Tokens

Before writing any code, pull out the repeating values from your Figma file and record them. These become your CSS custom properties:

| Figma Token | CSS Variable | Value |
|---|---|---|
| Background color | `--bg` | `#f8f8f6` |
| Surface / card bg | `--surface` | `#ffffff` |
| Alt surface | `--surface-alt` | `#f1f3f7` |
| Primary text | `--text` | `#171717` |
| Muted text | `--muted` | `#62646b` |
| Border / line color | `--line` | `#d9dde6` |
| Accent / brand | `--accent` | `#2f6ff8` |
| Border radius | `--radius` | `16px` |

### 1.3 Export Assets

For any images, icons, or illustrations in the Figma design:

1. Select the element in Figma
2. In the right panel under **Export**, choose the format:
   - **SVG** for icons and illustrations (scalable, small file size)
   - **PNG @2x** for photos or complex graphics (use 2x for retina screens)
   - **WebP** for photos when browser support is acceptable (smaller than PNG)
3. Click **Export** and save to an `assets/` or `images/` folder in your project

### 1.4 Identify the Layout Structure

Map Figma frames to HTML sections. Look at the top-level frames in your design:

```
Figma Frame            -->  HTML Element
─────────────────────────────────────────
Navigation bar         -->  <header>
Hero section           -->  <section class="hero">
Work / Projects grid   -->  <section id="work">
Experience timeline    -->  <section id="experience">
About teaser           -->  <section id="about">
Footer / Contact       -->  <footer>
```

---

## Phase 2: Set Up Your Project Structure

For a static site (no framework), keep it simple:

```
your-project/
├── index.html          # Home page
├── about.html          # Additional pages
├── styles.css          # All styles
├── script.js           # Interactivity
└── assets/             # Images, icons, fonts (if self-hosted)
    ├── images/
    └── icons/
```

### 2.1 Create Your HTML Boilerplate

Start every page with a proper document structure:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    <meta name="description" content="A brief description for search engines.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="./styles.css">
  </head>
  <body>
    <!-- Your content goes here -->
    <script src="./script.js"></script>
  </body>
</html>
```

### 2.2 Set Up CSS with Design Tokens

Transfer the tokens you extracted in Phase 1 into CSS custom properties:

```css
:root {
  --bg: #f8f8f6;
  --surface: #ffffff;
  --surface-alt: #f1f3f7;
  --text: #171717;
  --muted: #62646b;
  --line: #d9dde6;
  --accent: #2f6ff8;
  --accent-strong: #1648b7;
  --radius: 16px;
  --shadow: 0 16px 34px rgba(20, 24, 38, 0.08);
}
```

---

## Phase 3: Translate Design to HTML and CSS

### 3.1 Work Section by Section, Top to Bottom

Don't try to build the whole page at once. Go section by section:

1. **Navigation** — Build the header and nav links first (it appears on every page)
2. **Hero** — The first thing visitors see
3. **Content sections** — Work through each one in order
4. **Footer** — Contact info and copyright

### 3.2 Figma Layout to CSS Layout

Figma's Auto Layout maps directly to CSS Flexbox and Grid:

| Figma Auto Layout | CSS Equivalent |
|---|---|
| Horizontal direction | `display: flex; flex-direction: row;` |
| Vertical direction | `display: flex; flex-direction: column;` |
| Gap between items | `gap: 16px;` |
| Padding | `padding: 24px;` |
| Fill container (horizontal) | `width: 100%;` or `flex: 1;` |
| Hug contents | `width: fit-content;` |
| Fixed width | `width: 320px;` |

For multi-column layouts (like the work grid), use CSS Grid:

```css
.work-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 1.1rem;
}
```

### 3.3 Typography: Figma to CSS

Map each text style from Figma:

| Figma Property | CSS Property |
|---|---|
| Font family: Inter | `font-family: "Inter", sans-serif;` |
| Font size: 48 | `font-size: 3rem;` (or use `clamp()` for responsiveness) |
| Font weight: Bold (700) | `font-weight: 700;` |
| Line height: 120% | `line-height: 1.2;` |
| Letter spacing: -3% | `letter-spacing: -0.03em;` |
| Text transform: UPPERCASE | `text-transform: uppercase;` |

Use `clamp()` for responsive font sizes instead of fixed pixel values:

```css
h1 {
  font-size: clamp(2.05rem, 5vw, 3.7rem);
}
```

### 3.4 Responsive Design

Figma designs typically show desktop, tablet, and mobile breakpoints. Translate these to CSS media queries:

```css
/* Tablet */
@media (max-width: 920px) {
  .hero-grid { grid-template-columns: 1fr; }
  .work-grid { grid-template-columns: repeat(2, 1fr); }
}

/* Mobile */
@media (max-width: 700px) {
  .work-grid { grid-template-columns: 1fr; }
  .menu-toggle { display: inline-flex; }
  .site-nav { display: none; }
}
```

### 3.5 Common Figma-to-CSS Patterns

**Cards with hover effects:**
```css
.work-card {
  background: var(--surface);
  border: 1px solid var(--line);
  border-radius: var(--radius);
  padding: 1.25rem;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.work-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow);
}
```

**Sticky header with blur:**
```css
.site-header {
  position: sticky;
  top: 0;
  z-index: 100;
  backdrop-filter: blur(8px);
  background: rgba(248, 248, 246, 0.9);
  border-bottom: 1px solid rgba(217, 221, 230, 0.8);
}
```

**Pill buttons:**
```css
.button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 999px;
  background: var(--accent);
  color: #fff;
  padding: 0.75rem 1.1rem;
  font-weight: 600;
  text-decoration: none;
}
```

---

## Phase 4: Add Interactivity

For a static portfolio, you typically need minimal JavaScript:

- **Mobile menu toggle** — Show/hide navigation on small screens
- **Smooth scroll** — CSS handles this with `scroll-behavior: smooth;`
- **Dynamic copyright year** — So you never have to update it manually

```javascript
const menuToggle = document.querySelector("#menu-toggle");
const siteNav = document.querySelector("#site-nav");

if (menuToggle && siteNav) {
  menuToggle.addEventListener("click", () => {
    const isOpen = siteNav.classList.toggle("is-open");
    menuToggle.setAttribute("aria-expanded", String(isOpen));
  });
}

document.querySelector("#year").textContent = String(new Date().getFullYear());
```

---

## Phase 5: Test and Refine

### 5.1 Local Preview

Open `index.html` directly in a browser, or use a local server for a more accurate preview:

```bash
# Python (built-in)
python3 -m http.server 8000

# Node.js (if installed)
npx serve .

# VS Code / Cursor
# Use the "Live Server" extension — right-click index.html > "Open with Live Server"
```

### 5.2 Cross-Browser Testing

Test in at least:
- Chrome
- Firefox
- Safari (if on macOS/iOS)
- Mobile browsers (use Chrome DevTools device emulation)

### 5.3 Performance Checklist

- [ ] Images are optimized (compressed, correct format)
- [ ] Fonts use `preconnect` for faster loading
- [ ] CSS and JS are minified for production (optional for small sites)
- [ ] No unused CSS or JavaScript

### 5.4 Accessibility Checklist

- [ ] All images have `alt` text
- [ ] Color contrast meets WCAG AA (4.5:1 for body text)
- [ ] Keyboard navigation works (tab through all interactive elements)
- [ ] Skip-to-content link is present
- [ ] ARIA attributes are used where needed (e.g., `aria-expanded` on menu toggle)

---

## Phase 6: Deploy

### Option A: GitHub Pages (Free — Used by This Project)

This repository (`GnatGnuyen.github.io`) is already configured for GitHub Pages. Here's how it works:

**Initial Setup (one-time):**

1. Create a GitHub repository named `<your-username>.github.io`
2. Push your code to the `main` branch
3. Go to **Settings > Pages** in your repository
4. Under **Source**, select **Deploy from a branch** and choose `main` / `/ (root)`
5. Your site will be live at `https://<your-username>.github.io`

**Deploying Updates:**

```bash
git add .
git commit -m "Update portfolio content"
git push origin main
```

GitHub Pages automatically rebuilds within a few minutes after each push to `main`.

**Custom Domain (optional):**

1. Buy a domain (e.g., from Namecheap, Google Domains, Cloudflare)
2. In your repo, go to **Settings > Pages > Custom domain** and enter your domain
3. Add DNS records at your domain registrar:
   - For apex domain (`example.com`): Add A records pointing to GitHub's IPs:
     ```
     185.199.108.153
     185.199.109.153
     185.199.110.153
     185.199.111.153
     ```
   - For subdomain (`www.example.com`): Add a CNAME record pointing to `<username>.github.io`
4. Check **Enforce HTTPS** in GitHub Pages settings
5. A `CNAME` file will be auto-created in your repo

### Option B: Netlify (Free Tier)

1. Go to [netlify.com](https://netlify.com) and sign up
2. Click **Add new site > Import an existing project**
3. Connect your GitHub repo
4. Set **Branch to deploy**: `main`, **Publish directory**: `.` (root)
5. Click **Deploy site**

Netlify gives you a URL like `random-name.netlify.app`. You can set a custom domain in **Domain settings**.

### Option C: Vercel (Free Tier)

1. Go to [vercel.com](https://vercel.com) and sign up with GitHub
2. Click **Add New > Project** and import your repo
3. Framework preset: **Other**
4. Click **Deploy**

### Option D: Cloudflare Pages (Free Tier)

1. Go to [pages.cloudflare.com](https://pages.cloudflare.com)
2. Click **Create a project > Connect to Git**
3. Select your repo, set **Build output directory**: `.` (root)
4. Deploy

### Comparison

| Feature | GitHub Pages | Netlify | Vercel | Cloudflare Pages |
|---|---|---|---|---|
| Free tier | Yes | Yes | Yes | Yes |
| Custom domain | Yes | Yes | Yes | Yes |
| HTTPS | Yes | Yes | Yes | Yes |
| Auto-deploy on push | Yes | Yes | Yes | Yes |
| Build tools support | Jekyll only | Any | Any | Any |
| Edge network / CDN | Limited | Yes | Yes | Yes (global) |
| Best for | Static HTML | Static + JAMstack | Next.js / React | Static + Workers |

---

## Using Cursor AI to Speed Up the Process

Cursor can dramatically accelerate the Figma-to-code workflow:

### Approach 1: Describe the Design

Open Cursor Chat and describe what you see in Figma:

> "Create a sticky navigation header with a logo on the left, four nav links on the right,
> and a hamburger menu on mobile. Use Inter font, #171717 for text, and a blurred
> background effect."

Cursor will generate the HTML and CSS for you.

### Approach 2: Paste a Screenshot

Take a screenshot of your Figma design and paste it into Cursor Chat:

> [paste screenshot]
> "Convert this design to HTML and CSS. Use CSS Grid for the layout, Inter from
> Google Fonts, and make it responsive."

### Approach 3: Iterate Section by Section

Build incrementally:
1. Ask Cursor to create the header
2. Review and refine
3. Ask for the hero section
4. Continue through each section

### Approach 4: Figma Dev Mode + Cursor

1. In Figma Dev Mode, copy the CSS values for an element
2. Paste into Cursor Chat: "Here are the Figma values for my card component: [paste]. Convert to a reusable CSS class."

---

## Quick Reference: Figma CSS Mapping

| Figma | CSS |
|---|---|
| Frame | `<div>`, `<section>`, `<article>` |
| Auto Layout (horizontal) | `display: flex;` |
| Auto Layout (vertical) | `display: flex; flex-direction: column;` |
| Auto Layout gap | `gap: Xpx;` |
| Constraints (left & right) | `width: 100%;` or `margin: 0 auto;` |
| Fill (in auto layout) | `flex: 1;` |
| Fixed size | `width: Xpx; height: Ypx;` |
| Corner radius | `border-radius: Xpx;` |
| Drop shadow | `box-shadow: Xpx Ypx Bpx Spx rgba(…);` |
| Inner shadow | `box-shadow: inset Xpx Ypx Bpx rgba(…);` |
| Background blur | `backdrop-filter: blur(Xpx);` |
| Opacity | `opacity: 0.X;` |
| Stroke (inside) | `border: Xpx solid color; box-sizing: border-box;` |
| Stroke (outside) | `outline: Xpx solid color;` |
| Text align center | `text-align: center;` |
| Clip content | `overflow: hidden;` |
| Absolute position | `position: absolute;` with `top/left/right/bottom` |
