import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ttn_app01/src/pages/tabs_page.dart';
import 'package:ttn_app01/src/services/ttn_service.dart';
import 'package:ttn_app01/src/theme/tema.dart';

class ListaDevices extends StatelessWidget {
  
  // Paramentro que vamos a recibir 
  final List<String> devices;
  const ListaDevices(this.devices);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(            
      itemCount: this.devices.length,      
      itemBuilder: (BuildContext context, int index) {      
      return _Device(name: this.devices[index], index: index,);
     },
    );
  }
}

class _Device extends StatelessWidget {
  
  final String name;
  final int index;

  const _Device({
    @required this.name, 
    @required this.index
    });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column (
        children: <Widget>[
          Container(          
            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
            child: Row(            
              children: <Widget>[
                FaIcon(FontAwesomeIcons.database),
                SizedBox(width: 20.0),
                Text('${index+1}.  ', style: TextStyle(color: miTema.accentColor, fontSize: 20.0, fontWeight: FontWeight.w700)),
                Text('$name', style: TextStyle(fontSize: 20.0),)
              ], 
            ),                    
          ),
          Divider(),
        ],              
      ),
      onTap: (){ 
          final ttnServiceDevice = Provider.of<TtnService>(context, listen: false);          
          // LLamada http a los datos de ese dispositivo 
          ttnServiceDevice.selectedDevice = name;          
          print('$name');
          final route = MaterialPageRoute(
            //builder: (context) => DataDevicePage(name)
            builder: (context) => TabsPage(name)
            );
          Navigator.push(context, route);          
          },
    );
  }
}