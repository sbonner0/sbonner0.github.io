# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is Stephen Bonner's personal blog, a Jekyll site built on the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme (installed as a gem, `jekyll-theme-chirpy` ~> 7.4), based on the `chirpy-starter` template. Theme internals (layouts, includes, sass partials) are NOT vendored into this repo except where explicitly overridden — see "Overrides" below. `assets/lib` is a git submodule (`chirpy-static-assets`) providing self-hosted JS/CSS libs.

## Common commands

Ruby/Jekyll dependencies are managed with Bundler.

```bash
bundle install                 # install gems

bash tools/run.sh               # serve locally with livereload at 127.0.0.1
bash tools/run.sh -H 0.0.0.0    # bind to all interfaces (e.g. in a container)
bash tools/run.sh -p             # serve in production mode (JEKYLL_ENV=production)

bash tools/test.sh               # full build + htmlproofer link/html validation (mirrors CI)
bash tools/test.sh -c "_config.yml,_config_other.yml"   # test with multiple configs

bundle exec jekyll b -d "_site"                 # build only, no test
bundle exec htmlproofer _site --disable-external \
  --ignore-urls "/^http:\/\/127.0.0.1/,/^http:\/\/0.0.0.0/,/^http:\/\/localhost/"  # test only
```

There is no JS/npm build step for this site (no `package.json`); `assets/lib` is prebuilt static assets from the submodule.

## Deployment

Pushes to `main` (or `master`) trigger `.github/workflows/pages-deploy.yml`, which builds with Jekyll in production mode, runs `htmlproofer` (internal links only, external link checking disabled), and deploys to GitHub Pages via `actions/deploy-pages`. There is no separate staging environment — a green build on `main` goes live. A failing htmlproofer check (e.g. a broken internal link or malformed HTML) blocks deployment, so run `bash tools/test.sh` before pushing content changes.

## Content structure

- **Posts** live in `_posts/`, named `YYYY-MM-DD-title.md`. Front matter convention (see existing posts for the pattern):
  ```yaml
  ---
  title: "Post Title"
  date: 2026-02-27 09:00:00 +0000
  categories: [linux]
  tags: [linux, lvm, arch]
  pin: false
  ---
  ```
  `layout: post`, `comments: true`, `toc: true`, and the `/posts/:title/` permalink are all applied globally via `defaults` in `_config.yml` — do not set them per-post.
- **Tabs** (top-level nav pages like About/Archives/Categories/Tags) live in `_tabs/` and are a Jekyll collection (`output: true, sort_by: order`); front matter sets `icon` and `order`.
- **`_data/`** holds structured content consumed by templates via Liquid, notably:
  - `profile.yml` — location, timezone, `current_focus` list, and `tools_stack` (grouped tool/tech items) rendered on the About page.
  - `contact.yml` — sidebar contact/social icons.
  - `share.yml` — post-sharing platform links.
  Prefer editing these data files over hardcoding equivalent content in `_tabs/about.md`.
- A commit-history-based `last_modified_at` is auto-injected into post front matter by `_plugins/posts-lastmod-hook.rb` (uses `git log` on the post's path), so it does not need to be set manually.

## Site configuration and overrides

`_config.yml` is the single source of truth for theme options (comments via giscus, PWA/offline cache, pagination, analytics providers, etc.) — most keys are theme defaults left blank/disabled; check here before assuming a feature (analytics, page views, self-hosted assets) is active.

Only two files override theme defaults and are the deliberate customization surface:
- `_layouts/home.html` — overrides the theme's home layout to add a "Welcome" hero section above the post list.
- `assets/css/jekyll-theme-chirpy.scss` — overrides theme sass; defines a custom **Nord** color palette (dark = Polar Night, light = Snow Storm) via CSS custom properties for both `html[data-bs-theme="..."]` (manual toggle, set by Chirpy's theme.js) and `prefers-color-scheme` (system default) paths — both must be kept in sync when changing a color token. Also styles the `.home-hero` block and restyles link-hover/button colors to match Nord instead of the theme's default orange accent.

When changing theme colors, update both the `html[data-bs-theme='dark'|'light']` block and the corresponding `@media (prefers-color-scheme: ...)` block in this file — they are intentionally duplicated to support both the manual theme toggle and OS-level preference.

`Gemfile.lock` is committed (not gitignored) specifically so the resolved `jekyll-theme-chirpy` version can't silently drift between local builds and CI — a prior untracked-lockfile setup let CI pick up a newer theme release mid-project that renamed the dark/light attribute from `data-mode` to `data-bs-theme`, breaking the color overrides above until it was pinned down. Bump the theme version deliberately (`bundle update jekyll-theme-chirpy`), not implicitly.
