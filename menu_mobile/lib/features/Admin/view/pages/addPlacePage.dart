import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:where/Common/Config/Palette.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'package:where/features/Home/controller/HomeController.dart';
import 'package:where/features/Home/model/entities/Category.dart';
import 'package:where/features/googleMaps/view/pages/googleMaps.dart';

class AddPlacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddPlacePageState();
  }
}

class AddPlacePageState extends State<AddPlacePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController placeName = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  String location = "";
  String category = "";

  final FocusNode _save = FocusNode();

  late List<String>? images = [];
  bool _imageSelected = false;
  String _newPosition = '';
  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        images!.clear();
        selectedImages.forEach((element) {
          images!.add(element.path);
        });

        _imageSelected = true;
      });
      return;
    }
    _imageSelected = false;
  }

  @override
  void initState() {
    super.initState();
    category =
        Provider.of<HomeController>(context, listen: false).categories![0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, model, child) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100, left: 15, right: 30),
          width: 600,
          height: 450,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "Add Place",
                        style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        cursorWidth: 3,
                        cursorHeight: 25,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                          ),
                          focusColor: Colors.black,
                          hintText: "Place name",
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(
                            Icons.text_increase,
                            color: Colors.black,
                          ),
                        ),
                        controller: placeName,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_save),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.category_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 250,
                              child: DropdownButton<String>(
                                value: category,
                                items: model.categories!.map((Category value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id,
                                    child: Text(
                                      value.name,
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    category = value!;
                                  });
                                },
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/googleMap').then(
                            (value) => setState(
                              () {
                                location = GoogleMapsState.position;
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        label: location == ""
                            ? Text(
                                "add Location",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            : Text(
                                location,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () async {
                          await _getImage();
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        ),
                        label: _imageSelected
                            ? Text(
                                images!.length.toString() + " Selected",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              )
                            : Text(
                                "upload Images",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    model.homeStatus == HomeStatus.Loading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Container(
                            width: 170,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff04bc70),
                                    Color.fromARGB(255, 3, 166, 117)
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1, 0),
                                  tileMode: TileMode.clamp),
                            ),
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextButton(
                              focusNode: _save,
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onPressed: () async {
                                _save.unfocus();
                                model
                                    .addPlace(placeName.text, location,
                                        category, images!)
                                    .then((_) => {
                                          if (model.homeStatus ==
                                              UserStatus.Error)
                                            {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("error"),
                                                    content: Text(
                                                        model.errorMessage),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 70,
                                                            height: 34,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Palette
                                                                  .errorColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'okay',
                                                              style: TextStyle(
                                                                  color: Palette
                                                                      .white),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })
                                                    ],
                                                  );
                                                },
                                              )
                                            }
                                          else
                                            {
                                              Navigator.pop(context),
                                            }
                                        });
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    });
  }
}
