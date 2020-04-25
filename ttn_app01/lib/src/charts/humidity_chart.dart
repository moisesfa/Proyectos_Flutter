
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ttn_app01/src/charts/humidity_series.dart';


class HumidityChart extends StatelessWidget {

  final List<HumiditySeries> data;
  const HumidityChart({this.data});
  
  @override
  Widget build(BuildContext context) {
    
    List<charts.Series<HumiditySeries, String>> series =[
      charts.Series(
        id: 'Battery',
        data: data,        
        domainFn: (HumiditySeries series, _) => series.time,
        measureFn: (HumiditySeries series, _) => series.humidity,        
        colorFn: (HumiditySeries series, _) => series.barColor
        )

    ];
    
    return charts.BarChart(series, 
      animate: true,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
        // Tick and Label styling here.
        labelStyle: charts.TextStyleSpec(                    
          //fontSize: 13, // size in Pts.
          color: charts.MaterialPalette.white),
        // Change the line colors to match text color.
        lineStyle: charts.LineStyleSpec(
          color: charts.MaterialPalette.white))
      ),
      
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(

        // Tick and Label styling here.
        labelStyle: charts.TextStyleSpec(
        //fontSize: 13, // size in Pts.
        color: charts.MaterialPalette.white),

        // Change the line colors to match text color.
        lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.white))
      ),
    );


    // PARA VERLO COMO UN CONTAINER
    // return Container(
    //   height: 400,       
    //   padding: EdgeInsets.all(20.0),
    //   child: Card(  
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),      
    //     elevation: 5.0,        
    //     child: Padding (          
    //       padding: EdgeInsets.all(8.0),
    //       child: Column(
    //       children: <Widget>[
    //         Text('Ejemplo', style: Theme.of(context).textTheme.body2,),
    //         Expanded(
    //           flex: 3,
    //           child: charts.BarChart(series, 
    //             animate: true,
                
    //             domainAxis: charts.OrdinalAxisSpec(
    //               renderSpec: charts.SmallTickRendererSpec(
    //               // Tick and Label styling here.
    //               labelStyle: charts.TextStyleSpec(
    //                 fontSize: 13, // size in Pts.
    //                 color: charts.MaterialPalette.white),
    //               // Change the line colors to match text color.
    //               lineStyle: charts.LineStyleSpec(
    //                 color: charts.MaterialPalette.white))
    //             ),
                
    //             /// Assign a custom style for the measure axis.
    //             primaryMeasureAxis: charts.NumericAxisSpec(
    //               renderSpec: charts.GridlineRendererSpec(

    //               // Tick and Label styling here.
    //               labelStyle: charts.TextStyleSpec(
    //               fontSize: 13, // size in Pts.
    //               color: charts.MaterialPalette.white),

    //               // Change the line colors to match text color.
    //               lineStyle: charts.LineStyleSpec(
    //               color: charts.MaterialPalette.white))
    //             ),

    //           ),              
    //         )  
    //       ], 
    //      ),
    //    ), 

    //   ),
    // );


  }
}