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

function installEngineDiagnostics() {
  const canvas = document.createElement('canvas');
  let webGl1 = false;
  let webGl2 = false;

  try {
    webGl2 = Boolean(canvas.getContext('webgl2'));
    webGl1 = Boolean(
      canvas.getContext('webgl') || canvas.getContext('experimental-webgl'),
    );
  } catch (error) {
    window.__aliqraReportStartupError(
      'WebGL capability check failed',
      error?.stack || String(error),
    );
  }

  window.__aliqraReportStartupPhase(
    `Browser capabilities: WebAssembly=${typeof WebAssembly !== 'undefined'}; ` +
    `compileStreaming=${typeof WebAssembly?.compileStreaming === 'function'}; ` +
    `WebGL1=${webGl1}; WebGL2=${webGl2}; UA=${navigator.userAgent}`,
  );

  const originalFetch = window.fetch.bind(window);
  window.fetch = async (...args) => {
    const input = args[0];
    const url = typeof input === 'string' ? input : input?.url || String(input);
    const isEngineResource =
      url.includes('/canvaskit/') || url.includes('/skwasm');

    if (isEngineResource) {
      window.__aliqraReportStartupPhase(
        `Engine resource request started: ${url}`,
      );
    }

    try {
      const response = await originalFetch(...args);
      if (isEngineResource) {
        window.__aliqraReportStartupPhase(
          `Engine resource response: HTTP ${response.status}; ` +
          `${response.headers.get('content-length') || 'unknown'} encoded bytes; ` +
          `${url}`,
        );
      }
      return response;
    } catch (error) {
      if (isEngineResource) {
        window.__aliqraReportStartupError(
          `Engine resource request failed: ${url}`,
          error?.stack || String(error),
        );
      }
      throw error;
    }
  };

  if (typeof PerformanceObserver === 'function') {
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (
          entry.name.includes('/canvaskit/') ||
          entry.name.includes('/skwasm') ||
          entry.name.endsWith('/main.dart.js')
        ) {
          window.__aliqraReportStartupPhase(
            `Resource timing completed: ${entry.name}; ` +
            `${entry.duration.toFixed(0)}ms; transferSize=${entry.transferSize || 0}; ` +
            `encodedBodySize=${entry.encodedBodySize || 0}; ` +
            `decodedBodySize=${entry.decodedBodySize || 0}`,
          );
        }
      }
    });
    observer.observe({type: 'resource', buffered: true});
  }

  const originalCompileStreaming =
    WebAssembly.compileStreaming?.bind(WebAssembly);
  if (originalCompileStreaming) {
    WebAssembly.compileStreaming = async (source) => {
      window.__aliqraReportStartupPhase(
        'CanvasKit WASM compileStreaming started',
      );
      try {
        const module = await originalCompileStreaming(source);
        window.__aliqraReportStartupPhase(
          'CanvasKit WASM compileStreaming completed',
        );
        return module;
      } catch (error) {
        window.__aliqraReportStartupError(
          'CanvasKit WASM compileStreaming failed',
          error?.stack || String(error),
        );
        throw error;
      }
    };
  }

  const originalInstantiate = WebAssembly.instantiate.bind(WebAssembly);
  WebAssembly.instantiate = async (...args) => {
    window.__aliqraReportStartupPhase(
      'CanvasKit WASM instantiate started',
    );
    try {
      const instance = await originalInstantiate(...args);
      window.__aliqraReportStartupPhase(
        'CanvasKit WASM instantiate completed',
      );
      return instance;
    } catch (error) {
      window.__aliqraReportStartupError(
        'CanvasKit WASM instantiate failed',
        error?.stack || String(error),
      );
      throw error;
    }
  };
}

installEngineDiagnostics();

const engineConfig = {
  canvasKitVariant: 'full',
  canvasKitForceCpuOnly: true,
};
window.__aliqraReportStartupPhase(
  `CanvasKit JS request starting: ` +
  `${new URL('canvaskit/canvaskit.js', document.baseURI)}`,
);

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
    const contentEncoding =
      response.headers.get('content-encoding') || 'not exposed/none';
    const transferEncoding =
      response.headers.get('transfer-encoding') || 'not exposed/none';
    const cacheControl =
      response.headers.get('cache-control') || 'not exposed/none';
    window.__aliqraReportStartupPhase(
      `main.dart.js response headers received: HTTP ${response.status}; ` +
      `content-encoding=${contentEncoding}; ` +
      `content-length=${contentLength}; ` +
      `transfer-encoding=${transferEncoding}; cache-control=${cacheControl}`,
    );
    window.__aliqraReportStartupPhase(
      'main.dart.js progress reports decoded bytes; compressed byte progress ' +
      'is available only after completion through Resource Timing',
    );

    if (!response.ok) {
      throw new Error(`HTTP ${response.status} while fetching ${scriptUrl}`);
    }

    const chunks = [];
    let bytesRead = 0;
    let lastReportedBytes = 0;

    if (response.body) {
      const reader = response.body.getReader();
      while (true) {
        const result = await reader.read();
        if (result.done) break;
        chunks.push(result.value);
        bytesRead += result.value.byteLength;
        if (bytesRead - lastReportedBytes >= 262144) {
          lastReportedBytes = bytesRead;
          window.__aliqraReportStartupPhase(
            `main.dart.js downloading: ${bytesRead} decoded bytes received`,
          );
        }
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
  config: engineConfig,
  onEntrypointLoaded: async (engineInitializer) => {
    window.__aliqraReportStartupPhase(
      'engine entrypoint loaded; engine initialization started',
    );
    window.__aliqraReportStartupPhase(
      'CanvasKit renderer initialization started: full variant, CPU-only',
    );
    const appRunner = await engineInitializer.initializeEngine(engineConfig);
    window.__aliqraReportStartupPhase(
      'CanvasKit renderer initialization completed',
    );
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