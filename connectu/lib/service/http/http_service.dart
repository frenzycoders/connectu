import 'package:http/http.dart';

abstract class HttpService {
  void init();

  Future<Response> postRequest(String url, var headers, var body);
  Future<Response> getRequest(String url, var headers, var body);
  Future<Response> patchRequest(String url, var headers, var body);
}
