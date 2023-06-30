import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class NetworkHandler {
  String baseURL = "https://armada-server.glitch.me";

  Future get(String urlp) async {
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

  Future gett(String urlp) async {
    urlp = formater(urlp);
    Uri url = Uri.parse(urlp);

    var response = await http.get(url);
    // if (response.statusCode == 200 || response.statusCode == 201) {
    return response;
    // }
  }

  // static const XFile imageFile = XFile("default_image.jpg");
  Future<http.Response> post(
      String urlp, Map<String, String> body, String userr,
      {XFile? imageFile}) async {
    urlp = formater(urlp);
    final storage = new FlutterSecureStorage();

    Uri url = Uri.parse(urlp);
    String? token = await storage.read(key: "token");
    String cookie = 'jwt=$token';
// {String greeting  'Hello'}
    if (token != null) {
      // var response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json', 'Cookie': cookie},
      //   body: json.encode(body),
      // );
      // return response;
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        Uint8List decodedBytes = base64Decode(base64Image);
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Cookie'] = cookie;
        request.fields[userr] = jsonString;
        // request.fields['image'] = imageFile as String;
        print("imagego");
        // request.fields['image'] = base64Image;

        request.files.add(http.MultipartFile.fromBytes(
            // modify this line to use MultipartFile.fromBytes instead of request.fields['image']
            'image',
            decodedBytes, // use the decoded bytes instead of the base64 string
            filename: 'image.jpg'));

        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      } else {
        // List<int> imageBytes = await imageFile.readAsBytes();
        // String base64Image = base64Encode(imageBytes);
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Cookie'] = cookie;
        request.fields[userr] = jsonString;
        // request.fields['image'] = imageFile as String;
        // request.fields['image'] = base64Image;
        http.StreamedResponse response = await request.send();
        var responseData = await response.stream.transform(utf8.decoder).join();
        return http.Response(responseData, response.statusCode);
      }

      // var response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: {userr: json.encode(body)},
      // );

      // return the response in http.Response format
    } else {
      // var imageFile = XFile('<IMAGE_PATH>');
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        Uint8List decodedBytes = base64Decode(base64Image);

        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.fields[userr] = jsonString;
        // request.fields['image'] = "";
        // request.fields['image'] = base64Image;
        request.files.add(http.MultipartFile.fromBytes(
            // modify this line to use MultipartFile.fromBytes instead of request.fields['image']
            'image',
            decodedBytes, // use the decoded bytes instead of the base64 string
            filename: 'image.jpg'));
        http.StreamedResponse response = await request.send();
        // var response = await http.post(
        //   url,
        //   headers: {'Content-Type': 'application/json'},
        //   body: {userr: json.encode(body)},
        // );
        var responseData = await response.stream.transform(utf8.decoder).join();

        // return the response in http.Response format
        return http.Response(responseData, response.statusCode);
        // return response;
        // if (response.statusCode == 200) {
        //   // Convert response to string
        //   // String responseString = await response.stream.bytesToString();
        //   // return responseString;
        //   return response;
        // } else {
        //   throw Exception('Error sending data.');
        // }
        // return response;
      } else {
        //  List<int> imageBytes = await imageFile.readAsBytes();
        // String base64Image = base64Encode(imageBytes);
        var request = http.MultipartRequest('POST', url);
        String jsonString = json.encode(body);
        request.fields[userr] = jsonString;
        // request.fields['image'] = "";
        // request.fields['image'] = base64Image;
        http.StreamedResponse response = await request.send();
        // var response = await http.post(
        //   url,
        //   headers: {'Content-Type': 'application/json'},
        //   body: {userr: json.encode(body)},
        // );
        var responseData = await response.stream.transform(utf8.decoder).join();

        // return the response in http.Response format
        return http.Response(responseData, response.statusCode);
        // return response;
        // if (response.statusCode == 200) {
        //   // Convert response to string
        //   // String responseString = await response.stream.bytesToString();
        //   // return responseString;
        //   return response;
        // } else {
        //   throw Exception('Error sending data.');
        // }
        // return response;
      }
    }

    // if (response.statusCode == 200 || response.statusCode == 201) {
    // }
  }

  Future<http.Response> postt(String urlp, Map<String, String> body) async {
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
    final storage = new FlutterSecureStorage();

    Uri url = Uri.parse(endpoint);
    String? token = await storage.read(key: "token");
    String cookie = 'jwt=$token';
    var request = http.MultipartRequest('PUT', url);
    // String jsonString = json.encode(data);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Cookie'] = cookie;
    // var uri = Uri.parse(baseUrl + endpoint);
    // var request = http.MultipartRequest("PUT", uri);

    for (var key in data.keys) {
      if (data[key] is File) {
        var file = await http.MultipartFile.fromPath(key, data[key].path);
        request.files.add(file);
      } else {
        request.fields[key] = data[key];
      }
    }

    var response = await request.send();
    return http.Response.fromStream(response);
  }

  Future<http.Response> putt(String endpoint) async {
    endpoint = formater(endpoint);
    final storage = new FlutterSecureStorage();

    Uri url = Uri.parse(endpoint);
    String? token = await storage.read(key: "token");
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
    final storage = new FlutterSecureStorage();
    endpoint = formater(endpoint);
    Uri url = Uri.parse(endpoint);

    String? token = await storage.read(key: "token");
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
