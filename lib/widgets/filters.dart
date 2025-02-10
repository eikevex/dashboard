import 'package:dashborad/controllers/filterControllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filters extends StatefulWidget {
  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    final filterController = Get.find<FilterManager>();
    final FilterController controllerAgencys = Get.find<FilterController>();
    
    return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(() {
          if (controllerAgencys.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: filterController.selectedCidade,
                hint: Text('Selecione a Cidade'),
                onChanged: (String? newValue) {
                  setState(() {
                    filterController.updateCidade(newValue);
                    controllerAgencys.filterAgencysByCity(newValue!);
                    filterController.updateFilial(null);
                  });
                },
                items: ['Indaial', 'Timbó', 'Blumenau', 'Pomerode', 'Gaspar']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                menuMaxHeight: 200,
              ),
              DropdownButton<String>(
                value: filterController.selectedFilial,
                hint: Text('Selecione a Filial'),
                onChanged: filterController.selectedCidade == null
                    ? null
                    : (String? newValue) {
                        setState(() {
                          filterController.updateFilial(newValue);
                        });
                      },
                items: controllerAgencys.filteredAgencys
                    .map<DropdownMenuItem<String>>((agency) {
                  return DropdownMenuItem<String>(
                    value: agency.name,
                    child: Text(agency.name),
                  );
                }).toList(),
                menuMaxHeight: 200,
              ),
              DropdownButton<String>(
                value: filterController.selectedMes ?? 'Janeiro',
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
          );
        }));
  }
}
