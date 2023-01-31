import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:where/features/Authentication/controller/userController.dart';
import 'package:where/features/Home/controller/HomeController.dart';
import 'package:where/features/Home/model/entities/Place.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Common/Config/Palette.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCategoryPageState();
  }
}

class AddCategoryPageState extends State<AddCategoryPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController categoryName = TextEditingController();
  final FocusNode _save = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, model, child) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 100, left: 15, right: 30),
          width: 600,
          height: 250,
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
                        "Add Category",
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
                          hintText: "Category name",
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(
                            Icons.category,
                            color: Colors.black,
                          ),
                        ),
                        controller: categoryName,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_save),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                              onPressed: () {
                                _save.unfocus();
                                model.addCategory(categoryName.text).then((_) =>
                                    {
                                      if (model.homeStatus == UserStatus.Error)
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("error"),
                                                content:
                                                    Text(model.errorMessage),
                                                actions: <Widget>[
                                                  TextButton(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 70,
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Palette
                                                              .errorColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
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
                                                        Navigator.of(context)
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
      );
    });
  }
}
