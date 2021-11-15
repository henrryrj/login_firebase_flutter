import 'package:encuesta_login_movil_flutter/Utils/TextApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputs extends StatelessWidget {
  String titulo;
  bool isPass;
  TextInputType tipo;
  String? validacion;
  bool boton;
  MyInputs(
      {this.titulo = "",
      this.isPass = false,
      this.tipo = TextInputType.text,
      this.validacion,
      this.boton = false});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            TextFormField(
              keyboardType: tipo,
              obscureText: isPass,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                if (titulo == TextApp.EMAIL) {
                  if (regExp.hasMatch(value ?? "")) {
                    return null;
                  } else {
                    return validacion;
                  }
                }
                if (titulo == TextApp.PASS) {
                  if (value != null && value.length > 4) {
                    return null;
                  } else {
                    return validacion;
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
