import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpUtils {
  String url;
  Map<String, String> headers;
  Map<String, dynamic> queryParams;
  String jsonBody;
  String _method = "GET";

  HttpUtils(
      {required this.url,
      this.queryParams = const <String, dynamic>{},
      this.headers = const <String, String>{},
      this.jsonBody = "{}"});

  http.Request _generateRequest() {
    if (queryParams.isNotEmpty) {
      String queryParamasStr = Uri(queryParameters: queryParams).query;
      url = "$url?$queryParamasStr";
    }
    http.Request request = http.Request(_method, Uri.parse(url));
    request.headers.addAll(headers);
    request.body = jsonBody;
    return request;
  }

  Future<HttpResponse<T>> get<T>() async {
    _method = "GET";
    HttpResponse<T> resp = HttpResponse<T>(500, null);
    http.Request request = _generateRequest();
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      resp = HttpResponse<T>(response.statusCode, response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error @get $e");
    }
    return resp;
  }

  Future<HttpResponse<T>> post<T>() async {
    _method = "POST";
    HttpResponse<T> resp = HttpResponse<T>(500, null);
    http.Request request = _generateRequest();
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      resp = HttpResponse<T>(response.statusCode, response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error @post $e");
    }
    return resp;
  }

  Future<HttpResponse<T>> put<T>() async {
    _method = "PUT";
    HttpResponse<T> resp = HttpResponse<T>(500, null);
    http.Request request = _generateRequest();
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      resp = HttpResponse<T>(response.statusCode, response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error @put $e");
    }
    return resp;
  }

  Future<HttpResponse<T>> patch<T>() async {
    _method = "PATCH";
    HttpResponse<T> resp = HttpResponse<T>(500, null);
    http.Request request = _generateRequest();
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      resp = HttpResponse<T>(response.statusCode, response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error @put $e");
    }
    return resp;
  }

  Future<HttpResponse<T>> delete<T>() async {
    _method = "DELETE";
    HttpResponse<T> resp = HttpResponse<T>(500, null);
    http.Request request = _generateRequest();
    try {
      http.Response response =
          await http.Response.fromStream(await request.send());
      resp = HttpResponse<T>(response.statusCode, response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error @put $e");
    }
    return resp;
  }
}

class HttpResponse<T> {
  late int statusCode;
  late T? body;

  HttpResponse(int statusCode, String? strbody) {
    statusCode = statusCode;
    body = null;
    if (strbody != null) {
      try {
        body = jsonDecode(strbody) as T;
      } catch (e) {
        // ignore: avoid_print
        print("Error @HttpResponse: $e");
      }
    }
  }
}
