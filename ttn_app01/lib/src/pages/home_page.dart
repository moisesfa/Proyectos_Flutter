import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttn_app01/src/services/ttn_service.dart';
import 'package:ttn_app01/src/theme/tema.dart';
import 'package:ttn_app01/src/widgets/lista_devices.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  // Necestiamos obtener los dispositivos de ttn 
  //final ttnService = Provider.of<TtnService>(context);
  final devices = Provider.of<TtnService>(context).devices;
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivos Aplicación TTN'),
        backgroundColor: miTema.accentColor,
      ),
      body: (devices.length == 0)
          ? Center(child: CircularProgressIndicator())
          : ListaDevices(devices)
    );
  }
}