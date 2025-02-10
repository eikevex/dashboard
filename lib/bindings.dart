import 'package:dashborad/controllers/filterControllers.dart';
import 'package:get/get.dart';
import 'controllers/reviewsController.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ReviewsController());
    Get.put(FilterController());
    Get.lazyPut(() => FilterManager());
  }
}
