import 'package:dashborad/models/agency.dart';
import 'package:dashborad/services/firebaseService.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final AgencyService _agencyService = AgencyService();

  var agencys = <Agency>[].obs;
  var agencyId = ''.obs;
  var filteredAgencys = <Agency>[].obs;
  var name = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataAgency();
  }

  Future<void> fetchDataAgency() async {
    try {
      var data = await _agencyService.fetchAgency();
      agencys.assignAll(data);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possivel buscar dados $e');
    } finally {
      isLoading(false);
    }
  }

  void filterAgencysByCity(String city) {
    filteredAgencys
        .assignAll(agencys.where((agency) => agency.city == city).toList());
  }
}

class FilterManager extends GetxController {
  final _selectedFilial = Rx<String?>(null);
  final _selectedCidade = Rx<String?>(null);
  final _selectedMes = Rx<String?>(null);

  String? get selectedFilial => _selectedFilial.value;
  String? get selectedCidade => _selectedCidade.value;
  String? get selectedMes => _selectedMes.value;

  void updateFilial(String? value) {
    _selectedFilial.value = value;
    update();
  }

  void updateCidade(String? value) {
    _selectedCidade.value = value;
    update();
  }

  void updateMes(String? value) {
    _selectedMes.value = value;
    update();
  }
}
