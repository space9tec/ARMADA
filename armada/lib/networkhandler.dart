import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  String baseURL = "https://armada-server.glitch.me";

  Future<http.Response> get(String urlp) async {
    final storage = new FlutterSecureStorage();
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);

    String? token = await storage.read(key: "token");
    String cookie = 'jwt=$token';

    var response = await http.get(url, headers: {'Cookie': cookie});
    // if (response.statusCode == 200 || response.statusCode == 201) {
    return response;
    // }
  }

  Future<http.Response> post(String urlp, Map<String, String> body) async {
    urlp = formater(urlp);
    final storage = new FlutterSecureStorage();

    Uri url = Uri.parse(urlp);
    String? token = await storage.read(key: "token");
    String cookie = 'jwt=$token';

    if (token != null) {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Cookie': cookie},
        body: json.encode(body),
      );
      return response;
    } else {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      return response;
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    // }
  }

  String formater(String url) {
    return baseURL + url;
  }
}
