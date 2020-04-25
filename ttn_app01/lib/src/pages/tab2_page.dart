import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttn_app01/src/charts/battery_chart.dart';
import 'package:ttn_app01/src/charts/battery_series.dart';
import 'package:ttn_app01/src/charts/humidity_chart.dart';
import 'package:ttn_app01/src/charts/humidity_series.dart';
import 'package:ttn_app01/src/charts/pressure_chart.dart';
import 'package:ttn_app01/src/charts/pressure_series.dart';
import 'package:ttn_app01/src/charts/temperature_chart.dart';
import 'package:ttn_app01/src/charts/temperature_series.dart';
import 'package:ttn_app01/src/services/ttn_service.dart';
import 'package:ttn_app01/src/theme/tema.dart';

class Tab2Page extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    final List<BatterySeries> dataBattery = [];    
    final List<TemperatureSeries> dataTemperature = [];
    final List<HumiditySeries> dataHumidity = [];
    final List<PressureSeries> dataPressure = [];
    // Necestiamos obtener los dispositivos de ttn 
    //final ttnService = Provider.of<TtnService>(context);
    //final devices = Provider.of<TtnService>(context).devices;
    final ttnDataDevice = Provider.of<TtnService>(context).ttnDataDevice;                                
    final int numberCards = ttnDataDevice.length;
    print(' Numero de cards Tab2:  $numberCards');

    for (var i =0; i < numberCards ; i++) {

      dataBattery.add(BatterySeries(
        battery: ttnDataDevice[i].bateria, 
        time: ttnDataDevice[i].time.toString().substring(11,19),
        barColor: charts.ColorUtil.fromDartColor(Colors.red)));

      dataTemperature.add(TemperatureSeries(
        temperature: ttnDataDevice[i].temperatura, 
        time: ttnDataDevice[i].time.toString().substring(11,19),
        barColor: charts.ColorUtil.fromDartColor(Colors.red)));
      
      dataHumidity.add(HumiditySeries(
        humidity: ttnDataDevice[i].humedad, 
        time: ttnDataDevice[i].time.toString().substring(11,19),
        barColor: charts.ColorUtil.fromDartColor(Colors.red)));
    
      dataPressure.add(PressureSeries(
        pressure: ttnDataDevice[i].presion, 
        time: ttnDataDevice[i].time.toString().substring(11,19),
        barColor: charts.ColorUtil.fromDartColor(Colors.red)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gráficos'),
        backgroundColor: miTema.accentColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
          controller: PageController(viewportFraction: 0.85),
          children: <Widget>[
            _Card(data: dataBattery, titulo: 'Batería',),
            _Card(data: dataTemperature, titulo: 'Temperatura',),
            _Card(data: dataHumidity, titulo: 'Humedad',),
            _Card(data: dataPressure, titulo: 'Presión',),
          ],
        )
        
        
        

      )
      
      
      // Center(        
      //   child: TemperatureChart(data: dataTemperature),
      // ),
      
    );
  }

}

class _Card extends StatelessWidget {

  final List<dynamic> data;
  final String titulo;
  const _Card({@required this.data,@required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[            
            SizedBox(height: 20.0,),
            _TarjetaGrafico(data: data, titulo: titulo,)  
            ],
          )
        ],
      ),
    );
  }
}


class _TarjetaGrafico extends StatelessWidget {
  
  final List<dynamic> data;
  final String titulo;
  const _TarjetaGrafico({@required this.data, @required this.titulo});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    // TODO: implement build
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
      child: ClipRRect(
        //borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: size.width *0.9,
          height: size.height *0.6,
          //color: ,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),   
              Text('$titulo', style: TextStyle( fontSize: 20.0),),
              Expanded(
                flex: 3,
                child: _selectChart(titulo)
                
                // if (titulo == 'batería') {
                //   BatteryChart(data: data)
                // } else if (titulo=='Temperatura') {
                //   TemperatureChart(data:data)
                // }
                
              
                ),               
            ],
          ),
        ),
      ),
    );
  }

  // Para seleccionar el grafico que queremos mostrar 
  _selectChart( String nombre ) {    
    if (nombre == 'Batería') {
      return BatteryChart(data: data);
    } else if (titulo=='Temperatura') {
      return TemperatureChart(data:data);
    } else if (titulo=='Humedad') {
      return HumidityChart(data:data);
    } else {
      return PressureChart(data:data);
    }
  }


}

