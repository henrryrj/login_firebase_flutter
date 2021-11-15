import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyLoginBotton extends StatelessWidget {
  String titulo;
  Color colorText;
  Color colorFondo;
  Widget navegacion;
  MyLoginBotton(
      {required this.titulo,
      required this.colorText,
      required this.colorFondo,
      required this.navegacion});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, bottom: 25),
      width: double.infinity,
      child: ElevatedButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.all(15.0),
              backgroundColor: colorFondo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => (navegacion)));
          },
          child: Text(
            titulo,
            style: TextStyle(
                color: colorText,
                letterSpacing: 1.5,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
