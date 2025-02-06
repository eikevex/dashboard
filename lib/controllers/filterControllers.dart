import 'package:flutter/material.dart';

class FilterManager with ChangeNotifier {
  String? _selectedFilial;
  String? _selectedCidade;
  String? _selectedMes;

  String? get selectedFilial => _selectedFilial;
  String? get selectedCidade => _selectedCidade;
  String? get selectedMes => _selectedMes;

  void updateFilial(String? value) {
    _selectedFilial = value;
    notifyListeners();
  }

  void updateCidade(String? value) {
    _selectedCidade = value;
    notifyListeners();
  }

  void updateMes(String? value) {
    _selectedMes = value;
    notifyListeners();
  }
}
