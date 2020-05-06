
import 'package:flutter/material.dart';

class NavegacionModel with ChangeNotifier {

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  // getter - setter de pagina actual 
  int get paginaActual => this._paginaActual;

  set paginaActual (int valor) {
    this._paginaActual = valor;
    
    // Para cambiar de pagina 
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    
    notifyListeners();
  }

  // getter de pageController
  PageController get pageController => this._pageController; 

}