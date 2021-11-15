// ignore_for_file: prefer_const_constructors
import 'package:encuesta_login_movil_flutter/screens/screns.dart';
import 'package:encuesta_login_movil_flutter/services/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UsuarioService())],
        child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Encuestas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff00838f),
        primaryColorDark: Color(0xff005662),
        primaryColorLight: Color(0xff4fb3bf),
      ),
      initialRoute: 'veriLogin',
      routes: {
        '/': (_) => BienvenidaScreem(),
        'home': (_) => Home(),
        'signin': (_) => SigninScreem(),
        'signup': (_) => SignupScreem(),
        'veriLogin': (_) => VeriLogin()
      },
    );
  }
}
