import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where/Common/Config/Palette.dart';
import 'package:where/features/Authentication/view/Widgets/login.dart';
import 'package:where/features/Authentication/view/Widgets/signup.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  bool _login = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                "Wellcome",
                style: GoogleFonts.raleway(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            Center(
              child: Text(
                "Menus",
                style:
                    GoogleFonts.raleway(color: Color(0xff04bc70), fontSize: 30),
              ),
            ),
            _login ? LogIn() : SignUp(),
            Container(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _login = !_login;
                  });
                },
                child: Text(
                  _login ? "SignUp" : "LogIn",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
