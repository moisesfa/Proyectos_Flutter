import 'package:flutter/material.dart';
import 'package:mqtt_app01/src/mqtt/manager_mqtt.dart';
import 'package:mqtt_app01/src/providers/mqttstate_model.dart';
import 'package:mqtt_app01/src/theme/tema.dart';
import 'package:provider/provider.dart';
 
class Tab3Page extends StatefulWidget {

  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> {
  
  final String _titleBar = 'Cliente MQTT';
  String topic = '';
  String payload = '';
    
  @override
  Widget build(BuildContext context) {
    
    // Intancia de para saber el estado de la conexion
    final mqttState = Provider.of<MqttStateModel>(context);
    // Instancia de la clase singleton donde manejamos la conexión y otras funciones 
    final managerMqtt = new ManagerMQTT(mqttState);    
    
    //final dataConnection = new DataConnection();
    //dataConnection.username = 'hola';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleBar),
        backgroundColor: miTema.accentColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Container(
            
            //width: double.infinity,
            //height: double.infinity,
          
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
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
                  _inputTopic(),
                  _inputPayload(),
                  SizedBox(height: 30.0,),                    
                  _buttonPublish(managerMqtt), 
                ],
              )

          ),
        )
      )
    );
  }

  Widget _inputTopic() {

    return TextField(
      //controller: TextEditingController()..text = dataConnection.broker,   
      //autofocus: true,
      decoration: InputDecoration(
       labelText: 'Topic',
       hintText: 'Topic al que suscribirse'
      ),
      onChanged: (valor){
        setState(() {
          topic = valor;           
        });
      },
    );
  }

Widget _inputPayload() {

    return TextField(
      //controller: TextEditingController()..text = dataConnection.broker,   
      //autofocus: true,
      decoration: InputDecoration(
       labelText: 'Payload',
       hintText: 'Payload a enviar'
      ),
      onChanged: (valor){
        setState(() {
          payload = valor;           
        });
      },
    );
  }

  Widget _buttonPublish(ManagerMQTT mgMQTT) {
return RaisedButton(
        child: Container(
          width: 140.0,
          height: 40.0,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,          
            children: <Widget>[
              Text('Publicar'),
            ],
          ),

        ),
        color: miTema.accentColor,      
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        onPressed: (){
          
          setState(() {

            mgMQTT.publishMessageToTopic(topic, payload);
            
          });                                          
        }
        
      );

  }


}