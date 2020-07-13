import 'package:logger/logger.dart';
import 'package:rocktodo/bean/common/token.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/net/rock_net.dart';

class CommonConfig {
  static var csrfToken = '';
  static bool login = false;
  static const bool inProduction = const bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    await onAppForegroundPreTask();
  }

  static onAppForegroundPreTask() async {
    RockNet rockNet = initNetWorkComponent();
    LoginManager loginManager = LoginManager();
    login = await loginManager.init();
    var logger = Logger();
    logger.d('CommonConfig: login status: ' + login.toString());
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
    rockNet.initConfig(domain: 'http://10.2.8.235:80/');
    return rockNet;
  }
}
