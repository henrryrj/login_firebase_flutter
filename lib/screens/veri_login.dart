import 'package:encuesta_login_movil_flutter/Services/services.dart';
import 'package:encuesta_login_movil_flutter/screens/bienvenida_screen.dart';
import 'package:encuesta_login_movil_flutter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeriLogin extends StatelessWidget {
  const VeriLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UsuarioService>(context, listen: false);
    return Scaffold(
      body: Container(
          child: FutureBuilder(
        future: userService.redToden(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Espere');
          }
          if (snapshot.hasData == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => BienvenidaScreem(),
                    transitionDuration: Duration(seconds: 0),
                  ));
              // Navigator.pushReplacementNamed(context, '/');
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => Home(),
                    transitionDuration: Duration(seconds: 0),
                  ));
              // Navigator.pushReplacementNamed(context, '/');
            });
          }

          return Container();
        },
      )),
    );
  }
}
