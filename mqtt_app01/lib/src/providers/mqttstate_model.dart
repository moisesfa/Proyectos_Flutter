import 'package:flutter/material.dart';

class MqttStateModel with ChangeNotifier {

  bool _connectionState = false;  
  List<String> _receivedMsg = []; 
  
  // Getter y setter 
  // connectionState
  bool get connectionState {
    return _connectionState;
  }
  set connectionState (bool val) {
    this._connectionState = val;
    //print('connectionState: $_connectionState');
    notifyListeners();
  }

  // Getter y setter 
  // receivedMsg
  List<String> get receivedMsg {
    return _receivedMsg;
  }
  set receivedMsg ( List<String> receivedVal) {
    this._receivedMsg = receivedVal;
    //print('Añado mensaje: $receivedVal');
    notifyListeners();
  }

  


}
