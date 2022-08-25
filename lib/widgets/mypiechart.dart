import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/utils/utils.dart';

class MyPieChart extends StatelessWidget {
  final double total;
  final List<CategoryUsage> categoryUsage;
  MyPieChart({required this.categoryUsage,required this.total});
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: PieChart(
        
        PieChartData(        
          // pieTouchData: PieTouchData(enabled: true,touchCallback: (evt,tesp){
          //   debugPrint("${tesp!.touchedSection!.touchedSectionIndex}");
          // }),
          sections: categoryUsage.isEmpty ? [
            PieChartSectionData(
                titleStyle: TextStyle(
                  fontFamily: "Itim",
                ),             
                radius: 90,
                value: 10,
                title: "0",
                color: Colors.grey),
          ] : categoryUsage.map((e)=>
            PieChartSectionData(               
                badgeWidget: CircleAvatar(
                  child: Icon(
                    expCategoryIcons[e.category],
                    color: expCategoryColors[e.category],
                  ),
                  backgroundColor: Colors.white,
                ),
                badgePositionPercentageOffset: .98,
                radius: 90,
                value: e.amount,
                title: "${((e.amount / total) * 100).toStringAsFixed(1)}%",
                color: expCategoryColors[e.category])).toList(),                       
        ),
        
        swapAnimationDuration: Duration(milliseconds: 350),
        swapAnimationCurve: Curves.easeInOutCubic,
      ),
    );
  }
}
