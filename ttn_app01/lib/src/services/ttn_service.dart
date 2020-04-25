import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:ttn_app01/src/models/devices_model.dart';
import 'package:ttn_app01/src/models/ttndatadevice_model.dart';

  enum ResultStatus {
    success,
    failure,
    loading,
  }

  final String ACCESS_KEYS = 'key -TU ACCESS KEYS-';

class TtnService with ChangeNotifier {

  // Lista de dipositivos recibidos 
  List<String> devices = [];
  List<TtnDataDevice> ttnDataDevice = [];

  String _selectedDevice = '';
  ResultStatus _status;
  
  TtnService() {
    _status = null;
    this.getDevices();
  }

  //Getter y setter del dispositivo seleccionado
  get selectedDevice => this._selectedDevice;
  set selectedDevice (String valor){
    this._selectedDevice = valor;
    this.getDataDevice(valor);
    notifyListeners();
  }



  // Metodo para obtener los dispositivos 
  getDevices() async {
    print('Cargando dispositivos ...');
    _status = ResultStatus.loading;

    // Url para buscar los dispositivos en la aplicación 
    
    final url = 'https://TU APLICATION ID.data.thethingsnetwork.org/api/v2/devices';
    Map<String, String> requestHeaders = {       
       'Accept': 'application/json',
       'Authorization': '$ACCESS_KEYS'
    };
    
    final response = await http.get(url,headers:requestHeaders);

    if (response.statusCode != 200) {
      _status = ResultStatus.failure;
      print('Request to $url failed with status ${response.statusCode}: ${response.body}');
      return;
      
      // throw Exception(
      //     "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }

    final ttnDevices = ttnDevicesFromJson(response.body);
    print(ttnDevices);
    this.devices.addAll(ttnDevices);
    _status = ResultStatus.success;
    notifyListeners();

  }

  // Metodo para recibir los datos del dispositivo   
  getDataDevice(String device ) async {
    print('Leyendo los datos del dispositivo ...');
    _status = ResultStatus.loading;
    
    // Para no duplicar los datos 
    //if (this.ttnDataDevice.length > 0 ){
    //  return this.ttnDataDevice;
    //}

    final url = 'https://TU APLICATION ID.data.thethingsnetwork.org/api/v2/query/$device';
    Map<String, String> requestHeaders = {       
       'Accept': 'application/json',
       'Authorization': '$ACCESS_KEYS'
    };
    final response = await http.get(url,headers:requestHeaders);

    if (response.statusCode != 200) {
      _status = ResultStatus.failure;
      print('Request to $url failed with status ${response.statusCode}: ${response.body}');
      return;
      // throw Exception(
      //     "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }

    final ttnDataDeviceResp = ttnDataDeviceFromJson(response.body);
    print(ttnDataDeviceResp);
    
    this.ttnDataDevice.clear();
    this.ttnDataDevice.addAll(ttnDataDeviceResp);
    _status = ResultStatus.success;
    notifyListeners();
  
  } 


}