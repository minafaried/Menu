import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'Common/Config/Palette.dart';
import 'Common/Config/Routing.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserController>(
        create: (BuildContext context) => UserController(),
        child: MaterialApp(
          title: 'Where',
          color: Palette.primaryColor1,
          theme: ThemeData(
            backgroundColor: Palette.primaryColor1,
          ),
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
