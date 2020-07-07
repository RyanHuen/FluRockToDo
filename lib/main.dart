import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/login/model/loginModel.dart';
import 'package:rocktodo/splash/splash.dart';

import 'common/theme.dart';
import 'home/home_page.dart';
import 'login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: new MultiProvider(
        providers: [
          Provider(create: (context) => LoginModel(checkLogin())),
        ],
        child: MaterialApp(
          title: 'Rock Todo',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => Splash(),
            '/login': (context) => Login(),
            '/home': (context) => Home()
          },
        ),
      ),
    );
  }

  bool checkLogin() {
    LoginManager loginManager = LoginManager();
    if (loginManager.login == null) {
      print('login get null');
      return false;
    }
    print('login get value');
    return loginManager.login;
  }
}
