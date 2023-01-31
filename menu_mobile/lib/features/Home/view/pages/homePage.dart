import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:where/Common/Config/Routing.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'package:where/features/Home/controller/HomeController.dart';
import 'package:where/features/Home/model/entities/Place.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getCategories();
      Provider.of<HomeController>(context, listen: false).getAllPlaces();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Provider.of<UserController>(context);
    return Consumer<HomeController>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Menus",
              style: GoogleFonts.raleway(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              PopupMenuButton<String>(
                initialValue: "null",
                color: Colors.white,
                itemBuilder: (context) => _buildMenu(model, userController),
                offset: Offset(0, 50),
                onSelected: (String item) {
                  if (item == "logout") {
                    userController.logout().then((value) =>
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false));
                  } else if (item == "addCategory") {
                    Navigator.pushNamed(context, "/addCategory",
                        arguments: model);
                  } else if (item == "addPlace") {
                    Navigator.pushNamed(context, "/addPlace", arguments: model);
                  }
                },
              ),
            ],
            actionsIconTheme: IconThemeData(color: Color(0xff04bc70)),
          ),
          body: Column(
            children: [
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  "Categories",
                  style: GoogleFonts.raleway(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildGridCardsForCategories(model),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(color: Colors.black),
              Align(
                alignment: Alignment(-0.9, 0.0),
                child: Text(
                  "Places",
                  style: GoogleFonts.raleway(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: _buildGridCardsForPlaces(model, userController),
              )
            ],
          ));
    });
  }

  Row _buildGridCardsForCategories(HomeController model) {
    List<Widget> cards = List.generate(model.categories!.length, (int index) {
      return InkWell(
        onTap: () {
          setState(() {
            model.filterByCategory(model.categories![index].id);
            _selectedIndex = index + 1;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(left: 7.0, right: 7.0),
          decoration: BoxDecoration(
            color:
                _selectedIndex == index + 1 ? Color(0xff04bc70) : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 165, 165, 165),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: 100,
          height: 25,
          child: Center(
            child: Text(
              model.categories![index].name,
              style: GoogleFonts.raleway(
                  color:
                      _selectedIndex == index + 1 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
    cards.insert(
      0,
      InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = 0;
            model.filterByCategory("0");
          });
        },
        child: Container(
          width: 100,
          height: 25,
          decoration: BoxDecoration(
            color: _selectedIndex == 0 ? Color(0xff04bc70) : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 165, 165, 165),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              "All",
              style: GoogleFonts.raleway(
                  color: _selectedIndex == 0 ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
    return Row(
      children: cards,
    );
  }

  GridView _buildGridCardsForPlaces(
      HomeController model, UserController userController) {
    List<Widget> cards = List.generate(model.places!.length, (int index) {
      int totalRate = model.places![index].userRates.length;
      int sum = 0;
      model.places![index].userRates.forEach(
        (key, value) => sum += model.places![index].userRates[key]!,
      );
      double rate = totalRate == 0 ? 0 : sum / totalRate;

      int currentRating = 0;
      if (model.places![index].userRates.containsKey(userController.user!.id)) {
        currentRating =
            model.places![index].userRates[userController.user!.id]!;
      }
      return Stack(clipBehavior: Clip.none, children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
                offset: Offset(4, 8),
              ),
            ],
          ),
          child: Card(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      DetailsArguments detailsArguments = DetailsArguments(
                          model.places![index], model, userController);
                      Navigator.pushNamed(context, '/details',
                          arguments: detailsArguments);
                    },
                    child: Container(
                      width: 170,
                      height: 120,
                      child: Image.network(
                        model.places![index].menuImages[0],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.7, 0.0),
                  child: Text(
                    model.places![index].name,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildStars(currentRating, model, model.places![index],
                    userController.user!.id),
              ],
            ),
          ),
        ),
        Positioned(
          top: -21,
          right: -10,
          child: rate != 0
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Color(0xff04bc70),
                      size: 50,
                    ),
                    Text(
                      rate.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container(),
        )
      ]);
    });

    return GridView.count(
      crossAxisCount: 2,
      children: cards,
    );
  }

  Widget _buildRatingStar(int index, int currentRating) {
    if (index < currentRating) {
      return Icon(Icons.star, color: Colors.amber[700]);
    } else {
      return Icon(Icons.star_border_outlined);
    }
  }

  Widget _buildStars(int currentRating, HomeController homeController,
      Place place, String userId) {
    final stars = List<Widget>.generate(5, (index) {
      return InkWell(
        child: _buildRatingStar(index, currentRating),
        onTap: () {
          print(index);
          setState(() {
            homeController.editUserRate(userId, index + 1, place);
          });
        },
      );
    });

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: stars);
  }

  List<PopupMenuItem<String>> _buildMenu(
      HomeController homeController, UserController userController) {
    List<PopupMenuItem<String>> popupMenuItems = [];
    popupMenuItems.add(PopupMenuItem(
      value: "logout",
      child: Row(
        children: const [
          Icon(
            Icons.exit_to_app,
            color: Color(0xff04bc70),
          ),
          SizedBox(
            width: 5,
          ),
          Text("Logout")
        ],
      ),
    ));
    if (userController.user!.email == "admin@admin.com") {
      popupMenuItems.add(PopupMenuItem(
        value: "addCategory",
        child: Row(
          children: const [
            Icon(Icons.category, color: Color(0xff04bc70)),
            SizedBox(
              width: 5,
            ),
            Text("add Category")
          ],
        ),
      ));
      popupMenuItems.add(PopupMenuItem(
        value: "addPlace",
        child: Row(
          children: const [
            Icon(
              Icons.place,
              color: Color(0xff04bc70),
            ),
            SizedBox(
              width: 5,
            ),
            Text("add Place")
          ],
        ),
      ));
    }

    return popupMenuItems;
  }
}
