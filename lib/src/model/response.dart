class Response {
  String _code;
  String _message;
  dynamic _data;
  bool _isSuccess;

  Response(this._isSuccess, this._code, this._message, this._data);

  set code(String code) {
    this._code = code;
  }

  set message(String message) {
    this._message = message;
  }

  set data(dynamic data) {
    this._data = data;
  }

  set isSuccess(bool isSucces) {
    this._isSuccess = isSucces;
  }

  String get code => this._code;
  String get message => this._message;
  dynamic get data => this._data;
  bool get isSuccess => this._isSuccess;
}
