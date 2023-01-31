import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:where/features/Authentication/model/entities/User.dart';
import 'package:where/features/Authentication/model/services/userServices.dart';
import 'package:where/features/Home/model/entities/Category.dart';
import 'package:where/features/Home/model/entities/Place.dart';
import 'package:where/features/Home/model/services/categoryServices.dart';
import 'package:where/features/Home/model/services/placeServices.dart';

enum HomeStatus { Loading, Error, Normal }

class HomeController extends ChangeNotifier {
  late List<Place>? _places = [];
  late List<Place>? _filterdPlaces = [];
  late List<Category>? _categories = [];
  late HomeStatus homeStatus = HomeStatus.Normal;
  late String errorMessage;
  final PlaceServices _placeServices = PlaceServices();
  final CategoryServices _categoryServices = CategoryServices();
  List<Category>? get categories {
    return _categories;
  }

  List<Place>? get places {
    return _filterdPlaces;
  }

  Future<void> getCategories() async {
    homeStatus = HomeStatus.Loading;
    notifyListeners();
    try {
      List<dynamic> resData = await _categoryServices.getCategories();
      List<Category> categories = [];
      resData.forEach((element) {
        categories.add(Category.fromJson(element!));
      });
      _categories = categories;
      print('categories fetched successfully');
      homeStatus = HomeStatus.Normal;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.Error;
      errorMessage = "error.. try again";
      _places = [];
      notifyListeners();
      return;
    }
  }

  Future<void> getAllPlaces() async {
    homeStatus = HomeStatus.Loading;
    notifyListeners();
    try {
      List<dynamic> resData = await _placeServices.getAllPlaces();
      List<Place> places = [];
      resData.forEach((element) {
        places.add(Place.fromJson(element!));
      });
      _places = places;
      _filterdPlaces!.addAll(places);
      print('places fetched successfully');
      homeStatus = HomeStatus.Normal;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.Error;
      errorMessage = "error.. try again";
      _places = [];
      _filterdPlaces = [];
      notifyListeners();
      return;
    }
  }

  Future<void> addPlace(String name, String location, String categoryId,
      List<String> placeImages) async {
    homeStatus = HomeStatus.Loading;
    notifyListeners();
    try {
      print(placeImages[0]);
      Map<String, dynamic>? resData = await _placeServices.addPlace(
          name, location, categoryId, placeImages);
      if (resData == null) {
        homeStatus = HomeStatus.Error;
        errorMessage = "error.. try again";
        notifyListeners();
        return;
      }
      _places!.add(Place.fromJson(resData));
      _filterdPlaces!.clear();
      _filterdPlaces!.addAll(_places!);
      print('place added successfully');
      homeStatus = HomeStatus.Normal;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.Error;
      errorMessage = "error.. try again";
      notifyListeners();
      return;
    }
  }

  Future<void> addCategory(String categoryName) async {
    homeStatus = HomeStatus.Loading;
    notifyListeners();
    try {
      Map<String, dynamic>? resData =
          await _categoryServices.addCategory(categoryName);
      if (resData == null) {
        homeStatus = HomeStatus.Error;
        errorMessage = "error.. try again";
        notifyListeners();
        return;
      }
      _categories!.add(Category.fromJson(resData));
      print('category added successfully');
      homeStatus = HomeStatus.Normal;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.Error;
      errorMessage = "error.. try again";
      notifyListeners();
      return;
    }
  }

  Future<void> editUserRate(String userId, int rate, Place place) async {
    homeStatus = HomeStatus.Loading;
    int oldRate = 0;
    notifyListeners();
    try {
      Place refPlaceOrigin = _places!.firstWhere((e) => e == place);
      Place refPlaceFilterd = _filterdPlaces!.firstWhere((e) => e == place);
      int oldRate = 0;
      if (refPlaceOrigin.userRates.containsKey(userId)) {
        oldRate = refPlaceOrigin.userRates[userId]!;
      }
      refPlaceOrigin.userRates[userId] = rate;
      refPlaceFilterd.userRates[userId] = rate;
      notifyListeners();
      Map<String, dynamic>? resData =
          await _placeServices.editUserRate(refPlaceOrigin.id, userId, rate);
      if (resData == null) {
        refPlaceOrigin.userRates[userId] = oldRate;
        refPlaceFilterd.userRates[userId] = oldRate;
        homeStatus = HomeStatus.Error;
        errorMessage = "error.. try again";
      }
      print('place updated successfully');
      homeStatus = HomeStatus.Normal;
      notifyListeners();
    } catch (e) {
      homeStatus = HomeStatus.Error;
      errorMessage = "error.. try again";
      notifyListeners();
      return;
    }
  }

  void filterByCategory(String categoryId) {
    if (categoryId == "0") {
      _filterdPlaces!.clear();
      _filterdPlaces!.addAll(_places!);
    } else {
      _filterdPlaces = _places!
          .where((element) => element.category.id == categoryId)
          .toList();
    }
    notifyListeners();
  }
}
