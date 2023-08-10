import 'dart:convert';

import 'package:armada/services/tokenManager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class NetworkHandler {
  String baseURL = "https://armada-server.glitch.me";

  Future get(String urlp) async {
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);
    String? token = await TokenManager().getToken();

    String cookie = 'jwt=$token';

    try {
      var response = await http.get(url, headers: {'Cookie': cookie});
      return response;
    } catch (e) {
      throw NetworkException('No internet connection');
    }
  }

  Future gett(String urlp) async {
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);
    var response = await http.get(url);
    return response;
  }

  Future<http.Response> post(
      String urlp, Map<String, String> body, String userr,
      {XFile? imageFile}) async {
    urlp = formater(urlp);

    Uri url = Uri.parse(urlp);
    String? token = await TokenManager().getToken();

    String cookie = 'jwt=$token';
    if (token != null) {
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        Uint8List decodedBytes = base64Decode(base64Image);
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Cookie'] = cookie;
        request.fields[userr] = jsonString;

        print("imagego");

        request.files.add(http.MultipartFile.fromBytes('image',
            decodedBytes, // use the decoded bytes instead of the base64 string
            filename: 'image.jpg'));

        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      } else {
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Cookie'] = cookie;
        request.fields[userr] = jsonString;

        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      }
    } else {
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        Uint8List decodedBytes = base64Decode(base64Image);

        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.fields[userr] = jsonString;

        request.files.add(http.MultipartFile.fromBytes('image',
            decodedBytes, // use the decoded bytes instead of the base64 string
            filename: 'image.jpg'));
        http.StreamedResponse response = await request.send();

        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      } else {
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.fields[userr] = jsonString;

        http.StreamedResponse response = await request.send();

        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      }
    }
  }

  Future<http.Response> postt(String urlp, Map<String, String> body) async {
    urlp = formater(urlp);

    Uri url = Uri.parse(urlp);
    String? token = await TokenManager().getToken();
    String cookie = 'jwt=$token';

    if (token != null) {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Cookie': cookie},
        body: json.encode(body),
      );
      return response;
    } else {
      // var request = http.MultipartRequest('POST', url);
      // String jsonString = json.encode(body);
      // request.fields['userData'] = jsonString;
      // request.fields['image'] = "";
      // http.StreamedResponse response = await request.send();
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      // var responseData = await response.stream.transform(utf8.decoder).join();

      // // return the response in http.Response format
      // return http.Response(responseData, response.statusCode);
      // return response;
      // if (response.statusCode == 200) {
      //   // Convert response to string
      //   // String responseString = await response.stream.bytesToString();
      //   // return responseString;
      //   return response;
      // } else {
      //   throw Exception('Error sending data.');
      // }
      return response;
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    // }
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    endpoint = formater(endpoint);

    Uri url = Uri.parse(endpoint);
    String? token = await TokenManager().getToken();
    String cookie = 'jwt=$token';

    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json', 'Cookie': cookie},
      body: json.encode(data),
    );
    return response;
    // var request = http.MultipartRequest('PUT', url);
    // // String jsonString = json.encode(data);
    // request.headers['Content-Type'] = 'application/json';
    // request.headers['Cookie'] = cookie;
    // var uri = Uri.parse(baseUrl + endpoint);
    // var request = http.MultipartRequest("PUT", uri);

    // for (var key in data.keys) {
    //   if (data[key] is File) {
    //     var file = await http.MultipartFile.fromPath(key, data[key].path);
    //     request.files.add(file);
    //   } else {
    //     request.fields[key] = data[key];
    //   }
    // }

    // var response = await request.send();
    // return http.Response.fromStream(response);
  }

  Future<http.Response> putt(String endpoint) async {
    endpoint = formater(endpoint);

    Uri url = Uri.parse(endpoint);
    String? token = await TokenManager().getToken();
    String cookie = 'jwt=$token';
    // var url = Uri.parse(baseUrl + endpoint);
    var response = await http.put(
      url,
      headers: {'Cookie': cookie},
      // body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    endpoint = formater(endpoint);
    Uri url = Uri.parse(endpoint);

    String? token = await TokenManager().getToken();
    String cookie = 'jwt=$token';
    // var url = Uri.parse(baseUrl + endpoint);
    var response = await http.delete(
      url,
      headers: {'Cookie': cookie},
      // body: jsonEncode(data),
    );
    return response;
  }

  String formater(String url) {
    return baseURL + url;
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
