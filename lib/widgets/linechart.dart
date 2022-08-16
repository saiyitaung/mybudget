import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//implement linechart later
class LineChartUI extends StatelessWidget {
  const LineChartUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(child: LineChart(getChartData())),
    );
  }

  LineChartData getChartData() {
    return LineChartData();
  }
}
