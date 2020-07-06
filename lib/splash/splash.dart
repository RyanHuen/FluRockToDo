import 'package:flutter/cupertino.dart';
import 'package:rocktodo/common/common_config.dart';
import 'package:rocktodo/login/login_manager.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<Splash> {
  bool login;

  @override
  Widget build(BuildContext context) {
    print('return builde');
    return Container(
      child: Text('欢迎页面'),
    );
  }

  @override
  void initState() {
    print('gogogog');
    _loadConfig();
  }

  void _loadConfig() async {
    await CommonConfig.init();

    setState(() {
      LoginManager loginManager = LoginManager();
      login = loginManager.login;
      if(login){
        print('已登录 去首页');
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        print('没登录，去登陆');
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}
