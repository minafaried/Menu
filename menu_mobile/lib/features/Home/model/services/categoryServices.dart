import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where/Common/Config/serverDomain.dart';
import 'package:where/features/Home/model/entities/Category.dart';

class CategoryServices {
  Domain domain = Domain();
  Future<List<dynamic>> getCategories() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'Get',
          Uri.parse(
              'https://${domain.serverName}:${domain.portNumber}/api/Categories/getCategories'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      dynamic res = json.decode(await response.stream.bytesToString());
      return res;
    } catch (e) {
      print('error:' + e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>?> addCategory(String name) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://${domain.serverName}:${domain.portNumber}/api/Categories/addCategory'));
    request.body = json.encode({
      'name': name,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    dynamic res = json.decode(await response.stream.bytesToString());
    if (res['error'] != '0') {
      return res;
    } else {
      print('error:' + res['message']);
      return null;
    }
  }

  Future<Map<String, dynamic>?> editCategoty(Category category) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://${domain.serverName}:${domain.portNumber}/api/Categories/editCategoty'));
    request.body = json.encode({
      'id': category.id,
      'name': category.name,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    dynamic res = json.decode(await response.stream.bytesToString());
    if (res['error'] != '0') {
      return res;
    } else {
      print('error:' + res['message']);
      return null;
    }
  }
}
