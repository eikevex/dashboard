import 'package:dashborad/models/review.dart';
import 'package:dashborad/services/firebaseService.dart';
import 'package:get/get.dart';

class ReviewsController extends GetxController {
  final ReviewService _reviewService = ReviewService();

  var reviews = <Review>[].obs;
  var totalIndication = 0.obs;
  var totalIndicationDoc = 0.obs;
  var averageIndication = 0.0.obs;
  var isLoading = true.obs;
  RxList<int?> indicationCounts = List.filled(11, 0).obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataReviews();
  }

  Future<void> fetchDataReviews() async {
    try {
      var data = await _reviewService.fetchDataReviews();
      reviews.assignAll(data);
      totalIndication.value =
          data.fold(0, (sum, review) => sum + review.indication);
      totalIndicationDoc.value = data.length;

      if (totalIndication.value > 0) {
        averageIndication.value =
            totalIndication.value / totalIndicationDoc.value;
      } else {
        averageIndication.value = 0.0;
      }
      countIndications(data);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possivel buscar dados $e');
    } finally {
      isLoading(false);
    }
  }

  void countIndications(List<Review> reviews) {
    for (int i = 0; i <= 10; i++) {
      indicationCounts[i] = 0;
    }
    for (var review in reviews) {
      if (review.indication >= 0 && review.indication <= 10) {
        indicationCounts[review.indication] =
            indicationCounts[review.indication]! + 1;
      }
    }
  }
}