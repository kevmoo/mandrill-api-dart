library mandrill_api_browser;

import 'dart:async' as async;
import 'dart:html' as html;

import 'mandrill_api.dart';
export 'mandrill_api.dart' show MANDRILL_OPTS;

///Extend the base API class to make HTTP requests using dart:html
class Mandrill extends APIBase {
  Mandrill(String apikey, [bool debug]) : super(apikey, debug);

  ///Make the appropriate call, returning a future that yields an API result
  async.Future request(Uri uri, Map headers, String body) {
    headers.remove('User-Agent');
    return html.HttpRequest
        .request(uri.toString(),
            method: 'POST',
            responseType: 'application/json',
            mimeType: headers['Content-Type'],
            requestHeaders: headers,
            sendData: body)
        .then((request) {
      return handleResponse(request.status, request.responseText);
    }).catchError((err) {
      if (err is html.ProgressEvent) {
        return handleResponse(err.target.status, err.target.responseText);
      } else {
        throw err;
      }
    });
  }
}
