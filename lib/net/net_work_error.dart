import 'package:dio/dio.dart';

class NetWorkError {
  static const int CODE_NULL_RESPONSE = -1;
  static const int CODE_UNKNOWN = -2;

  static const String MSG_NULL_RESPONSE = "服务端错误，没有获取到数据";
  static const String MSG_UNKNOWN = "未知系统异常";

  ///未知错误
  static const String UNKNOWN = "UNKNOWN";

  ///解析错误
  static const String PARSE_ERROR = "PARSE_ERROR";

  ///网络错误
  static const String NETWORK_ERROR = "NETWORK_ERROR";

  ///协议错误
  static const String HTTP_ERROR = "HTTP_ERROR";

  ///证书错误
  static const String SSL_ERROR = "SSL_ERROR";

  ///连接超时
  static const String CONNECT_TIMEOUT = "CONNECT_TIMEOUT";

  ///响应超时
  static const String RECEIVE_TIMEOUT = "RECEIVE_TIMEOUT";

  ///发送超时
  static const String SEND_TIMEOUT = "SEND_TIMEOUT";

  ///网络请求取消
  static const String CANCEL = "CANCEL";

  int statusCode;
  String message;

  NetWorkError(this.statusCode, this.message);

  static dispatchEngineError(DioError dioError) {
    var message = dioError.message;
    var statusCode = dioError.type.index;
    switch (dioError.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.SEND_TIMEOUT:
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RESPONSE:
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.CANCEL:
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.DEFAULT:
        message = "网络异常，请稍后重试！";
        break;
    }
    return NetWorkError(statusCode, message);
  }
}
