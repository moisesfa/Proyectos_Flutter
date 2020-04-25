import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class BatterySeries {

  final String time;
  final double battery;
  final charts.Color barColor;

  BatterySeries({
    @required this.time, 
    @required this.battery,
    @required this.barColor});

}