import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:where/Common/Config/serverDomain.dart';

class PlaceServices {
  Domain domain = Domain();
  Future<List<dynamic>> getAllPlaces() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'Get',
          Uri.parse(
              'https://${domain.serverName}:${domain.portNumber}/api/Places/getAllPlaces'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      dynamic res = json.decode(await response.stream.bytesToString());
      return res;
    } catch (e) {
      print('error:' + e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>?> editUserRate(
      String placeId, String userId, int rate) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'Post',
          Uri.parse(
              'https://${domain.serverName}:${domain.portNumber}/api/Places/editUserRate?placeId=${placeId}'));
      request.body = json.encode({
        'userId': userId,
        'rate': rate,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      dynamic res = json.decode(await response.stream.bytesToString());
      return res;
    } catch (e) {
      print('error:' + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> addPlace(String name, String location,
      String categoryId, List<String> placeImages) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://${domain.serverName}:${domain.portNumber}/api/Places/addPlace'));
      request.fields.addAll(
          {'name': name, 'location': location, 'categoryId': categoryId});

      placeImages.forEach((element) async {
        request.files
            .add(await http.MultipartFile.fromPath('menuImages', element));
      });
      http.StreamedResponse response = await request.send();
      dynamic res = json.decode(await response.stream.bytesToString());
      print(res);
      return res;
    } catch (e) {
      print('PlaceServices error:' + e.toString());
      return null;
    }
  }
}
