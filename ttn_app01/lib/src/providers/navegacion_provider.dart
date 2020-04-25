import 'package:flutter/material.dart';


// El provider necesita un modelo con esta estructura 
// Clase para poder cambiar la navegación a traves de un provider 
class NavegacionProvider with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = new PageController();
  
  // getter de _paginaActual
  int get paginaActual => this._paginaActual;
  // setter de _paginaActual
  set paginaActual(int valor){
    this._paginaActual = valor;
    // Cambio el estado del pageController al cambiar de valor
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    // Cuando cambie el valor notifico a todos los widgets que esten pendientes 
    notifyListeners();
  }
  //getter del PageController 
  PageController get pageController => this._pageController;


}
