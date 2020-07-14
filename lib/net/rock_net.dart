import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:rocktodo/bean/common/base_response.dart';
import 'package:rocktodo/login/login_manager.dart';
import 'package:rocktodo/net/net_work_error.dart';

class RockNet {
  static const int DEFAULT_CONNECT_TIMEOUT = 10000;

  static const int DEFAULT_RECEIVE_TIMEOUT = 10000;

  factory RockNet() => _rockNet();

  static RockNet _instance;

  RockNet._() {
    //私有化构造
  }

  static RockNet _rockNet() {
    if (_instance == null) {
      _instance = RockNet._();
    }
    return _instance;
  }

  Dio _engine;

  Dio get engine {
    initEngineIfNot();
    return _engine;
  }

  initEngineIfNot() {
    if (_engine == null) {
      // 或者通过传递一个 `options`来创建dio实例
      _engine = Dio();
      _engine.options = BaseOptions();
      _engine.options.connectTimeout = DEFAULT_CONNECT_TIMEOUT;
      _engine.options.receiveTimeout = DEFAULT_RECEIVE_TIMEOUT;
      (_engine.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          //proxy all request
          return "PROXY 10.2.8.235:8888";
        };
      };
      _engine.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options)));
    }
  }

  void initConfig(
      {@required String domain, int connectTimeout, int receiveTimeout}) {
    if (domain == null) {
      domain = '';
    }
    if (connectTimeout == null || 0 <= connectTimeout) {
      connectTimeout = DEFAULT_CONNECT_TIMEOUT;
    }
    if (receiveTimeout == null || 0 <= receiveTimeout) {
      receiveTimeout = DEFAULT_RECEIVE_TIMEOUT;
    }
    engine.options.baseUrl = domain;
    engine.options.connectTimeout = connectTimeout;
    engine.options.receiveTimeout = receiveTimeout;
  }

  Future<T> get<T>({
    @required String path,
    Map<String, dynamic> params,
    int connectTimeout,
    int receiveTimeout,
  }) async {
    try {
      Response response = await engine.get(path, queryParameters: params);
      if (response != null) {
        return response.data;
      } else {
        return Future.error(NetWorkError(
            NetWorkError.CODE_NULL_RESPONSE, NetWorkError.MSG_NULL_RESPONSE));
      }
    } catch (e) {
      if (e is DioError) {
        return NetWorkError.dispatchEngineError(e);
      } else {
        return Future.error(
            NetWorkError(NetWorkError.CODE_UNKNOWN, NetWorkError.MSG_UNKNOWN),
            e);
      }
    }
  }

  Future<T> post<T>({
    @required String path,
    Map<String, dynamic> params,
    int connectTimeout,
    int receiveTimeout,
    bool token = true,
  }) async {
    try {
      Response response = await engine.post(
        path,
        data: json.encode(params),
        options: Options(headers: {"auth_token": true}),
      );
      if (response != null) {
        var result = jsonDecode(response.toString());
        BaseResponse baseResponse = BaseResponse.fromJson(result);
        if (baseResponse.statusCode == 0) {
          return baseResponse.data;
        } else {
          return Future.error(
              NetWorkError(baseResponse.statusCode, baseResponse.msg));
        }
      } else {
        return Future.error(NetWorkError(
            NetWorkError.CODE_NULL_RESPONSE, NetWorkError.MSG_NULL_RESPONSE));
      }
    } catch (e) {
      print(e);
      if (e is DioError) {
        return NetWorkError.dispatchEngineError(e);
      } else {
        return Future.error(
            NetWorkError(NetWorkError.CODE_UNKNOWN, NetWorkError.MSG_UNKNOWN),
            e);
      }
    }
  }

  requestInterceptor(RequestOptions options) {
    if (options.headers.containsKey("auth_token")) {
      //remove the auxiliary header
      options.headers.remove("auth_token");

      LoginManager loginManager = LoginManager();
      var authToken = '';
      if (loginManager.login) {
        authToken = loginManager.userInfo.token;
      }

      if (authToken.isNotEmpty) {
        options.headers.addAll({"Authorization": "Token $authToken"});
      }

      return options;
    }
  }
}
