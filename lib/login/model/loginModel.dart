class LoginModel {
  bool _isLogin;

  LoginModel(this._isLogin){
    print('bbbbb');
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }
}
