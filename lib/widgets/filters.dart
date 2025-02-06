import 'package:dashborad/controllers/filterControllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filters extends StatefulWidget {
  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<FilterManager>(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            value: filterController.selectedFilial,
            hint: Text('Selecione a Filial'),
            onChanged: (String? newValue) {
              setState(() {
                filterController.updateFilial(newValue);
              });
            },
            items: ['Filial A', 'Filial B', 'Filial C']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            menuMaxHeight: 200,
          ),
          DropdownButton<String>(
            value: filterController.selectedCidade,
            hint: Text('Selecione a Cidade'),
            onChanged: (String? newValue) {
              setState(() {
                filterController.updateCidade(newValue);
              });
            },
            items: ['Indaial', 'Timbó', 'Blumenau']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            menuMaxHeight: 200,
          ),
          DropdownButton<String>(
            value: filterController.selectedMes,
            hint: Text('Selecione o Mês'),
            onChanged: (String? newValue) {
              setState(() {
                filterController.updateMes(newValue);
              });
            },
            items: [
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
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            menuMaxHeight: 200,
          ),
        ],
      ),
    );
  }
}
