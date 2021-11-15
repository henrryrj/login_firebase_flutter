import 'package:flutter/material.dart';

class LoginFromProvider extends ChangeNotifier {
  GlobalKey<FormState> keyDelSignin = new GlobalKey<FormState>();
  String email = "";
  String pass = "";
  bool _logueado = false;
  bool get estaLogueado => _logueado;
  set estaLogueado(bool valor) {
    this._logueado = valor;
    notifyListeners();
  }

  bool esValidadoElFrom() {
    print(keyDelSignin.currentState?.validate());
    print('$email - $pass');
    return keyDelSignin.currentState?.validate() ?? false;
  }
}
