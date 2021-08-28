import 'package:connectu/service/http/http_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class HttpImpl implements HttpService {
  var _client;
  var _baseUrl;

  @override
  void init() {
    _client = RetryClient(http.Client());
    _baseUrl = 'http://localhost:3000/';
  }

  @override
  Future<http.Response> getRequest(String url, headers, body) async {
    http.Response response;
    try {
      response = await _client.post(Uri.parse(_baseUrl + url), body, headers);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  @override
  Future<http.Response> postRequest(String url, headers, body) async {
    http.Response response;
    try {
      response = await _client.post(Uri.parse(_baseUrl + url), body, headers);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  @override
  Future<http.Response> patchRequest(String url, var headers, var body) async {
    http.Response response;
    try {
      response = await _client.patch(Uri.parse(_baseUrl + url), body, headers);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
