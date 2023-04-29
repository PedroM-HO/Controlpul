import 'package:controlpul/views/RegistroForm.dart';
import 'package:flutter/material.dart';
import 'package:controlpul/constantes.dart';
import 'package:controlpul/views/LoginView.dart';
import 'package:controlpul/views/HistoricoView.dart';
import 'package:controlpul/views/RegistroForm.dart';
import 'package:controlpul/views/PiscinasView.dart';

class InicialView extends StatefulWidget {
  const InicialView({Key? key}) : super(key: key);

  @override
  InicialViewState createState() => InicialViewState();
}

class InicialViewState extends State<InicialView> {

  int currentPageIndex = 0;

  final vistas = [
    LoginPage(),
    HistoricoView(),
    PiscinasView(),
  ];

  Widget? currentView;

  @override
  void initState() {
    currentView = vistas[currentPageIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
              currentPageIndex = index;
              currentView = vistas[currentPageIndex];
          });
        },
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.account_circle_rounded), label: "Login"),
          NavigationDestination(icon: Icon(Icons.abc), label: "Formulario"),
          NavigationDestination(icon: Icon(Icons.pool), label: "Piscinas"),

        ],

      ),
      body: Stack(children: [currentView!],),
    );
  }
}