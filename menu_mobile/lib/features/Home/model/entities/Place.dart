import 'package:where/features/Home/model/entities/Category.dart';
import 'dart:convert';

class Place {
  String id;
  String name;
  String location;
  List<String> menuImages;
  Category category;
  Map<String, int> userRates;

  Place(
      {required this.id,
      required this.name,
      required this.location,
      required this.menuImages,
      required this.category,
      required this.userRates});

  factory Place.fromJson(Map<String, dynamic> jsondata) {
    List<String> menuImagesdata = [];
    jsondata["menuImages"].forEach((element) {
      menuImagesdata.add(element.toString());
    });
    Map<String, int> userRatesdata = {};
    jsondata["userRates"].forEach((key, value) {
      userRatesdata[key] = int.parse(value.toString());
    });
    return Place(
        id: jsondata["id"] ?? '',
        name: jsondata["name"] ?? '',
        location: jsondata["location"],
        menuImages: menuImagesdata,
        category: Category.fromJson(jsondata["category"]),
        userRates: userRatesdata);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
        "menuImages": menuImages,
        "category": category,
        "userRates": userRates
      };
}
