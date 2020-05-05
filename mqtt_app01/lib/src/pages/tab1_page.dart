import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_app01/src/mqtt/data_connection_mqtt.dart';
import 'package:mqtt_app01/src/mqtt/manager_mqtt.dart';
import 'package:mqtt_app01/src/providers/mqttstate_model.dart';
import 'package:mqtt_app01/src/theme/tema.dart';
import 'package:provider/provider.dart';
 
 
class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();

}

class _Tab1PageState extends State<Tab1Page> {
  final String _titleBar = 'Cliente MQTT';

  // String _broker  = '192.168.1.101';
  // int _port = 1883;
  // String _username = 'moi';
  // String _password = 'moi';
  // String _clientId = 'flutter';

  @override
  Widget build(BuildContext context) {
    
    // Intancia de para saber el estado de la conexion
    final mqttState = Provider.of<MqttStateModel>(context);
    // Instancia de la clase singleton donde manejamos la conexión y otras funciones 
    final dataConnection = new DataConnectionMQTT();
    final managerMqtt = new ManagerMQTT(mqttState);    
    
    return Scaffold(      
      appBar: AppBar(
        title: Text(_titleBar),
        backgroundColor: miTema.accentColor,
      ),
      body: SafeArea (                    
          child: Container (
          
            //decoration: BoxDecoration(              
            //  color: Colors.cyan,
            //  borderRadius: BorderRadius.circular(10),    
            //),

            //width: double.infinity,
            //height: double.infinity,
            //height: MediaQuery.of(context).size.height,
            //width: MediaQuery.of(context).size.width,            
            
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            //color: Colors.cyan,
            //color: Color.fromRGBO(18, 18, 18, 0),
            child: Column (
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: <Widget>[
                // Icono que cambia de estado dependiendo de la conexón 
                Icon( mqttState.connectionState ? Icons.cloud_done : Icons.cloud_off,
                  //Icons.cloud_off,
                  
                  color: Colors.cyan,
                  size: 40.0,                  
                  //semanticLabel: 'Text to announce in accessibility modes',
                ), 
                Text(mqttState.connectionState ? 'Conectado': 'Desconectado' ),
                _inputBroker(dataConnection),
                SizedBox(height: 10.0,),
                _inputPort(dataConnection),
                SizedBox(height: 10.0,),
                _inputClientname(dataConnection),
                SizedBox(height: 10.0,),
                _inputUsername(dataConnection),
                SizedBox(height: 10.0,),
                _inputPassword(dataConnection),
                SizedBox(height: 30.0,),
                _buttonConnectDisconnect( mqttState.connectionState, managerMqtt)
              ],              
            ),
        ),         
      ),

      /*  
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon (mqttState.connectionState ? Icons.cloud_done : Icons.cloud_off,color: Colors.white,),        
        backgroundColor: miTema.accentColor,
        onPressed: (){            
            if (mqttState.connectionState == false ){
              managerMqtt.connectBroker();

            } else {              
              managerMqtt.disconnectBroker();
            }                                           
        }
      ),
      */

    );

  }

  Widget _inputBroker(DataConnectionMQTT dataConnection) {    
    
    return TextField(
      controller: TextEditingController()..text = dataConnection.broker,   
      //autofocus: true,
      decoration: InputDecoration(
       labelText: 'Broker',
       hintText: 'Ip o dirección del Broker'
      ),
      onChanged: (valor){
        setState(() {
          dataConnection.broker = valor;           
        });
      },
    );
  }

  Widget _inputPort(DataConnectionMQTT dataConnection) {        
    return TextField(
      controller: TextEditingController()..text = dataConnection.port.toString(),             
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
       labelText: 'Puerto',       
       hintText: 'Número de puerto',             
      ),
      onChanged: (valor){
        setState(() {
          dataConnection.port = int.parse(valor);          
        });
      },
    );
  }

    Widget _inputClientname(DataConnectionMQTT dataConnection) {      
      return TextField(          
        controller: TextEditingController()..text = dataConnection.clientId,   
        decoration: InputDecoration(
        labelText: 'Cliente Id',
        hintText: 'Nombre del cliente'
        ),
        onChanged: (valor){
          setState(() {            
            dataConnection.clientId = valor;
          });
        },
      );
    }

    Widget _inputUsername(DataConnectionMQTT dataConnection) {          
      return TextField(          
        controller: TextEditingController()..text = dataConnection.username,   
        decoration: InputDecoration(
        labelText: 'Usuario',
        hintText: 'Nombre del usuario'
        ),
        onChanged: (valor){
          setState(() {            
            dataConnection.username = valor;          
          });
        },
      );
    }


    Widget _inputPassword(DataConnectionMQTT dataConnection) {      
      return TextField(                
        controller: TextEditingController()..text = dataConnection.password,   
        obscureText: true,
        decoration: InputDecoration(
        labelText: 'Contraseña',
        hintText: 'Contraseña del usuario'
        ),
        onChanged: (valor){
          setState(() {
            dataConnection.password = valor;             
          });
        },
      );
    }

  Widget _buttonConnectDisconnect(bool mqttState, ManagerMQTT mgMQTT ) {
    return RaisedButton(
      child: Container(
        width: 140.0,
        height: 40.0,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: <Widget>[
            Text(mqttState ? 'Desconectar': 'Conectar'),
          ],
        ),

      ),
      color: miTema.accentColor,      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      onPressed: (){
        if (mqttState == false ){
          mgMQTT.connectBroker();
          //managerMqtt.connectBroker();

        } else {              
          mgMQTT.disconnectBroker();
          //managerMqtt.disconnectBroker();
        }                                          
      }
      
    );



    }
}