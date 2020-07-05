import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:rocktodo/common/common_config.dart';
import 'package:rocktodo/login/model/loginModel.dart';

import 'common/theme.dart';
import 'home/home_page.dart';
import 'login/login_page.dart';

void main() {
  CommonConfig.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
    return OKToast(
      child: new MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginModel(false),
          )
        ],
        child: MaterialApp(
          title: 'Rock Todo',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (context) {
              var loginModel = Provider.of<LoginModel>(context);
              if (loginModel.isLogin) {
                return Home();
              } else {
                return Login();
              }
            }
          },
        ),
      ),
    );
  }
}
