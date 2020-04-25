import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ttn_app01/src/pages/tab1_page.dart';
import 'package:ttn_app01/src/pages/tab2_page.dart';
import 'package:ttn_app01/src/providers/navegacion_provider.dart';

class TabsPage extends StatelessWidget {
  
  // Para recibir el argumento del nombre del dispositivo 
  final String deviceName;
  TabsPage (this.deviceName);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new NavegacionProvider(),
        child: Scaffold(
          body: _Paginas(deviceName),
          bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // Obetenemos la instacia del provider 
    final navegacionProvider = Provider.of<NavegacionProvider>(context);

    return BottomNavigationBar(
      currentIndex: navegacionProvider.paginaActual,       // Aqui estoy escuchando el valor de la propiedad
      onTap: (i) => navegacionProvider.paginaActual = i,   // Aquí estoy cambiando el valor de la propiedad
      items: [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.database), title: Text('Datos')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.chartBar), title: Text('Gráficos')),
      ]
    );
  }

}



class _Paginas extends StatelessWidget {
  
  final String device;
  _Paginas(this.device);
  
  @override
  Widget build(BuildContext context) {
    
    // Obetenemos la instacia del provider 
    final navegacionModel = Provider.of<NavegacionProvider>(context);

    return PageView(
      //physics: BouncingScrollPhysics(),      
      physics: NeverScrollableScrollPhysics(),      
      controller: navegacionModel.pageController, // Aquí escuchamos el estado del PageController
      children: <Widget>[                  
        Tab1Page(device),
        Tab2Page()
        // Container(
        //   color: Colors.red,
        // ),
        // Container(
        //   color: Colors.red,
        // ),

      ],

    );
  }
}

