import 'dart:convert';

import 'package:rocktodo/bean/common/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  factory LoginManager() => _loginManager();

  static LoginManager _instance;

  LoginManager._();

  UserInfo userInfo;
  bool login;

  init() async {
    return await _initPrefs();
  }

  Future<bool> _initPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    login = prefs.getBool('login');
    print('prefs init login bool');
    if (login != null && login) {
      userInfo = UserInfo.fromJson(json.decode(prefs.getString('userJson')));
      print('userInfo from sp' + userInfo.toString());
    } else {
      login = false;
    }
    return login;
  }

  static _loginManager() {
    if (_instance == null) {
      _instance = LoginManager._();
    }
    return _instance;
  }

  void updateUserInfo(UserInfo userInfo) async {
    String userJson = json.encode(userInfo).toString();
    print('userJson Info: ' + userJson);
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('userJson', userJson);
    prefs.setBool('login', true);
  }
}
