import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../controllers/investment_controller.dart';
import '../../constants/investment_constants.dart';
import '../../theme/app_colors.dart';

class TaxComparisonGraph extends StatelessWidget {
  final controller = Get.find<InvestmentController>();

  TaxComparisonGraph({super.key});

  List<FlSpot> _generateNormalTaxSpots(double profitAxis) {
    List<FlSpot> spots = [];
    for (int i = 0; i <= InvestmentConstants.POINT_COUNT; i++) {
      double profit = (profitAxis * i) / InvestmentConstants.POINT_COUNT;
      double tax = profit * InvestmentConstants.NORMAL_TAX_RATE;
      spots.add(FlSpot(profit, tax));
    }
    return spots;
  }

  List<FlSpot> _generateIsaTaxSpots(double profitAxis) {
    List<FlSpot> spots = [];
    for (int i = 0; i <= InvestmentConstants.POINT_COUNT; i++) {
      double profit = (profitAxis * i) / InvestmentConstants.POINT_COUNT;
      double tax = 0.0;
      if (profit > InvestmentConstants.ISA_TAX_FREE_LIMIT) {
        tax = (profit - InvestmentConstants.ISA_TAX_FREE_LIMIT) *
            InvestmentConstants.ISA_TAX_RATE;
      }
      spots.add(FlSpot(profit, tax));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.all(25),
          child: SizedBox(
            height: 400,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.white.withOpacity(0.8),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot spot) {
                        String label = spot.barIndex == 0 ? '일반계좌' : 'ISA계좌';
                        return LineTooltipItem(
                          '$label\n수익금: ${(spot.x).toStringAsFixed(0)}만원\n세금: ${(spot.y).toStringAsFixed(0)}만원',
                          TextStyle(
                            color: spot.barIndex == 0
                                ? AppColors.error
                                : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? touchResponse) {
                    if (event is FlPanEndEvent || event is FlTapUpEvent) {
                      final spot = touchResponse?.lineBarSpots?.first;
                      if (spot != null) {
                        controller.calculateTax(spot.x, spot.y);
                        _generateIsaTaxSpots(controller.taxAxis.value);
                        _generateIsaTaxSpots(controller.taxAxis.value);
                      }
                    }
                  },
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: controller.taxAxis.value / 20,
                  verticalInterval: controller.profitAxis.value / 8,
                ),
                titlesData: FlTitlesData(
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: controller.profitAxis.value / 4,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('${(value).toStringAsFixed(0)}만원'),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: controller.taxAxis.value / 4,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text('${(value).toStringAsFixed(0)}만원'),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                lineBarsData: [
                  // 일반계좌 세금 곡선
                  LineChartBarData(
                    spots: _generateNormalTaxSpots(controller.profitAxis.value),
                    isCurved: true,
                    color: AppColors.error,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.error.withOpacity(0.1),
                    ),
                  ),
                  // ISA계좌 세금 곡선
                  LineChartBarData(
                    spots: _generateIsaTaxSpots(controller.profitAxis.value),
                    isCurved: true,
                    color: AppColors.primary,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine(
                      x: controller.profit.value,
                      color: Colors.grey,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
