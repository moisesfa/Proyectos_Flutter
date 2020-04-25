import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class PressureSeries {

  final String time;
  final double pressure;
  final charts.Color barColor;

  PressureSeries({
    @required this.time, 
    @required this.pressure,
    @required this.barColor});

}