class LoginModel {
  bool _isLogin;

  LoginModel(this._isLogin);

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }
}
