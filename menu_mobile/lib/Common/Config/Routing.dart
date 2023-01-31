import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where/features/Admin/view/pages/addPlacePage.dart';
import 'package:where/features/Admin/view/pages/addCategoryPage.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'package:where/features/Authentication/view/pages/authPage.dart';
import 'package:where/features/Details/view/Widgets/ShowImage.dart';
import 'package:where/features/Details/view/pages/detailsPage.dart';
import 'package:where/features/Home/controller/HomeController.dart';
import 'package:where/features/Home/model/entities/Place.dart';
import 'package:where/features/Home/view/pages/homePage.dart';
import 'package:where/features/googleMaps/view/pages/googleMaps.dart';

class DetailsArguments {
  final Place place;
  final HomeController homeController;
  final UserController userController;

  DetailsArguments(this.place, this.homeController, this.userController);
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthPage());
      case '/home':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<HomeController>(
            create: (BuildContext context) => HomeController(),
            child: HomePage(),
          ),
        );
      case '/details':
        DetailsArguments argument = arguments as DetailsArguments;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<HomeController>(
            create: (BuildContext context) => HomeController(),
            child: Details(
              place: arguments.place,
              homeController: argument.homeController,
              userController: argument.userController,
            ),
          ),
        );
      case '/showImage':
        return MaterialPageRoute(
          builder: (_) => ShowImage(
            imagePath: arguments as String,
          ),
        );
      case '/addCategory':
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<HomeController>.value(
              value: arguments as HomeController,
              child: AddCategoryPage(),
            );
          },
        );
      case '/addPlace':
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<HomeController>.value(
              value: arguments as HomeController,
              child: AddPlacePage(),
            );
          },
        );
      case '/googleMap':
        return MaterialPageRoute(builder: (_) => GoogleMaps());
      default:
        return MaterialPageRoute(builder: (_) => AuthPage());
    }
  }
}
