
// To parse this JSON data, do
//
//     final ttnDevices = ttnDevicesFromJson(jsonString);

import 'dart:convert';

List<String> ttnDevicesFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String ttnDevicesToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

/*
class Device {
    
  final String name;
  Device(this.name);

}
*/