import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rocktodo/common/common_config.dart';
import 'package:rocktodo/common/theme.dart';
import 'package:rocktodo/login/login_manager.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<Splash> {
  bool _login = false;
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'RockToDo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    color: appTheme.primaryColor,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  void _loadConfig() async {
    await CommonConfig.init();

    setState(() {
      LoginManager loginManager = LoginManager();
      _login = loginManager.login;
      _checked = true;
      var logger = Logger();
      logger.d('Splash: login status: ' + _login.toString());
      if (_checked) {
        if (_login) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    });
  }
}
