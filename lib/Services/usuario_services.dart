import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:encuesta_login_movil_flutter/models/usuario_models.dart';

class UsuarioService extends ChangeNotifier {
  final String _baseUrlBd = 'encuestasapp-e3fc3-default-rtdb.firebaseio.com';
  final String _baseUrlAuth = 'identitytoolkit.googleapis.com';
  final String _fireToken = 'AIzaSyDJFtxAHu5A3we_Y7zaJi6tJc1Ca1yOgTw';
  final DatabaseReference _dbUsuario = FirebaseDatabase.instance.reference();
  Usuario usuario = new Usuario();
  final storage = new FlutterSecureStorage();
  bool isLoading = true;
  //FIREBASE_AUTH
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UsuarioService() {
    //this.cargarUsuarios();
  }
  Future<String?> crearUsuario(Usuario usuarioNuevo) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: usuarioNuevo.email, password: usuarioNuevo.pass);
      String id = userCredential.user!.uid;
      usuarioNuevo.id;
      _dbUsuario.child('usuario').child(id).set(usuarioNuevo.toMap());
      if (id.isNotEmpty) {
        await storage.write(key: 'tokenUsuario', value: id);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'La cuenta ya existe para ese correo electrónico.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String pass) async {
    final Map<String, dynamic> loginData = {'email': email, 'password': pass};
    final url = Uri.https(
        _baseUrlAuth, '/v1/accounts:signInWithPassword', {'key': _fireToken});
    final resp = await http.post(url, body: json.encode(loginData));
    final Map<String, dynamic> resultado = json.decode(resp.body);
    String? id = resultado['idToken'];
    if (id != null) {
      //_dbUsuario.child('usuario').child(resultado['localId']).get().then((value) {final xd = Usuario.deDynamicUser(value.value);});
      final url = Uri.https(_baseUrlBd, 'usuario/${resultado['localId']}.json');
      final resp = await http.get(url);
      final Map<String, dynamic> usuariosMap = json.decode(resp.body);
      usuario = Usuario.deDynamicUser(usuariosMap);
      await storage.write(key: 'tokenUsuario', value: resultado['idToken']);
    } else {
      if (resultado['error']['message'] == 'EMAIL_NOT_FOUND') {
        return 'El correo no esta registrado';
      } else if (resultado['error']['message'] == 'INVALID_PASSWORD') {
        return 'Contraseña incorrecta';
      }
    }
  }

  Future logout() async {
    await storage.delete(key: 'tokenUsuario');
  }

  Future<String> redToden() async {
    return await storage.read(key: 'tokenUsuario') ?? '';
  }
}
