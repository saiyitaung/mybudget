import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/utils/utils.dart';

//implement linechart later
class LineChartUI extends StatelessWidget {
  final Map<double, double> bardata;
  final DateType dateType;
  final List<Color> gradientColors;

  LineChartUI(
      {Key? key,
      required this.gradientColors,
      required this.bardata,
      required this.dateType,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(
            // borderRadius: BorderRadius.all(
            //   Radius.circular(18),
            // ),
            color: Color(0xff232d37)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 24, bottom: 12, left: 10, right: 15),
          child: LineChart(
            mainData(),
            swapAnimationDuration: Duration(milliseconds: 350),
            swapAnimationCurve: Curves.bounceInOut,
          ),
        ),
      ),
    );
  }

  

  

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontFamily: "meriendaone",
      fontSize: 11,
    );
    String text;
    switch (value.toInt()) {       
    case 1:
      text = "1";
      break;
    case 5:
      text = "5";
      break;
    case 10:
      text = "10";
      break;
    case 15:
      text = "15";
      break;
    case 20:
      text = "25";
      break;
    case 30:
      text = "30";
      break;
    case 35:
      text = "35";
      break;
    case 40:
      text = "40";
      break;
    case 45:
      text = "45";
      break;
    case 50:
      text = "50";
      break;
    case 100:
      text = "100";
      break;
    case 150:
      text = "150";
      break;
    case 200:
      text = "200";
      break;
    case 250:
      text = "250";
      break;
    case 300:
      text = "300";
      break;
    case 350:
      text = "350";
      break;
    case 400:
      text = "400";
      break;
    case 450:
      text = "450";
      break;
    case 500:
      text = "500";
      break;
    case 1000:
      text = "1K";
      break;
    case 2000:
    text="2K";
    break;
    case 3000:
    text ="3K";
    break;
    case 5000:
      text = "5K";
      break;
    case 8000:
    text="8K";
    break;
    case 10000:
      text = "10K";
      break;
    case 15000:
      text = "15K";
      break;
    case 20000:
      text = "20K";
      break;
    case 30000:
      text = "30K";
      break;
    case 50000:
      text = "50K";
      break;
    case 100000:
      text = "100K";
      break;
    case 150000:
      text = "150K";
      break;
    case 200000:
      text = "200K";
      break;
    case 300000:
      text = "300K";
      break;
    case 500000:
      text = "500K";
      break;
    case 1000000:
      text = "1M";
      break;
    case 5000000:
      text = "5M";
      break;
    case 10000000:
      text = "10M";
      break;
    case 15000000:
      text = "15M";
      break;
    case 20000000:
      text = "20M";
      break;
    case 25000000:
      text = "25M";
      break;
    case 30000000:
      text = "30M";
      break;
    case 35000000:
      text = "35M";
      break;
    case 40000000:
      text = "45M";
      break;
    case 45000000:
      text = "45M";
      break;
    case 50000000:
      text = "50M";
      break;
    case 100000000:
      text = "100M";
      break;
    case 500000000:
      text = "500M";
      break;
    case 1000000000:
      text = "1B";
      break;
    case 10000000000:
      text = "10B";
      break;
    case 100000000000:
      text = "100B";
      break;
    case 1000000000000:
      text = "1T";
      break;  
      default:
        return const SizedBox();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
              fitInsideHorizontally: true,
              fitInsideVertically: true)),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
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
          leftTitles: AxisTitles(
            
            sideTitles: SideTitles(showTitles: true,
             getTitlesWidget: leftTitleWidgets
            ),
          )),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1),),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: bardata
              .map((key, value) => MapEntry(key, FlSpot(key, value)))
              .values
              .toList(),
          isCurved: true,
          preventCurveOverShooting: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
