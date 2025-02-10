import 'package:dashborad/controllers/filterControllers.dart';
import 'package:dashborad/controllers/reviewsController.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filterControllerManager = Get.find<FilterManager>();
    final reviewsController = Get.find<ReviewsController>();

    List<String> getMonthSequence(String? selectedMonth) {
      List<String> allMonths = [
        'Janeiro',
        'Fevereiro',
        'Março',
        'Abril',
        'Maio',
        'Junho',
        'Julho',
        'Agosto',
        'Setembro',
        'Outubro',
        'Novembro',
        'Dezembro'
      ];

      int startIndex =
          selectedMonth != null ? allMonths.indexOf(selectedMonth) : 0;

      return [
        allMonths[startIndex],
        allMonths[(startIndex + 1) % 12],
        allMonths[(startIndex + 2) % 12],
      ];
    }

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() {
        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 13,
            titlesData: FlTitlesData(
              show: true,
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == 5) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Total de indicação por notas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                reservedSize: 30,
              )),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 && value.toInt() <= 10) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  },
                ),
              ),
            ),
            barGroups: List.generate(11, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY:
                        reviewsController.indicationCounts[index]?.toDouble() ??
                            0.0,
                    color: Color.lerp(Colors.yellow, Colors.blue, index / 10),
                    width: 40,
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
