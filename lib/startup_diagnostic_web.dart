import 'dart:js_interop';

@JS('__aliqraReportStartupPhase')
external void _reportStartupPhase(JSString phase);

@JS('__aliqraReportStartupError')
external void _reportStartupError(JSString message, JSString stack);

void reportStartupPhase(String phase) {
  _reportStartupPhase(phase.toJS);
}

void reportStartupError(Object error, StackTrace stackTrace) {
  _reportStartupError(error.toString().toJS, stackTrace.toString().toJS);
}