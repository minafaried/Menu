import 'package:flutter/cupertino.dart';
import 'package:where/features/Authentication/model/entities/User.dart';
import 'package:where/features/Authentication/model/services/userServices.dart';

enum UserStatus { Loading, Error, Normal }

class UserController extends ChangeNotifier {
  late User? _user;
  late UserStatus userStatus = UserStatus.Normal;
  late String errorMessage;
  final UserServices _userServices = UserServices();
  User? get user {
    return _user;
  }

  Future<void> login(String email, String password) async {
    userStatus = UserStatus.Loading;
    notifyListeners();
    try {
      Map<String, dynamic>? resData =
          await _userServices.logIn(email, password);
      // print('data:' + resData.toString());

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("token", resData["token"]);
      if (resData == null) {
        userStatus = UserStatus.Error;
        errorMessage = "error.. try again";
        _user = null;
        notifyListeners();
        return;
      }
      _user = User.fromJson(resData);
      print('login successfully... hi ' + (_user!.name));
      userStatus = UserStatus.Normal;
      notifyListeners();
    } catch (e) {
      userStatus = UserStatus.Error;
      errorMessage = "error.. try again";
      _user = null;
      notifyListeners();
      return;
    }
  }

  Future<void> logout() async {
    _user = null;
    userStatus = UserStatus.Normal;
    print('Logout successfully');
  }

  Future SignUp(String name, String email, String password) async {
    userStatus = UserStatus.Loading;
    notifyListeners();
    Map<String, dynamic>? data =
        (await _userServices.SignUp(name, email, password)
            .catchError((onError) {
      userStatus = UserStatus.Error;
      errorMessage = "error.. try again";
      _user = null;
      notifyListeners();
    }));

    _user = User.fromJson(data!);
    print('login successfully... hi ' + (_user!.name));
    userStatus = UserStatus.Normal;
    notifyListeners();
  }
}
