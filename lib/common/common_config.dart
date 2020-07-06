import 'package:rocktodo/bean/common/token.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/net/rock_net.dart';

class CommonConfig {
  static var csrfToken = '';

  static Future init() async {
    await onAppForegroundPreTask();
  }

  static onAppForegroundPreTask() async {
    RockNet rockNet = initNetWorkComponent();
    LoginManager loginManager = LoginManager();
    bool login = await loginManager.init();
    print('already login : start to Home'+login.toString());
    await executeTokenFetch(rockNet);
  }

  static Future executeTokenFetch(RockNet rockNet) async {
    await rockNet.get(path: 'rest_api/get_token', params: {}).then((value) {
      if (value is CSRFToken) {
        csrfToken = value.token;
      }
    });
  }

  static RockNet initNetWorkComponent() {
    RockNet rockNet = RockNet();
    rockNet.initConfig(domain: 'http://localhost:80/');
    return rockNet;
  }
}
