// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:encuesta_login_movil_flutter/Utils/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DesignWidgets {
  //titulo custumisado

  static LinearGradient lineaGradiante(BuildContext context) {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).primaryColorLight,
          Theme.of(context).primaryColor
        ]);
  }

  static RichText titulo() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Encuestas',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white60),
            children: [
              TextSpan(
                  text: 'App',
                  style: TextStyle(fontSize: 30, color: Colors.white))
            ]));
  }

  static RichText tituloDark(context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Encuestas',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.grey),
            children: [
              TextSpan(
                  text: 'App',
                  style: TextStyle(
                      fontSize: 30, color: Theme.of(context).primaryColor))
            ]));
  }
}

//FORMA DE LOGIN
class Forma extends StatelessWidget {
  const Forma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: WaveClipperTwo(),
        child: Container(
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: DesignWidgets.lineaGradiante(context)
          ),
        ),
      ),
    );
  }
}

//BOTON_BACK
class MyBotton extends StatelessWidget {
  const MyBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
              Text(TextApp.BACK,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white))
            ],
          ),
        ));
  }
}