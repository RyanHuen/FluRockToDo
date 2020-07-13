class BaseResponse {
  dynamic data;
  int statusCode;
  String msg;

  BaseResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        statusCode = json['status_code'],
        msg = json['msg'];
}
