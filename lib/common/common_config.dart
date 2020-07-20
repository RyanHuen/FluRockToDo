import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:rocktodo/bean/common/token.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/net/rock_net.dart';

class CommonConfig {
  static var domain = 'https://ryanhuen.tech/';
  static var proxy_domain = '10.2.8.243';
  static var csrfToken = '';
  static bool login = false;
  static String signPem = '';
  static const bool inProduction =
      const bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    await onAppForegroundPreTask();
  }

  static Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/sign.key');
  }

  static onAppForegroundPreTask() async {
    signPem = await loadAsset();
    RockNet rockNet = initNetWorkComponent();
    LoginManager loginManager = LoginManager();
    login = await loginManager.init();
    var logger = Logger();
    if (!CommonConfig.inProduction) {
      logger.d('CommonConfig: login status: ' + login.toString());
    }
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
    rockNet.initConfig(domain: domain);
    return rockNet;
  }
}
