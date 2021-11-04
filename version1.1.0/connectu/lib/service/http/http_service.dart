import 'package:connectu/service/http/http_file.dart';
import 'package:connectu/service/http/multipart_body.dart';
import 'package:connectu/service/http/multipart_headers.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  void init();
  Future<http.Response> postRequest(
      String url, Map<String, String> headers, Map<String, String> body);
  Future<http.Response> getRequest(
      String url, Map<String, String> headers, Map<String, String> body);
  Future<http.Response> patchRequest(
      String url, Map<String, String> headers, Map<String, String> body);
  Future<http.Response> maltiPartedRequest(String url, List<HttpFile> files,
      List<MultiPartHeader> headers, List<MultipartBody> body);
}
