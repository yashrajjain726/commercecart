// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commercecart/constants/globals.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:commercecart/models/analytics.dart';

class CategoryProductChart extends StatelessWidget {
  final List<Analytics> sales;
  const CategoryProductChart({
    Key? key,
    required this.sales,
  }) : super(key: key);
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mobiles';
        break;
      case 1:
        text = 'Essentials';
        break;
      case 2:
        text = 'Appliances';
        break;
      case 3:
        text = 'Books';
        break;
      case 4:
        text = 'Fashion';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BarDataModel barDataModel = BarDataModel(
        mobileEarnings: sales[0].totalEarning!,
        essentialsEarnings: sales[1].totalEarning!,
        appliancesEarnings: sales[2].totalEarning!,
        booksEarnings: sales[3].totalEarning!,
        fashionEarnings: sales[4].totalEarning!);

    barDataModel.initializeBarData();
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(builder: (context, constraints) {
          final barsSpace = 4.0 * constraints.maxWidth / 50;
          final barsWidth = 8.0 * constraints.maxWidth / 100;
          return BarChart(
            BarChartData(
              maxY: 100000,
              minY: 100,
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: leftTitles,
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 10 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Globals.greyBackgroundCOlor.withOpacity(0.1),
                  strokeWidth: 1,
                ),
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              groupsSpace: barsSpace,
              barGroups: barDataModel.barData
                  .map(
                    (data) => BarChartGroupData(
                      barsSpace: 10,
                      barRods: [
                        BarChartRodData(
                          toY: data.y.toDouble(),
                          width: barsWidth,
                          color: Globals.secondaryColor,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                      x: data.x,
                    ),
                  )
                  .toList(),
            ),
          );
        }),
      ),
    );
  }
}
