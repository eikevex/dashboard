import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphBar extends StatelessWidget {
  const GraphBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            minY: 0,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    if (value.isNaN || value.isInfinite) {
                      return SizedBox.shrink();
                    }
                    return Text(value.toInt().toString());
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Text('Bar ${(value + 1).toInt()}'),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: false,
            ),
            borderData: FlBorderData(
                show: true, border: Border.all(color: Colors.grey, width: 1)),
            barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Valor: ${rod.toY}',
                  TextStyle(color: Colors.white),
                );
              },
            )),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(toY: 40, color: Colors.blue, width: 16),
              ]),
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(toY: 70, color: Colors.red, width: 16),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 90, color: Colors.green, width: 16),
              ]),
            ]),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 70,
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
            Text(
              '332',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
            Text('Total')
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
          radius: touchedIndex == i ? 25 : 20, // Aumenta o raio ao tocar
          showTitle: false,
        ),
      );
    }

    return sections;
  }
}
