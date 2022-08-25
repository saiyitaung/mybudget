import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/utils/utils.dart';

//implement linechart later
class CategoryDetailLineChartUI extends StatelessWidget {
  final Map<double, double> bardata;
  final List<Color> gradientColors;
  final DateType dateType;
  CategoryDetailLineChartUI(
      {Key? key,
      required this.dateType,
      required this.gradientColors,
      required this.bardata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff232d37)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
          child: LineChart(
            mainData(),
            swapAnimationDuration: Duration(milliseconds: 350),
            swapAnimationCurve: Curves.bounceInOut,
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    Widget Function(double, TitleMeta) bottomTitle;
    switch (dateType) {
      case DateType.week:
        bottomTitle = weekbottomTitleWidgets;
        break;
      case DateType.month:
        bottomTitle = monthBottomTitleWidgets;
        break;
      case DateType.year:
        bottomTitle = yearBottomTitleWidgets;
        break;
      default:
        bottomTitle = weekbottomTitleWidgets;
        break;
    }
    return LineChartData(
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
             tooltipBgColor: Colors.white,
              fitInsideHorizontally: true, fitInsideVertically: true)),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: bottomTitle,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: bardata
              .map((key, value) => MapEntry(key, FlSpot(key, value)))
              .values
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          preventCurveOverShooting: true,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
