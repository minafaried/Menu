import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'package:where/features/Home/controller/HomeController.dart';
import 'package:where/features/Home/model/entities/Place.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final Place place;
  final HomeController homeController;
  final UserController userController;
  const Details(
      {Key? key,
      required this.place,
      required this.homeController,
      required this.userController})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DetailsState();
  }
}

class DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    int totalRate = widget.place.userRates.length;
    int sum = 0;
    widget.place.userRates.forEach(
      (key, value) => sum += widget.place.userRates[key]!,
    );
    double rate = totalRate == 0 ? 0 : sum / totalRate;

    int currentRating = 0;
    if (widget.place.userRates.containsKey(widget.userController.user!.id)) {
      currentRating = widget.place.userRates[widget.userController.user!.id]!;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 330,
              height: 250,
              child: Image.network(
                widget.place.menuImages[0],
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                widget.place.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 5),
            _buildStars(currentRating, widget.homeController,
                widget.userController.user!.id),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text("Total Place Rate:  "),
                Text(
                  (rate == 0 ? "not rated yet" : rate).toString(),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text("Place Location:  "),
                TextButton.icon(
                  onPressed: () async {
                    String googleUrl =
                        'https://www.google.com/maps/search/?api=1&query=${widget.place.location}';
                    // launch(googleUrl);
                    if (!await launchUrl(Uri.parse(googleUrl))) {
                      throw 'Could not launch ';
                    }
                  },
                  label: Text(
                    "Location",
                    style: TextStyle(
                      color: Color(0xff04bc70),
                    ),
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: Color(0xff04bc70),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "Place's Images",
                style: GoogleFonts.raleway(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildGridForImages(),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildGridForImages() {
    List<Widget> cards = List.generate(
        widget.place.menuImages.length - 1,
        (int index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/showImage",
                    arguments: widget.place.menuImages[index + 1]);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 20),
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                    color: Color(0xff04bc70),
                  )),
                ),
                width: 200,
                height: 150,
                child: Image.network(
                  widget.place.menuImages[index + 1],
                  fit: BoxFit.contain,
                ),
              ),
            ));

    return Row(children: cards);
  }

  Widget _buildRatingStar(int index, int currentRating) {
    if (index < currentRating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }
  }

  Widget _buildStars(
      int currentRating, HomeController homeController, String userId) {
    final stars = List<Widget>.generate(5, (index) {
      return InkWell(
        child: _buildRatingStar(index, currentRating),
        onTap: () {
          print(index);
          setState(() {
            homeController.editUserRate(userId, index + 1, widget.place);
          });
        },
      );
    });

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: stars);
  }
}
