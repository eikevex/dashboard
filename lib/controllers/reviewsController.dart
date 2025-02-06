import 'package:dashborad/models/review.dart';
import 'package:dashborad/services/firebaseService.dart';
import 'package:flutter/material.dart';

class ReviewsController extends ChangeNotifier {
  final ReviewsService _reviewsService = ReviewsService();
  List<Review> _reviews = [];
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;

  Future<void> fetchUserReviews(String uid) async {
    _isLoading = true;
    notifyListeners();
    _reviews = await _reviewsService.fetchUserReviews(uid);
    _isLoading = false;
    notifyListeners();
  }

  // Método para contar as reviews por valor de indication
  Map<int, int> countIndications() {
    // Inicializa um mapa para armazenar os totais
    final Map<int, int> indicationCounts = {};

    // Preenche o mapa com valores de 0 a 10, inicializados com 0
    for (int i = 0; i <= 10; i++) {
      indicationCounts[i] = 0;
    }

    // Conta as reviews para cada valor de indication
    for (var review in _reviews) {
      if (review.indication >= 0 && review.indication <= 10) {
        indicationCounts[review.indication] =
            indicationCounts[review.indication]! + 1;
      }
    }

    return indicationCounts;
  }
}
