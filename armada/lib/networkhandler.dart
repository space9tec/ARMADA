import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHandler {
  String baseURL = "https://";

  Future get(String urlp) async {
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
  }

  Future<dynamic> post(String urlp, Map<String, String> body) async {
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);

    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    }
  }

  String formater(String url) {
    return baseURL + url;
  }
}
