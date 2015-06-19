library mandrill_api_server;

import 'dart:io' as io;
import 'dart:async' as async;
import 'package:mandrill_api/mandrill_api.dart';
export 'package:mandrill_api/mandrill_api.dart' show MANDRILL_OPTS;

///Extend the base API class to make HTTP requests using dart:io
class Mandrill extends APIBase {
  Mandrill(String apikey, [bool debug]) : super(apikey, debug);

  ///Make the appropriate call, returning a future that yields an API result
  async.Future request(Uri uri, Map headers, String body) {
    var client = new io.HttpClient();
    return client.postUrl(uri).then((request) {
      headers.forEach((k, v) => request.headers.set(k, v));
      request.contentLength = body.length;
      request.write(body);
      return request.close();
    }).then((response) {
      return response.expand((chunk) => chunk).toList().then((data) {
        body = new String.fromCharCodes(data);
        return handleResponse(response.statusCode, body);
      });
    });
  }
}
