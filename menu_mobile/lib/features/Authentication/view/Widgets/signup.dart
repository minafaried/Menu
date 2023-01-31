import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:where/Common/Config/Palette.dart';
import 'package:where/features/Authentication/controller/userController.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final FocusNode _email = FocusNode();
  final FocusNode _pass = FocusNode();
  final FocusNode _save = FocusNode();
  bool _passwordInVisible = true;
  String addressUrl = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, model, child) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 0, left: 15, right: 30),
          width: 600,
          height: 400,
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
                      child: Text("SignUp",
                          style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 50,
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
                          hintText: "Full Name",
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                        ),
                        controller: name,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_email),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 50,
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
                          hintText: "Email",
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                        ),
                        controller: email,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_pass),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        focusNode: _pass,
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
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.black),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                        ),
                        controller: pass,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_save),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    model.userStatus == UserStatus.Loading
                        ? CircularProgressIndicator(
                            color: Color(0xff04bc70),
                          )
                        : Container(
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff04bc70),
                                    Color.fromARGB(255, 3, 166, 117)
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1, 0),
                                  tileMode: TileMode.clamp),
                            ),
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextButton(
                              focusNode: _save,
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                _save.unfocus();
                                model.SignUp(
                                  name.text,
                                  email.text,
                                  pass.text,
                                ).then((_) => {
                                      if (model.userStatus == UserStatus.Error)
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
                                          Navigator.pushReplacementNamed(
                                              context, '/home')
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
