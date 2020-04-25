import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ttn_app01/src/models/ttndatadevice_model.dart';
import 'package:ttn_app01/src/services/ttn_service.dart';
import 'package:ttn_app01/src/theme/tema.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatelessWidget {

  // Para recibir el argumento del nombre del dispositivo 
  final String deviceName;
  Tab1Page (this.deviceName);

  @override
  Widget build(BuildContext context) {

    //final ttnServiceDataDevice = Provider.of<TtnService>(context).ttnDataDevice;
    //final ttnServiceDataDevice = Provider.of<TtnService>(context).ttnDataDevice;
    //print(ttnServiceDataDevice);
    final ttnDataDevice = Provider.of<TtnService>(context).ttnDataDevice;                                

    final int numberCards = ttnDataDevice.length;
    print(' Numero de cards Tab1:  $numberCards');

    if (ttnDataDevice.length == 0) {
      return Scaffold(
          appBar: AppBar(
          title: Text('Dispositivos'),
          backgroundColor: miTema.accentColor,
        ),
        body: Center(child: CircularProgressIndicator())  
      );  
    } else {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(deviceName),            
            _crearCards(ttnDataDevice)            
          ]
        ),      
      );                        
    }
    // ? return Center(child: CircularProgressIndicator());
    // : //ListaDevices(devices)

    // return Scaffold(
    //     body: CustomScrollView(
    //       slivers: <Widget>[
    //         _crearAppBar(deviceName),
            
    //         _crearCards(ttnDataDevice)            
    //       ]
    //     ),      
    //   );                        
      
      
      /*
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        }
        ), 
      */   
  }

  Widget _crearAppBar(String deviceName) {
    
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: miTema.accentColor,      
      expandedHeight: 180.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(deviceName),         
      ),
    );
  }


}

Widget _crearCards (List<TtnDataDevice> ttnDataDevice){

  return SliverList(            
      delegate: new SliverChildBuilderDelegate((context, index) {
        return  Container(                              
          padding: EdgeInsets.symmetric(horizontal:40.0),
          height: 150,
          width: double.maxFinite,    
          child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Fecha : '+ttnDataDevice[index].time.toString().substring(0,10),
                                style: TextStyle( fontWeight: FontWeight.bold)),
                          SizedBox(width: 20.0),
                          Text('Hora : '+ttnDataDevice[index].time.toString().substring(11,19),
                                style: TextStyle( fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height:20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.carBattery),
                          SizedBox(width: 10.0),
                          Text(ttnDataDevice[index].bateria.toString() + ' V  '),
                          SizedBox(width: 40.0),
                          Icon(FontAwesomeIcons.thermometerHalf),
                          SizedBox(width: 10.0),
                          Text(ttnDataDevice[index].temperatura.toString()+ ' ºC '),
                        ],
                      ),  
                      SizedBox(height:20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.compress),
                          SizedBox(width: 10.0),
                          Text(ttnDataDevice[index].presion.toString()+ ' hPa'),                          
                          SizedBox(width: 25.0),
                          Icon(FontAwesomeIcons.tint),
                          SizedBox(width: 10.0),
                          Text(ttnDataDevice[index].humedad.toString() + ' %  '),                                                                            
                        ],
                      ),  
                      //Text('Batería : '+ttnDataDevice[index].bateria.toString()),
                      //Text('Temperatura : '+ttnDataDevice[index].temperatura.toString()),  
                      //Text('Humedad : '+ttnDataDevice[index].humedad.toString()),
                      //Text('Presión : '+ttnDataDevice[index].presion.toString()),    
                    ],
                  ),
                ),              
        );
      },
      childCount: ttnDataDevice.length,
      )
    );
}

class _Navegacion extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // Obetenemos la instacia del provider 
    //final navegacionProvider = Provider.of<NavegacionProvider>(context);

    return BottomNavigationBar(
      currentIndex: 0,       // Aqui estoy escuchando el valor de la propiedad
      onTap: (i) => {},   // Aquí estoy cambiando el valor de la propiedad
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.data_usage), title: Text('Datos')),
        BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), title: Text('Graficos')),
      ]

      );
  }

}
