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
}
