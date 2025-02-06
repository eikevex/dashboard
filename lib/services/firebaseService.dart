import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/controllers/reviewsController.dart';
import 'package:dashborad/models/review.dart';
import 'package:flutter/material.dart';

Future<String?> getUserRole(String uid) async {
  try {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc['role'];
  } catch (e) {
    print('Erro ao buscar nivel de usuário: $e');
    return '';
  }
}

class ReviewsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Review>> fetchUserReviews(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('reviews-rating')
          .doc(uid)
          .collection('user-reviews')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>? ?? {};
        return Review(
          comment: data['comment'] ?? '',
          cpf: data['cpf'] ?? '',
          date: (data['date'] as Timestamp?)?.toDate(),
          environment: data['environment'] ?? 0,
          indication: data['indication'] ?? 0,
          service: data['service'] ?? 0,
          userId: data['userId'] ?? '',
          waitingTime: data['waitingTime'] ?? 0,
        );
      }).toList();
    } catch (e) {
      print('Erro ao buscar reviews: $e');
      return [];
    }
  }
}
