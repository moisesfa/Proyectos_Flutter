import 'package:flutter/material.dart';
import 'package:mqtt_app01/src/mqtt/data_connection_mqtt.dart';
import 'package:mqtt_app01/src/mqtt/manager_mqtt.dart';
import 'package:mqtt_app01/src/providers/mqttstate_model.dart';
import 'package:mqtt_app01/src/theme/tema.dart'; 
import 'package:provider/provider.dart';
 
class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {

  final String _titleBar = 'Cliente MQTT';
  
  @override
  Widget build(BuildContext context) {
    
    // Intancia de para saber el estado de la conexion
    final mqttState = Provider.of<MqttStateModel>(context);
    // Instancia de la clase singleton donde manejamos la conexión y otras funciones 
    final managerMqtt = new ManagerMQTT(mqttState);
    final dataConnection = new DataConnectionMQTT();    
    
    //final dataConnection = new DataConnection();
    //dataConnection.username = 'hola';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleBar),
        backgroundColor: miTema.accentColor,
      ),
      resizeToAvoidBottomPadding: false,      
      body: SafeArea(            
              child: SingleChildScrollView(
                child: Column (
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[              
                  Container(          
                    //width: double.infinity,
                    //height: double.infinity,
                    // color: Colors.red,        
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      child: Column (
                        //mainAxisSize: MainAxisSize.min,
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
                          _inputTopic(dataConnection), 
                          //Text(topic),
                          SizedBox(height: 30.0,),                    
                          _buttonSubsNotsubs( mqttState.connectionState, managerMqtt, dataConnection),                
                        ],
                      )
                  ),
                  SizedBox(height: 10.0),
                  Text('Mensajes recibidos : ' + mqttState.receivedMsg.length.toString()),
                  SizedBox(height: 10.0),

                  Container(
                    //color: Colors.red,
                    height: 170.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: _crearLista(context, mqttState.receivedMsg)
                        )  
                      ],
                    ) ,
                    //child: _crearLista(context, mqttState.receivedMsg)
                  ) 

                  /*
                  Expanded(                
                    //color: Colors.red,
                    //height: double.infinity,                
                    child: _crearLista(context, mqttState.receivedMsg)
                    )
                  */
                ],
                
                
          ),
              ),
        ),         
      
    );
  }

  Widget _inputTopic(DataConnectionMQTT dataConnection) {

    return TextField(
      controller: TextEditingController()..text = dataConnection.topicsub,   
      //autofocus: true,
      decoration: InputDecoration(
       labelText: 'Topic',
       hintText: 'Topic al que suscribirse'
      ),
      onChanged: (valor){
        //setState(() {
          dataConnection.topicsub = valor;          
        //});
      },
    );
  }

  Widget _buttonSubsNotsubs(bool mqttState, ManagerMQTT mgMQTT, DataConnectionMQTT dataConnection) {
      return RaisedButton(
        child: Container(
          width: 140.0,
          height: 40.0,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,          
            children: <Widget>[
              Text(dataConnection.subStatus ? 'Desuscribirse': 'Suscribirse'),
            ],
          ),

        ),
        color: miTema.accentColor,      
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        onPressed: (){
          
          setState(() {

            if (mqttState == false ){
              // No esta conectado no me puedo suscribir 
              print(' No está conectado, no se puede suscribir');                      
            } else {              
              if (dataConnection.subStatus == false){
                print(' Está conectado, se puede suscribir al topic $dataConnection.topicsub');
                mgMQTT.subscribeToTopic(dataConnection.topicsub);
                dataConnection.subStatus = true;
              } else {
                print(' Está conectado, se puede desuscribir del topic $dataConnection.topicsub');
                mgMQTT.unsubscribeToTopic(dataConnection.topicsub);
                dataConnection.subStatus = false;
              }                       
            } 
            
          });                                          
        }
        
      );
  }

  Widget _crearLista(BuildContext context, List<String> listRec) {

    int length;
    setState(() {
      length  = listRec.length;  
    });
    
    return ListView.builder(
      //scrollDirection: Axis.vertical,
      //shrinkWrap: true,      
      //addAutomaticKeepAlives: true,
      //addRepaintBoundaries: true,
      
      //reverse: true,
      itemCount: length,
      itemBuilder: (context, int index){
        //listRec[index].split(' ');        
        List<String> paytopic = listRec[index].split(',');
        
        return ListTile( 
          leading: Icon(Icons.format_align_justify),       
          title: Text(paytopic[0]),
          subtitle: Text(paytopic[1]),          
        );
                

      },
      
      );


  }
  
}