import 'package:encuesta_login_movil_flutter/screens/screns.dart';
import 'package:flutter/material.dart';

class BienvenidaScreem extends StatefulWidget {
  BienvenidaScreem({Key? key}) : super(key: key);

  @override
  _BienvenidaScreem createState() => _BienvenidaScreem();
}

class _BienvenidaScreem extends State<BienvenidaScreem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(gradient: DesignWidgets.lineaGradiante(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DesignWidgets.titulo(),
          MyLoginBotton(
              titulo: TextApp.SIGNIN,
              colorText: Theme.of(context).primaryColor,
              colorFondo: Colors.white,
              navegacion: SigninScreem()),
          _signupBoton(context)
        ],
      ),
    ))));
  }

  Widget _signupBoton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
          style: TextButton.styleFrom(
              side: BorderSide(color: Colors.white),
              shadowColor: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => (SignupScreem()))),
          child: Text(
            TextApp.SIGNUP,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )),
    );
  }
}
