import 'package:flutter/material.dart';
import 'package:mqtt_app01/src/pages/tabs_page.dart';
import 'package:mqtt_app01/src/providers/mqttstate_model.dart';
import 'package:mqtt_app01/src/theme/tema.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider (
        create: (_) => MqttStateModel(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MQTT App',
        theme: miTema,
        home: TabsPage()
      ),
    );
  }
}