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
    return Column(
      children: [
        Text(
          getMonthName(touchedIndex!),
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${monthlyData[touchedIndex!]}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
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

class DisplayAvaliation extends StatelessWidget {
  const DisplayAvaliation({
    super.key,
    required this.touchedIndex,
    required this.assessment,
  });

  final int? touchedIndex;
  final List<double> assessment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getAssessmentName(touchedIndex!),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${assessment[touchedIndex!]}',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  String getAssessmentName(int index) {
    List<String> months = [
      'Ambiente',
      'Espera',
      'Atendimento',
    ];
    return months[index];
  }
}
