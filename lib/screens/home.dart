import 'package:encuesta_login_movil_flutter/Services/services.dart';
import 'package:encuesta_login_movil_flutter/Widgets/Design/DesignWidget.dart';
import 'package:encuesta_login_movil_flutter/screens/perfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Encuestas',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
    Perfil()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UsuarioService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: DesignWidgets.titulo(),
        actions: [
          IconButton(
              onPressed: () {
                userService.logout();
                Navigator.pushReplacementNamed(context, 'signin');
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).primaryColorLight,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_outlined),
            label: 'Encuestas',
            backgroundColor: Theme.of(context).primaryColorLight,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'Encuestador',
            backgroundColor: Theme.of(context).primaryColorLight,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Mi Perfil',
            backgroundColor: Theme.of(context).primaryColorLight,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
