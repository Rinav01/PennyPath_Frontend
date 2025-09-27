import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pennypath/models/models.dart';

class MyChart extends StatefulWidget {
  final List<Expense> expenses;
  const MyChart({super.key, required this.expenses});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    final colorScheme = Theme.of(context).colorScheme;
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
              colorScheme.tertiary,
            ],
            transform: const GradientRotation(pi / 40),
          ),
          width: 20,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.expenses.map((e) => e.amount).reduce((a, b) => max(a, b)).toDouble(),
            color: colorScheme.outline.withOpacity(0.2),
          ))
    ]);
  }

  List<BarChartGroupData> showingGroups() => widget.expenses.asMap().entries.map((e) {
        return makeGroupData(e.key, e.value.amount.toDouble());
      }).toList();

  BarChartData mainBarData() {
    final colorScheme = Theme.of(context).colorScheme;
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTiles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.outline.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      barGroups: showingGroups(),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = TextStyle(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    if (value.toInt() < widget.expenses.length) {
      text = Text(widget.expenses[value.toInt()].category.name, style: style);
    } else {
      text =  Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = TextStyle(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value % 500 == 0) {
      text = '${(value ~/ 500)}K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}