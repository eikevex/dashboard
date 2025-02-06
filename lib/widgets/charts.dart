import 'package:dashborad/controllers/filterControllers.dart';
import 'package:dashborad/controllers/reviewsController.dart';
import 'package:dashborad/utils/displayMounth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<FilterManager>(context);
    final reviewsController = Provider.of<ReviewsController>(context);
    final indicationCounts = reviewsController.countIndications();

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  rod.toY.toString(),
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 5) {
                  return Text(
                    filterController.selectedMes ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                } else {
                  return const Text('');
                }
              },
            )),
          ),
          borderData: FlBorderData(show: false),
          barGroups: (filterController.selectedMes != null &&
                  filterController.selectedFilial != null &&
                  filterController.selectedCidade != null)
              ? indicationCounts.entries.map((entry) {
                  final indication = entry.key;
                  final total = entry.value;
                  return BarChartGroupData(
                    x: indication,
                    barRods: [
                      BarChartRodData(
                          toY: total.toDouble(), color: Colors.blue),
                    ],
                  );
                }).toList()
              : [],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatefulWidget {
  final List<double> monthlyData;
  final Function(int?) onTouch;

  const PieChartWidget(
      {super.key, required this.monthlyData, required this.onTouch});

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int? touchedIndex;
  List<double> monthlyData = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 60,
            startDegreeOffset: -90,
            sections: generateMonthData(widget.monthlyData),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = null;
                    widget.onTouch(touchedIndex);
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  if (touchedIndex! < 0 || touchedIndex! >= 12) {
                    touchedIndex = null;
                  }
                  widget.onTouch(touchedIndex);
                });
              },
            ),
          ),
        ),
        Positioned.fill(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (touchedIndex != null)
              DisplayMounth(
                touchedIndex: touchedIndex,
                monthlyData: monthlyData,
              ),
          ],
        ))
      ]),
    );
  }

  List<PieChartSectionData> generateMonthData(List<double> monthlyValues) {
    List<PieChartSectionData> sections = [];
    List<Color> colors = [
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.lime,
      Colors.cyan,
      Colors.indigo,
      Colors.brown
    ];

    if (monthlyValues.length != 12) {
      throw Exception(
          "A lista de valores precisa ter 12 itens, um para cada mês.");
    }

    for (int i = 0; i < 12; i++) {
      sections.add(
        PieChartSectionData(
          value: monthlyValues[i],
          color: colors[i],
          radius: touchedIndex == i ? 25 : 20,
          showTitle: false,
        ),
      );
    }

    return sections;
  }
}

class PieChartAssesment extends StatefulWidget {
  final List<double> assesmentData;
  final Function(int?) onTouch;

  const PieChartAssesment(
      {super.key, required this.assesmentData, required this.onTouch});

  @override
  _PieChartAssesmentState createState() => _PieChartAssesmentState();
}

class _PieChartAssesmentState extends State<PieChartAssesment> {
  int? touchedIndex;
  List<double> assesmentData = [
    10,
    15,
    20,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 60,
            startDegreeOffset: -90,
            sections: generateAssessmentData(widget.assesmentData),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = null;
                    widget.onTouch(touchedIndex);
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                  if (touchedIndex! < 0 || touchedIndex! >= 12) {
                    touchedIndex = null;
                  }
                  widget.onTouch(touchedIndex);
                });
              },
            ),
          ),
        ),
        Positioned.fill(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (touchedIndex != null)
              DisplayAvaliation(
                touchedIndex: touchedIndex,
                assessment: assesmentData,
              ),
          ],
        ))
      ]),
    );
  }

  List<PieChartSectionData> generateAssessmentData(
      List<double> assesmentValues) {
    List<PieChartSectionData> sections = [];
    List<Color> colors = [
      Colors.yellow,
      Colors.blue,
      Colors.green,
    ];

    if (assesmentValues.length != 3) {
      throw Exception("A lista de valores precisa ter 3 itens.");
    }

    for (int i = 0; i < 3; i++) {
      sections.add(
        PieChartSectionData(
          value: assesmentValues[i],
          color: colors[i],
          radius: touchedIndex == i ? 25 : 20,
          showTitle: false,
        ),
      );
    }

    return sections;
  }
}
