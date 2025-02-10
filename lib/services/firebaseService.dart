import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/models/agency.dart';
import 'package:dashborad/models/review.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUserRole(String uid) async {
  try {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc['role'];
  } catch (e) {
    print('Erro ao buscar nivel de usuário: $e');
    return null;
  }
}

Future<String?> getUserId(String uid) async {
  try {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc['id'];
  } catch (e) {
    print('Erro ao buscar nivel de usuário: $e');
    return null;
  }
}

class ReviewService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Review>> fetchDataReviews() async {
    List<Review> reviews = [];
    final userRole = await getUserRole(FirebaseAuth.instance.currentUser!.uid);
    final userId = await getUserId(FirebaseAuth.instance.currentUser!.uid);
    if (userRole == 'admin') {
      try {
        var querySnapshot = await db.collectionGroup('user-reviews').get();
        print('Total documents in user-reviews: ${querySnapshot.docs.length}');

        for (var doc in querySnapshot.docs) {
          //  print('Subdocument data: ${doc.data()}');
          var review = Review.fromMap(doc.data());
          reviews.add(review);
        }
        return reviews;
      } catch (e) {
        rethrow;
      }
    } else if (userRole == "local") {
      try {
        var querySnapshot = await db
            .collection('reviews-rating')
            .doc(userId)
            .collection('user-reviews')
            .get();
        print('Total documents in user-reviews: ${querySnapshot.docs.length}');
        for (var doc in querySnapshot.docs) {
          var review = Review.fromMap(doc.data());
          reviews.add(review);
          //print('Subdocument data: ${doc.data()}');
        }

        return reviews;
      } catch (e) {
        rethrow;
      }
    } else if (userRole == "regional") {
      try {
        var querySnapshot = await db
            .collection('reviews-rating')
            .doc(userId)
            .collection('user-reviews')
            .get();
        print('Total documents in user-reviews: ${querySnapshot.docs.length}');
        for (var doc in querySnapshot.docs) {
          var review = Review.fromMap(doc.data());
          reviews.add(review);
          //print('Subdocument data: ${doc.data()}');
        }

        return reviews;
      } catch (e) {
        rethrow;
      }
    }
    return reviews;
  }
}

class AgencyService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<Agency>> fetchAgency() async {
    List<Agency> agencys = [];
    final userRole = await getUserRole(FirebaseAuth.instance.currentUser!.uid);
    final userId = await getUserId(FirebaseAuth.instance.currentUser!.uid);

    if (userRole == 'admin') {
      try {
        var querySnapshot = await db.collectionGroup('agency').get();
        print('Total agency ${querySnapshot.docs.length}');

        for (var doc in querySnapshot.docs) {
          if (doc.data().isNotEmpty) {
            var agency = Agency.fromMap(doc.data());
            agencys.add(agency);
          } else {
            print('Empty document found with ID: ${doc.id}');
          }
        }
        return agencys;
      } catch (e) {
        rethrow;
      }
    } else if (userRole == 'local') {
      try {
        var docSnapshot = await db.collection('agency').doc(userId).get();
        print('Total agency: ${docSnapshot.exists ? 1 : 0}');
        if (docSnapshot.exists) {
          var agency = Agency.fromMap(docSnapshot.data()!);
          agencys.add(agency);
        } else {
          print('No agency document found for userId: $userId');
        }

        return agencys;
      } catch (e) {
        rethrow;
      }
    } else if (userRole == 'regional') {
      try {
        var querySnapshot = await db
            .collection('agency')
            .doc(userId)
            .collection('agency')
            .get();
        print('Total documents in agency: ${querySnapshot.docs.length}');
        for (var doc in querySnapshot.docs) {
          var agency = Agency.fromMap(doc.data());
          agencys.add(agency);
          //print('Subdocument data: ${doc.data()}');
        }

        return agencys;
      } catch (e) {
        rethrow;
      }
    }
    return agencys;
  }
}
