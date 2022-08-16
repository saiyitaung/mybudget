import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  final double? inC;
  final double? exP;
  MyPieChart({this.inC, this.exP});
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(
          startDegreeOffset: -90,
          sections: inC == 0.0 && exP == 0.0 ? [
            //
            // Show piechart white24 color if income or exp is 0.0
            //
            PieChartSectionData(
              color: Colors.white24,
              value: 10,
              showTitle: false,
              radius: 6
            )
          ]:
          [
          
          PieChartSectionData(
              showTitle: false, radius: 6, color: Colors.red, value: exP),
          PieChartSectionData(
              showTitle: false, radius: 6, color: Colors.teal, value: inC)
        ]),
        swapAnimationDuration: Duration(milliseconds: 600),
        swapAnimationCurve: Curves.easeIn,
      );
  }
}
