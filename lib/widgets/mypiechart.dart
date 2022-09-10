import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/utils/utils.dart';

class MyPieChart extends StatelessWidget {
  final double total;
  final List<CategoryUsage> categoryUsage;
  final bool showIcon;
  const MyPieChart(
      {Key? key,
      required this.categoryUsage,
      required this.total,
      this.showIcon = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: PieChart(
        PieChartData(
          // pieTouchData: PieTouchData(enabled: true,touchCallback: (evt,tesp){
          //   debugPrint("${tesp!.touchedSection!.touchedSectionIndex}");
          // }),
          sections: categoryUsage.isEmpty
              ? [
                  PieChartSectionData(
                      titleStyle: const TextStyle(
                        fontFamily: "Itim",
                      ),
                      radius: 80,
                      value: 10,
                      title: "0",
                      color: Colors.grey),
                ]
              : categoryUsage
                  .map((e) => PieChartSectionData(
                      badgeWidget: showIcon
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                expCategoryIcons[e.category],
                                color: expCategoryColors[e.category],
                              ),
                            )
                          : Text(e.category,style: TextStyle(fontSize: 20,fontFamily: 'itim'),),
                      badgePositionPercentageOffset: showIcon ? .98 :1.1,                     
                      radius: 90,
                      titlePositionPercentageOffset: (e.amount /total) ==1 ? .2 :.5,
                      value: e.amount,
                      title: showIcon
                          ? "${((e.amount / total) * 100).toStringAsFixed(1)}%"
                          : "${e.amount}",
                      color: showIcon
                          ? expCategoryColors[e.category]
                          : Colors.redAccent.withOpacity((e.amount/total) )))
                  .toList(),
        ),
        swapAnimationDuration: const Duration(milliseconds: 350),
        swapAnimationCurve: Curves.easeInOutCubic,
      ),
    );
  }
}
