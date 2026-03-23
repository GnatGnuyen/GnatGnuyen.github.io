# Natalie Nguyen — Portfolio

A static portfolio website built from a Figma design: plain HTML, CSS, and vanilla JavaScript — no build tools, no framework.

---

## Figma → Deployable Website: Step-by-Step

### 1. Design in Figma

- Build your pages and components in Figma.
- Use **Figma's Dev Mode** (or the **Inspect** panel) to copy exact values: colours, font sizes, spacing, border-radius, shadows, and so on.
- Export any images / icons you need (SVG preferred for icons, WebP/PNG for photos). Place them in an `assets/` folder alongside your HTML files.

### 2. Translate the Design to Code

The conversion from Figma to static files is manual but straightforward:

| Figma concept | Code equivalent |
|---|---|
| Frame / component | `<section>`, `<article>`, `<div>` |
| Auto-layout (horizontal) | `display: flex; gap: …` |
| Auto-layout (vertical) | `display: grid` or `flex-direction: column` |
| Fill / stroke colour | CSS `background`, `border`, `color` |
| Text styles | CSS custom properties (`--text`, `--muted`) + `font-size`, `font-weight` |
| Drop shadow | `box-shadow` |
| Corner radius | `border-radius` |
| Constraints / responsive | CSS `@media` queries, `clamp()`, `min()` |

**Recommended order:**

1. Create `styles.css` — define CSS custom properties for every design token (colour palette, border-radius, shadow).
2. Write the HTML structure page by page, section by section, matching Figma layers.
3. Style each section using the values from Figma's Inspect panel.
4. Add interactivity (mobile nav toggle, smooth scroll, etc.) in `script.js`.
5. Check every breakpoint in the browser's DevTools responsive viewer.

### 3. Project Structure

```
/
├── index.html      # Home / portfolio page
├── about.html      # About page
├── styles.css      # All styles (custom properties → layout → components → responsive)
├── script.js       # Mobile nav toggle, footer year
└── assets/         # Images, icons (add as needed)
```

No package manager or build step is required. Open `index.html` directly in a browser to preview.

---

## Local Development

No installation needed.

```bash
# Option A — open the file directly
open index.html          # macOS
start index.html         # Windows
xdg-open index.html      # Linux

# Option B — run a local server (avoids some browser fetch restrictions)
npx serve .              # Node.js (npx, no install)
python3 -m http.server   # Python 3
```

---

## Deployment

### Netlify (recommended — zero config)

1. Push this repository to GitHub (or GitLab / Bitbucket).
2. Go to [app.netlify.com](https://app.netlify.com) → **Add new site → Import an existing project**.
3. Authorise Netlify to access your repo and select it.
4. Leave **Build command** and **Publish directory** blank (Netlify auto-detects static sites at the repo root).
5. Click **Deploy site** — your site is live in ~30 seconds at a `*.netlify.app` URL.
6. (Optional) Add a custom domain in **Site settings → Domain management**.

A `netlify.toml` is included in this repo for consistent settings across environments.

### GitHub Pages (free, no third-party account)

A GitHub Actions workflow (`.github/workflows/deploy.yml`) is included. It publishes the site automatically on every push to `main`:

1. Push this repository to GitHub.
2. Go to your repo → **Settings → Pages → Source** and choose **GitHub Actions**.
3. Push a commit — the workflow runs and your site appears at `https://<username>.github.io/<repo-name>/`.

### Vercel

1. Go to [vercel.com/new](https://vercel.com/new) and import the GitHub repo.
2. Leave all settings as defaults (Vercel detects a static site automatically).
3. Click **Deploy**.

### Any static host (Render, Surge, Cloudflare Pages, S3 + CloudFront, …)

Upload the four files (`index.html`, `about.html`, `styles.css`, `script.js`) plus any `assets/` folder to the host. No build step, no server configuration.

---

## Customising the Content

| What to change | Where |
|---|---|
| Name, title, bio | `index.html` hero section and `about.html` |
| Work case studies | `index.html` `.work-grid` articles |
| Experience timeline | `index.html` `.timeline` articles |
| Contact links | `index.html` footer (`mailto:`, LinkedIn, GitHub) |
| Colour palette | `styles.css` `:root` custom properties |
| Fonts | `<link>` in `<head>` of both HTML files + `font-family` in `styles.css` |

---

## Accessibility

- Skip-to-content link (`<a class="skip-link">`) is the first focusable element.
- Mobile menu toggle uses `aria-expanded` and `aria-controls`.
- Semantic HTML5 landmarks (`<header>`, `<main>`, `<footer>`, `<nav>`, `<section>`, `<article>`).
- Colour contrast ratios meet WCAG AA on all text/background combinations.

---

## License

MIT — use this as a starting point for your own portfolio.
