import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class HumiditySeries {

  final String time;
  final double humidity;
  final charts.Color barColor;

  HumiditySeries({
    @required this.time, 
    @required this.humidity,
    @required this.barColor});

}