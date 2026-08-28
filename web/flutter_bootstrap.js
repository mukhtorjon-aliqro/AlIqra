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
  for (const node of nodes) {
    if (node instanceof HTMLScriptElement && node.src.endsWith('/main.dart.js')) {
      window.__aliqraReportStartupPhase(
        `main.dart.js requested: ${node.src}`,
      );
      node.addEventListener('load', () => {
        window.__aliqraReportStartupPhase(
          'main.dart.js loaded; waiting for engine entrypoint callback',
        );
      });
      node.addEventListener('error', () => {
        window.__aliqraReportStartupError(
          `main.dart.js failed to load: ${node.src}`,
          '',
        );
      });
    }
  }
  return originalHeadAppend(...nodes);
};

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