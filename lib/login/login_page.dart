import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rocktodo/bean/common/user_info.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/net/rock_net.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWidgetState();
  }
}

class _LoginWidgetState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('欢迎使用Rock Todo'),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 50.0,
            right: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '邮箱:',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '请输入邮箱',
                ),
                controller: _emailController,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '密码:',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '请输入密码',
                ),
                controller: _passwordController,
                obscureText: true,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      String username = _emailController.text;
                      String password = _passwordController.text;
                      if (username.isEmpty) {
                        showToast("请输入用户名");
                        return;
                      }
                      if (password.isEmpty) {
                        showToast("请输入密码");
                        return;
                      }
                      RockNet rockNet = RockNet();
                      rockNet.post(path: 'rest_api/api_auth/', params: {
                        'username': username,
                        'password': password
                      }).then((value) {
                        UserInfo userInfo = UserInfo.fromJson(value);
                        if (userInfo == null) {
                          showToast("登录失败");
                        } else {
                          LoginManager loginManager = LoginManager();
                          loginManager.updateUserInfo(userInfo);
                          showToast("登陆成功");
                        }
                      }).catchError((e) {
                        showToast("登录失败");
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
