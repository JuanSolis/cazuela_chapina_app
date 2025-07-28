import 'package:cazuela_chapina_app/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LineChartSample2 extends ConsumerStatefulWidget {
  const LineChartSample2({super.key});

  @override
  ConsumerState<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends ConsumerState<LineChartSample2> {
  List<Color> gradientColors = [Colors.cyan, Colors.red];

  bool showAvg = false;

  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).ventasDiarias();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(dashboardProvider);

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 25,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(mainData(contentState.contentVentasPorDias)),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    final contentState = ref.watch(dashboardProvider);
    final contetStateDataDate =
        contentState.contentVentasPorDias.length > 0
            ? contentState.contentVentasPorDias[value.toInt() + 1 >
                    contentState.contentVentasPorDias.length
                ? value.toInt() - 1
                : value.toInt()]
            : {"totalVentas": "No data"};

    return SideTitleWidget(
      meta: meta,
      child: Text(
        contetStateDataDate["fechaVenta"].toString().split("T")[0],
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
    final contentState = ref.watch(dashboardProvider);
    final contetStateDataDate =
        contentState.contentVentasPorDias.length > 0
            ? contentState.contentVentasPorDias[value.toInt() + 1 >
                    contentState.contentVentasPorDias.length
                ? value.toInt() - 1
                : value.toInt()]
            : {"totalVentas": "No data"};

    return Text(
      contetStateDataDate["totalVentas"].toString(),
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData(List<dynamic> content) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.amber, strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.lightGreenAccent, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 20,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 8,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots:
              content.asMap().entries.map((entry) {
                int index = entry.key;
                double totalVentas =
                    entry.value["totalVentas"]?.toDouble() ?? 0.0;

                return FlSpot(index.toDouble(), totalVentas);
              }).toList(),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors
                      .map((color) => color.withValues(alpha: 0.3))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
