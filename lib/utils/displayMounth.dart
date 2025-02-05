import 'package:flutter/material.dart';

class DisplayMounth extends StatelessWidget {
  const DisplayMounth({
    super.key,
    required this.touchedIndex,
    required this.monthlyData,
  });

  final int? touchedIndex;
  final List<double> monthlyData;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${getMonthName(touchedIndex!)}: ${monthlyData[touchedIndex!]}",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String getMonthName(int index) {
    List<String> months = [
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
    return months[index];
  }
}
