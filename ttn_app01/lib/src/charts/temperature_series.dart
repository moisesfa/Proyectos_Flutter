import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class TemperatureSeries {

  final String time;
  final double temperature;
  final charts.Color barColor;

  TemperatureSeries({
    @required this.time, 
    @required this.temperature,
    @required this.barColor});

}