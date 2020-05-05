import 'package:flutter/material.dart';
import 'package:mqtt_app01/src/pages/tab1_page.dart';
import 'package:mqtt_app01/src/pages/tab2_page.dart';
import 'package:mqtt_app01/src/pages/tab3_page.dart';
import 'package:mqtt_app01/src/providers/navegation_model.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => new NavegacionModel(),      
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Paginas extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    
    // Intancia de mi navegacionModel
    final navegacionModel = Provider.of<NavegacionModel>(context);
     
    return PageView(
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        Tab3Page()
      ],
    );
  }
}

class _Navegacion extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    // Intancia de mi navegacionModel
    final navegacionModel = Provider.of<NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.cloud), title: Text('Broker')),
        BottomNavigationBarItem(icon: Icon(Icons.format_align_justify), title: Text('Subscribe')),
        BottomNavigationBarItem(icon: Icon(Icons.edit), title: Text('Publish')),
      ]
    );
  }

}