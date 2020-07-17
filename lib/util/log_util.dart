import 'package:logger/logger.dart';
import 'package:rocktodo/common/common_config.dart';

class LogUtil {
  static Logger _logger = Logger();

  static bool isLoggable() {
    return !CommonConfig.inProduction;
  }

  static void d(String msg) {
    _logger.d(msg);
  }
}
