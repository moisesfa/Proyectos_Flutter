// To parse this JSON data, do
//
//     final ttnDataDevice = ttnDataDeviceFromJson(jsonString);

import 'dart:convert';

List<TtnDataDevice> ttnDataDeviceFromJson(String str) => List<TtnDataDevice>.from(json.decode(str).map((x) => TtnDataDevice.fromJson(x)));

String ttnDataDeviceToJson(List<TtnDataDevice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TtnDataDevice {
    double bateria;
    double humedad;
    double presion;
    double temperatura;
    String deviceId;
    String raw;
    DateTime time;

    TtnDataDevice({
        this.bateria,
        this.humedad,
        this.presion,
        this.temperatura,
        this.deviceId,
        this.raw,
        this.time,
    });

    factory TtnDataDevice.fromJson(Map<String, dynamic> json) => TtnDataDevice(
        bateria: json["Bateria"].toDouble(),
        humedad: json["Humedad"].toDouble(),
        presion: json["Presion"].toDouble(),
        temperatura: json["Temperatura"].toDouble(),
        deviceId: json["device_id"],
        raw: json["raw"],
        time: DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "Bateria": bateria,
        "Humedad": humedad,
        "Presion": presion,
        "Temperatura": temperatura,
        "device_id": deviceId,
        "raw": raw,
        "time": time.toIso8601String(),
    };
}
