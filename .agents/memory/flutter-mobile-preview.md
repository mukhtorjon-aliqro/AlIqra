---
name: Flutter mobile preview mode
description: Why AlIqra's public Replit development URL should use Flutter web release mode.
---

Use Flutter web release mode for the public `Start application` workflow rather
than the default debug web-server mode.

**Why:** The debug runtime serves a large Dart SDK and a graph of DDC modules.
It rendered internally but stalled at a white screen through the external URL
and on Android Chrome. The single release bundle rendered successfully in a
fresh external browser session. The run-mode service worker was empty and was
not the active caching source.

**How to apply:** When changing the preview workflow, preserve `--release`,
port 5000, and host `0.0.0.0`. Recheck the external URL after compilation,
including `main.dart.js` MIME type and a fresh-session render.