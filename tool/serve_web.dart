import 'dart:io';

final _gzipCache = <String, List<int>>{};

const _mimeTypes = <String, String>{
  '.css': 'text/css; charset=utf-8',
  '.html': 'text/html; charset=utf-8',
  '.ico': 'image/x-icon',
  '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.otf': 'font/otf',
  '.png': 'image/png',
  '.svg': 'image/svg+xml',
  '.wasm': 'application/wasm',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
};

Future<void> main(List<String> args) async {
  final root = Directory(args.isEmpty ? 'build/web' : args.first).absolute;
  final port = _readPort(args);

  if (!root.existsSync()) {
    stderr.writeln('Static web directory does not exist: ${root.path}');
    exitCode = 1;
    return;
  }

  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  stdout.writeln('Serving ${root.path} at http://0.0.0.0:$port');

  await for (final request in server) {
    _serve(request, root);
  }
}

int _readPort(List<String> args) {
  final portArgument = args
      .skip(1)
      .firstWhere((argument) => argument.startsWith('--port='), orElse: () => '');
  return int.tryParse(portArgument.replaceFirst('--port=', '')) ?? 5000;
}

Future<void> _serve(HttpRequest request, Directory root) async {
  if (request.method != 'GET' && request.method != 'HEAD') {
    request.response
      ..statusCode = HttpStatus.methodNotAllowed
      ..headers.set(HttpHeaders.allowHeader, 'GET, HEAD')
      ..close();
    return;
  }

  try {
    final segments = request.uri.pathSegments;
    if (segments.any((segment) => segment == '..' || segment == '.')) {
      _respondNotFound(request);
      return;
    }

    var file = File('${root.path}/${segments.join('/')}');
    if (request.uri.path.endsWith('/') || segments.isEmpty) {
      file = File('${root.path}/index.html');
    }

    if (!file.existsSync()) {
      final hasExtension =
          segments.isNotEmpty && segments.last.contains('.');
      if (!hasExtension) {
        file = File('${root.path}/index.html');
      }
    }

    if (!file.existsSync()) {
      _respondNotFound(request);
      return;
    }

    final bytes = await file.readAsBytes();
    final extension = file.path.contains('.')
        ? file.path.substring(file.path.lastIndexOf('.')).toLowerCase()
        : '';
    final mimeType = _mimeTypes[extension] ?? 'application/octet-stream';
    final acceptsGzip =
        request.headers.value(HttpHeaders.acceptEncodingHeader)?.contains(
              'gzip',
            ) ??
            false;
    final shouldCompress = acceptsGzip &&
        const {'.css', '.html', '.js', '.json', '.svg', '.wasm'}
            .contains(extension);
    final responseBytes = shouldCompress
        ? _gzipCache.putIfAbsent(file.path, () => gzip.encode(bytes))
        : bytes;

    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.parse(mimeType)
      ..headers.contentLength = responseBytes.length
      ..headers.set(HttpHeaders.cacheControlHeader, 'no-store');

    if (shouldCompress) {
      request.response.headers
        ..set(HttpHeaders.contentEncodingHeader, 'gzip')
        ..set(HttpHeaders.varyHeader, HttpHeaders.acceptEncodingHeader);
    }

    if (request.method == 'GET') {
      request.response.add(responseBytes);
    }
    await request.response.close();
  } on FileSystemException {
    _respondNotFound(request);
  }
}

void _respondNotFound(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.notFound
    ..headers.contentType = ContentType.text
    ..close();
}