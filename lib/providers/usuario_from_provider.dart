import 'package:encuesta_login_movil_flutter/models/usuario_models.dart';
import 'package:flutter/material.dart';

class UsuarioFromProvider extends ChangeNotifier {
  GlobalKey<FormState> keyDelUsuario = new GlobalKey<FormState>();
  Usuario user;
  UsuarioFromProvider(this.user);

  bool _registrado = false;
  bool get estaRegistrado => _registrado;
  set estaRegistrado(bool valor) {
    this._registrado = valor;
    notifyListeners();
  }

  bool esValidadoElFrom() {
    print(user.toMap());
    return keyDelUsuario.currentState?.validate() ?? false;
  }
}
