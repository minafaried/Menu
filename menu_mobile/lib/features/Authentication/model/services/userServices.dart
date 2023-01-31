import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where/Common/Config/serverDomain.dart';

class UserServices {
  Domain domain = Domain();
  Future<Map<String, dynamic>?> logIn(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://${domain.serverName}:${domain.portNumber}/api/Users/logIn'));
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode != 200) {
        return null;
      }
      dynamic res = json.decode(await response.stream.bytesToString());
      return res;
    } catch (e) {
      print('error:' + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> SignUp(
      String name, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://${domain.serverName}:${domain.portNumber}/api/Users/signUp'));
    request.body = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      return null;
    }
    dynamic res = json.decode(await response.stream.bytesToString());
    if (res['error'] != '0') {
      return res;
    } else {
      print('error:' + res['message']);
      return null;
    }
  }
}
