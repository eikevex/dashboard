  import 'package:dashborad/services/firebaseService.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:get/get.dart';
  import 'package:get/get_state_manager/src/simple/get_controllers.dart';

  class DashboardController extends GetxController {
    var userRole = ''.obs;

    @override
    void onInit() {
      super.onInit();
      fetchUserRole();
    }

    void fetchUserRole() async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        try {
          String? role = await getUserRole(user!.uid);
          userRole.value = role ?? '';
        } catch (e) {
          print('Erro ao buscar nivel de usuário: $e');
        }
      }

      String? role = await getUserRole(FirebaseAuth.instance.currentUser!.uid);
      userRole.value = role ?? '';
    }
  }
