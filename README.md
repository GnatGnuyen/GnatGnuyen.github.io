# Deploy this site via GitHub Pages

This repository is configured to auto-deploy the static site to GitHub Pages using GitHub Actions.

## What is already set up

- Workflow file: `.github/workflows/deploy-pages.yml`
- Deploy trigger: push to branch `cursor/figma-to-web-process-eb6d`
- Site files: repository root (`index.html`, `about.html`, `styles.css`, `script.js`)

## One-time GitHub setting

1. Open your repository on GitHub.
2. Go to **Settings -> Pages**.
3. Under **Build and deployment**, set **Source** to **GitHub Actions**.

After this, every push to `cursor/figma-to-web-process-eb6d` deploys automatically.

## Your site URL

Once deployment succeeds, the site is available at:

- `https://<your-github-username>.github.io/<repository-name>/`

If this is a user/org site repo named `<your-github-username>.github.io`, the URL is:

- `https://<your-github-username>.github.io/`

## Local preview

Open `index.html` in a browser, or run any static file server from the repo root.
