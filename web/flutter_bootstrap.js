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

_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
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