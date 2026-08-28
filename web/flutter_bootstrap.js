{{flutter_js}}
{{flutter_build_config}}

window.__aliqraReportStartupPhase('flutter_bootstrap.js executed');

if (!_flutter || !_flutter.loader) {
  window.__aliqraReportStartupError(
    '_flutter.loader is unavailable after bootstrap execution',
    '',
  );
  throw new Error('_flutter.loader is unavailable after bootstrap execution');
}

window.__aliqraReportStartupPhase('_flutter.loader available');

const originalHeadAppend = document.head.append.bind(document.head);
document.head.append = (...nodes) => {
  const immediateNodes = [];

  for (const node of nodes) {
    if (node instanceof HTMLScriptElement && node.src.endsWith('/main.dart.js')) {
      loadMainScriptWithProgress(node);
    } else {
      immediateNodes.push(node);
    }
  }

  if (immediateNodes.length > 0) {
    return originalHeadAppend(...immediateNodes);
  }
};

async function loadMainScriptWithProgress(script) {
  const scriptUrl = script.src;

  try {
    window.__aliqraReportStartupPhase(
      `main.dart.js fetch started: ${scriptUrl}`,
    );
    const response = await fetch(scriptUrl, {cache: 'no-store'});
    const contentLength = response.headers.get('content-length') || 'unknown';
    window.__aliqraReportStartupPhase(
      `main.dart.js response: HTTP ${response.status}; ` +
      `content-length ${contentLength}`,
    );

    if (!response.ok) {
      throw new Error(`HTTP ${response.status} while fetching ${scriptUrl}`);
    }

    const chunks = [];
    let bytesRead = 0;

    if (response.body) {
      const reader = response.body.getReader();
      while (true) {
        const result = await reader.read();
        if (result.done) break;
        chunks.push(result.value);
        bytesRead += result.value.byteLength;
        window.__aliqraReportStartupPhase(
          `main.dart.js downloading: ${bytesRead} decoded bytes received`,
        );
      }
    } else {
      const bytes = new Uint8Array(await response.arrayBuffer());
      chunks.push(bytes);
      bytesRead = bytes.byteLength;
    }

    window.__aliqraReportStartupPhase(
      `main.dart.js download complete: ${bytesRead} decoded bytes; executing`,
    );

    const blobUrl = URL.createObjectURL(
      new Blob(chunks, {type: 'text/javascript'}),
    );
    script.src = blobUrl;
    script.addEventListener('load', () => {
      URL.revokeObjectURL(blobUrl);
      window.__aliqraReportStartupPhase(
        'main.dart.js executed; waiting for engine entrypoint callback',
      );
    });
    script.addEventListener('error', () => {
      URL.revokeObjectURL(blobUrl);
      window.__aliqraReportStartupError(
        'main.dart.js downloaded but failed during script execution',
        scriptUrl,
      );
    });
    window.__aliqraReportStartupPhase(
      `main.dart.js script execution started after ${bytesRead} decoded bytes`,
    );
    originalHeadAppend(script);
  } catch (error) {
    window.__aliqraReportStartupError(
      `main.dart.js fetch failed: ${scriptUrl}`,
      error?.stack || String(error),
    );
    throw error;
  }
}

window.__aliqraReportStartupPhase(
  'Flutter loader started; service worker disabled',
);

_flutter.loader.load({
  serviceWorkerSettings: null,
  onEntrypointLoaded: async (engineInitializer) => {
    window.__aliqraReportStartupPhase(
      'engine entrypoint loaded; engine initialization started',
    );
    const appRunner = await engineInitializer.initializeEngine();
    window.__aliqraReportStartupPhase('engine initialization completed');
    window.__aliqraReportStartupPhase('app runner started');
    await appRunner.runApp();
  },
}).catch((error) => {
  window.__aliqraReportStartupError(
    'Flutter loader/engine startup error',
    error?.stack || String(error),
  );
  throw error;
});