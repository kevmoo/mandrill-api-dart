library mandrill_api_server;

import 'dart:async' as async;
import 'dart:io' as io;

import 'mandrill_api.dart';
export 'mandrill_api.dart' show MANDRILL_OPTS;

///Extend the base API class to make HTTP requests using dart:io
class Mandrill extends APIBase {
  Mandrill(String apikey, [bool debug]) : super(apikey, debug);

  ///Make the appropriate call, returning a future that yields an API result
  async.Future request(Uri uri, Map headers, String body) async {
    var client = new io.HttpClient();

    try {
      var request = await client.postUrl(uri);
      headers.forEach((k, v) => request.headers.set(k, v));
      request.contentLength = body.length;
      request.write(body);

      var response = await request.close();

      var data = await response.expand((chunk) => chunk).toList();

      var responseBody = new String.fromCharCodes(data);
      return handleResponse(response.statusCode, responseBody);
    } finally {
      client.close(force: true);
    }
  }
}
