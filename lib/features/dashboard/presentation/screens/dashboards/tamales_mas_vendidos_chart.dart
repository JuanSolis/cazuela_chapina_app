import 'package:cazuela_chapina_app/features/auth/presentation/widgets/indicator.dart';
import 'package:cazuela_chapina_app/features/auth/presentation/widgets/resources/app_colors.dart';
import 'package:cazuela_chapina_app/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TamalesMasVendidosChart extends ConsumerStatefulWidget {
  const TamalesMasVendidosChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends ConsumerState {
  int touchedIndex = -1;
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).tamalesMasVendidos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(dashboardProvider);
    final contentStateData = contentState.contentTamalesMasVendidos;
    return AspectRatio(
      aspectRatio: 2,
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection:
                Axis.horizontal, // Set scroll direction to horizontal
            child: Row(
              spacing: 20,
              children: [
                Indicator(
                  color: AppColors.contentColorBlue,
                  text:
                      contentStateData.length > 0
                          ? contentStateData[0]['relleno']
                          : '...',
                  isSquare: false,
                  size: touchedIndex == 0 ? 18 : 16,
                  textColor:
                      touchedIndex == 0
                          ? AppColors.contentColorBlue
                          : AppColors.contentColorBlue,
                ),
                Indicator(
                  color: AppColors.contentColorYellow,
                  text:
                      contentStateData.length > 1
                          ? contentStateData[1]['relleno']
                          : '...',
                  isSquare: false,
                  size: touchedIndex == 1 ? 18 : 16,
                  textColor:
                      touchedIndex == 1
                          ? AppColors.mainTextColor1
                          : AppColors.contentColorYellow,
                ),
                Indicator(
                  color: AppColors.contentColorPink,
                  text:
                      contentStateData.length > 2
                          ? contentStateData[2]['relleno']
                          : '...',
                  isSquare: false,
                  size: touchedIndex == 2 ? 18 : 16,
                  textColor:
                      touchedIndex == 2
                          ? AppColors.mainTextColor1
                          : AppColors.contentColorPink,
                ),
                Indicator(
                  color: AppColors.contentColorGreen,
                  text:
                      contentStateData.length > 3
                          ? contentStateData[3]['relleno']
                          : '...',
                  isSquare: false,
                  size: touchedIndex == 3 ? 18 : 16,
                  textColor:
                      touchedIndex == 3
                          ? AppColors.mainTextColor1
                          : AppColors.contentColorGreen,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 10,
                  centerSpaceRadius: 10,
                  sections: showingSections(contentStateData),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<dynamic> contentStateData) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      const color0 = AppColors.contentColorBlue;
      const color1 = AppColors.contentColorYellow;
      const color2 = AppColors.contentColorPink;
      const color3 = AppColors.contentColorGreen;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: color0,
            value:
                contentStateData.length > 0
                    ? contentStateData[0]['totalVendidos'].toDouble()
                    : 0,
            title:
                contentStateData.length > 0
                    ? contentStateData[0]['totalVendidos'].toString()
                    : "",
            radius: 80,
            borderSide:
                isTouched
                    ? const BorderSide(
                      color: AppColors.contentColorWhite,
                      width: 6,
                    )
                    : BorderSide(
                      color: AppColors.contentColorWhite.withValues(alpha: 0),
                    ),
          );
        case 1:
          return PieChartSectionData(
            color: color1,
            value:
                contentStateData.length > 0
                    ? contentStateData[1]['totalVendidos'].toDouble()
                    : 0,
            title:
                contentStateData.length > 0
                    ? contentStateData[1]['totalVendidos'].toString()
                    : "",
            radius: 65,
            titlePositionPercentageOffset: 0.55,
            borderSide:
                isTouched
                    ? const BorderSide(
                      color: AppColors.contentColorWhite,
                      width: 6,
                    )
                    : BorderSide(
                      color: AppColors.contentColorWhite.withValues(alpha: 0),
                    ),
          );
        case 2:
          return PieChartSectionData(
            color: color2,
            value:
                contentStateData.length > 0
                    ? contentStateData[2]['totalVendidos'].toDouble()
                    : 0,
            title:
                contentStateData.length > 0
                    ? contentStateData[2]['totalVendidos'].toString()
                    : "",
            radius: 60,
            titlePositionPercentageOffset: 0.6,
            borderSide:
                isTouched
                    ? const BorderSide(
                      color: AppColors.contentColorWhite,
                      width: 6,
                    )
                    : BorderSide(
                      color: AppColors.contentColorWhite.withValues(alpha: 0),
                    ),
          );
        case 3:
          return PieChartSectionData(
            color: color3,
            value:
                contentStateData.length > 0
                    ? contentStateData[3]['totalVendidos'].toDouble()
                    : 0,
            title:
                contentStateData.length > 0
                    ? contentStateData[3]['totalVendidos'].toString()
                    : "",
            radius: 70,
            titlePositionPercentageOffset: 0.55,
            borderSide:
                isTouched
                    ? const BorderSide(
                      color: AppColors.contentColorWhite,
                      width: 6,
                    )
                    : BorderSide(
                      color: AppColors.contentColorWhite.withValues(alpha: 0),
                    ),
          );
        default:
          throw Error();
      }
    });
  }
}
