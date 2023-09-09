import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final server = await HttpServer.bind('localhost', 8000);

  print('Proxy server is running on http://localhost:8000');

  await for (var request in server) {
    if (request.uri.path == '/imageProxy') {
      final imageUrl = request.uri.queryParameters['url'];

      if (imageUrl != null) {
        final response = await http.get(Uri.parse(imageUrl));

        if (response.statusCode == 200) {
          request.response
            ..headers.contentType = ContentType.parse('image/jpeg')
            ..headers.set('Cache-Control', 'max-age=3600')
            ..add(response.bodyBytes)
            ..close();
        } else {
          request.response
            ..headers.contentType = ContentType.parse('image/jpeg')
            ..add(utf8.encode('Error loading image'))
            ..close();
        }
      } else {
        request.response
          ..write('Missing "url" query parameter')
          ..close();
      }
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not Found')
        ..close();
    }
  }
}
