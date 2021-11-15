import 'package:encuesta_login_movil_flutter/Services/usuario_services.dart';
import 'package:encuesta_login_movil_flutter/screens/screns.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SigninScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Forma(),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: altura * .15),
                      child: DesignWidgets.tituloDark(context)),
                  Padding(
                    padding: EdgeInsets.only(top: altura * .05),
                    child: ChangeNotifierProvider(
                        create: (_) => LoginFromProvider(),
                        child: _EmailPass()),
                  ),
                  //_resetPass(),
                  _divisor(),
                  _signupLabel(context)
                ],
              ),
            ),
          ),
          Positioned(top: altura * .025, child: MyBotton())
        ],
      )),
    );
  }

  Widget _divisor() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ),
            Text(TextApp.OR),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            )
          ],
        ));
  }

  Widget _signupLabel(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupScreem())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TextApp.SIN_CUENTA,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              TextApp.SIGNUP,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class _EmailPass extends StatefulWidget {
  @override
  State<_EmailPass> createState() => _EmailPassState();
}

class _EmailPassState extends State<_EmailPass> {
  bool _visibilidad = true;

  @override
  Widget build(BuildContext context) {
    final signinForm = Provider.of<LoginFromProvider>(context);
    return Form(
      key: signinForm.keyDelSignin,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextApp.EMAIL,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              onChanged: (value) => signinForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                if (regExp.hasMatch(value ?? "")) {
                  return null;
                } else {
                  return "Ingrese un correo valido";
                }
              },
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Text(
              TextApp.PASS,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _visibilidad,
              decoration: InputDecoration(
                  suffixIcon: CupertinoButton(
                      child: Icon(
                          _visibilidad
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        _visibilidad = !_visibilidad;
                        setState(() {});
                      }),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              onChanged: (value) => signinForm.pass = value,
              validator: (value) {
                if (value != null && value.length > 6) {
                  return null;
                } else {
                  return "Ingrese su contraseña";
                }
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 50.0, bottom: 25),
              width: double.infinity,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  onPressed: signinForm.estaLogueado
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final userService = Provider.of<UsuarioService>(
                              context,
                              listen: false);
                          if (!signinForm.esValidadoElFrom()) return;
                          final String? respuesta = await userService.login(
                              signinForm.email, signinForm.pass);
                          if (respuesta == null) {
                            signinForm.estaLogueado = true;
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                      title: Text('Lo siento. '),
                                      content: Text(respuesta),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text('Aceptar',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    letterSpacing: 1.5,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ));
                            signinForm.estaLogueado = false;
                          }
                        },
                  child: Text(
                    signinForm.estaLogueado ? "Cargando..." : TextApp.SIGNIN,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
 /*Widget _resetPass() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Text(
          TextApp.RESET_PASS,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ));
  }*/