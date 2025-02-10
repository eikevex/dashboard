import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String comment;
  final String cpf;
  final DateTime? date;
  final int environment;
  final int indication;
  final int service;
  final String userId;
  final int waitingTime;

  Review({
    required this.comment,
    required this.cpf,
    this.date,
    required this.environment,
    required this.indication,
    required this.service,
    required this.userId,
    required this.waitingTime,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
        comment: map['comment'] ?? '',
        cpf: map['cpf'] ?? '',
        environment: map['environment'] ?? 0,
        indication: map['indication'] ?? 0,
        service: map['service'] ?? 0,
        userId: map['userId'] ?? '',
        waitingTime: map['waitingTime'] ?? 0,
        date: map['date'] != null ? (map['date'] as Timestamp).toDate() : null);
  }
  @override
  String toString() {
    return 'Review(indication: $indication, comment: $comment, userId: $userId, service: $service, userId: $userId, cpf: $cpf, environment: $environment)';
  }
}
