---
name: Flutter mobile preview mode
description: Why AlIqra's public Replit development URL should use Flutter web release mode.
---

Build Flutter web in release mode and serve `build/web` with the project's
static SPA server for the public `Start application` workflow. Do not use
`flutter run -d web-server` for the phone-facing preview.

**Why:** Both debug and release variants of Flutter's development web server
were unreliable on a physical Android browser. Serving the generated release
files directly is production-like, allows explicit MIME and SPA-fallback
handling, and disables PWA caching for the development URL.

**How to apply:** Preserve the release build with PWA strategy `none`, the
static server on port 5000, and host `0.0.0.0`. Recheck the external URL after
compilation, including JS, WASM, font MIME types and a fresh-session render.