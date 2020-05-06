import 'dart:async';

import 'package:mqtt_app01/src/mqtt/data_connection_mqtt.dart';
import 'package:mqtt_app01/src/providers/mqttstate_model.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;


class ManagerMQTT {

  // Clase con el patron singleton, se llama desde el tab1 y al modificar el estado de la conexión  
  // no quiero que se cree una instancia nueva 
  static final ManagerMQTT _instance = ManagerMQTT._internal();
  
  factory ManagerMQTT(MqttStateModel currentState){
      _instance._currentState = currentState;
     return _instance;
  } 
  
  ManagerMQTT._internal() {
    // iniciar cosas dentro de esto
  }

  final dataConnectionMqtt = new DataConnectionMQTT();
  MqttStateModel _currentState; 
  //final String topic = 'prueba'; 
  //mqtt.MqttClient _client;
    
  mqtt.MqttClient _mqttClient;
  mqtt.MqttConnectionState mqttConnectionState;
  StreamSubscription streamSubscription;
  final List<String> mqttResponse = new List();

  
  // Función que crea un cliente e intenta la conexión TCP con el broker 
  void connectBroker() async {
    /*
    Primero cree un cliente, el cliente se construye con un nombre de broke, identificador de cliente y puerto si es necesario. 
    El identificador de cliente (ID de cliente corto) es un identificador de cada cliente MQTT que se conecta a un broker MQTT. 
    Como el identificador de la palabra ya sugiere, debería ser único por broker.

    El broker lo utiliza para identificar al cliente y el estado actual del cliente. Si no necesita un estado retenido 
    por el broker, en MQTT 3.1.1 puede establecer un ClientId vacío, lo que da como resultado una conexión sin ningún estado.

    Una condición es que el indicador de conexión de sesión limpia sea verdadero; de lo contrario, la conexión será rechazada.

    El identificador del cliente puede tener una longitud máxima de 23 caracteres. Si no se especifica un puerto, 
    se utiliza el puerto estándar de 1883.

    Si desea utilizar websockets en lugar de TCP, consulte a continuación.    
    */

    _mqttClient = mqtt.MqttClient(dataConnectionMqtt.broker,dataConnectionMqtt.clientId);
    _mqttClient.port = dataConnectionMqtt.port;;

    /*
    Una URL websocket debe comenzar con ws: // o wss: // o Dart lanzará una excepción, consulte a su agente websocket MQTT 
    para obtener más detalles.
    Para usar websockets agregue las siguientes líneas:
    client.useWebSocket = true;
    cliente.puerto = 80; (o cualquiera que sea su puerto WS)

    Tenga en cuenta que no establezca el indicador seguro si está utilizando wss, 
    los indicadores seguros son solo para sockets TCP.

    Configure el inicio de sesión si es necesario, el valor predeterminado es apagado
    mqttClient.logging (on: true);

    Si tiene la intención de utilizar un valor de mantener vivo en su mensaje de conexión que no sea el predeterminado (60s), debe configurarlo aquí
    */
    _mqttClient.keepAlivePeriod = 30;

    /// Agregar la devolución de llamada de desconexión no solicitada
    _mqttClient.onDisconnected = onDisconnected;

    /*
    Cree un mensaje de conexión para usar o use el predeterminado. El predeterminado establece el identificador del cliente, 
    cualquier nombre de usuario / contraseña suministrados, el intervalo de mantenimiento predeterminado (60 s) 
    y la sesión limpia, un ejemplo de uno específico a continuación.
    */
    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(dataConnectionMqtt.clientId)
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    _mqttClient.connectionMessage = connMess;

    /*
    Conecte el cliente, cualquier error aquí se comunica mediante la aparición de la excepción correspondiente. 
    enga en cuenta que, en algunas circunstancias, el broker simplemente nos desconectará, 
    consulte las especificaciones sobre esto, sin embargo, nunca enviaremos mensajes con formato incorrecto.    
    */
    try {
      await _mqttClient.connect(dataConnectionMqtt.username, dataConnectionMqtt.password);
    } catch (e) {
      print(e);
      _mqttClient.disconnect();
    }

    // Comprueba si estamos conectados     
    if (_mqttClient.connectionStatus.state == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] connected');
      print('Estado de la conexión: ' + _mqttClient.connectionStatus.state.toString());
      mqttConnectionState = _mqttClient.connectionStatus.state;      
      // Actualizamos el estado de la conexión en el provider
      _currentState.connectionState = true;
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${_mqttClient.connectionStatus.state}');
      _mqttClient.disconnect();
      print('Cliente desconectado');      
    }

    // El cliente tiene un objeto notificador de cambio (vea la clase Observable) que luego escuchamos 
    // para recibir notificaciones de actualizaciones publicadas para cada topic suscrito.
    streamSubscription = _mqttClient.updates.listen(_onMessage);

    //_subscribeToTopic("contador");

  }

  // La devolución de llamada de desconexión no solicitada
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_mqttClient.connectionStatus.returnCode == mqtt.MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    // Actualizamos el estado de la conexión en el provider  
    _currentState.connectionState = false;    
  }

  void subscribeToTopic(String topic) {
    if (mqttConnectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to ${topic.trim()}');
      _mqttClient.subscribe(topic, mqtt.MqttQos.exactlyOnce);       
    }
  }

  void unsubscribeToTopic(String topic) {
    if (mqttConnectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Unsubscribing to ${topic.trim()}');
      _mqttClient.unsubscribe(topic);
      
      // Borramos el conetenido de la lista 
      this.mqttResponse.clear();      
      _currentState.receivedMsg = this.mqttResponse;

             
    }
  }

  void publishMessageToTopic(String topic, String payload) {
    if (mqttConnectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Publish to ${topic.trim()} message $payload');
      
      final mqtt.MqttClientPayloadBuilder builder = mqtt.MqttClientPayloadBuilder();
      builder.addString(payload);

      _mqttClient.publishMessage(topic, mqtt.MqttQos.exactlyOnce, builder.payload, retain: false);
      
    }
  }  

  // Funcion que recibe los mensajes publicados en un topic 
  void _onMessage(List<mqtt.MqttReceivedMessage> event) {

    print(event.length);
    final mqtt.MqttPublishMessage recMess1 =
    event[0].payload as mqtt.MqttPublishMessage;

    final String message1 =
    mqtt.MqttPublishPayload.bytesToStringAsString(recMess1.payload.message);

    /*
    Lo anterior puede parecer un poco complicado para los usuarios que solo están interesados en la carga útil, 
    sin embargo, algunos usuarios pueden estar interesados en el mensaje de publicación recibido, 
    no nos limitemos hasta que el paquete haya estado en libertad por un tiempo.
    La carga útil es un búfer de bytes, esto será específico para el topic
    */    
    print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- $message1 -->');
    print(_mqttClient.connectionStatus.state);
    print("[MQTT client] message with topic: ${event[0].topic} ");
    print("[MQTT client] message with payload: $message1");

    //this.mqttResponse.clear();
    //this.mqttResponse.add('Message with payload: $message1');
    this.mqttResponse.add('Payload is $message1,Topic is ${event[0].topic}');
    _currentState.receivedMsg = this.mqttResponse;
    
  }

  // Desconexión del Broker 
  void disconnectBroker() {    
    if (mqttConnectionState == mqtt.MqttConnectionState.connected) {
      print('Client conectado');
    }
    if (_mqttClient != null ){
      _mqttClient.disconnect();
      print('Cliente desconectado');
    } else {
      print('No se pudo desconectar el cliente');
    }       
  }


}