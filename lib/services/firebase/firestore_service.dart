import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sudoku/models/user_profile.dart';

class FirestoreService {
  static final FirestoreService inst = FirestoreService._internal();
  FirestoreService._internal();

  final _firestore = FirebaseFirestore.instance;

  Future<void> updateLeaderboard() async {
    final profile = UserService.inst.getProfile();
    final docRef = _firestore.collection('leaderboard').doc(profile!.id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        transaction.set(docRef, {
          'username': profile.name,
          'totalGames': UserService.inst.totalGames(),
          'winGames': UserService.inst.winGames(),
          'stars': UserService.inst.totalStars(),
          'lastPlayed': DateTime.now(),
        });
      } else {
        transaction.update(docRef, {
          'totalGames': UserService.inst.totalGames(),
          'winGames': UserService.inst.winGames(),
          'stars': UserService.inst.totalStars(),
          'lastPlayed': DateTime.now(),
        });
      }
    });
  }

  Future<List<Map<String, dynamic>>> getTopByStars({int limit = 10}) async {
    final querySnapshot = await _firestore
        .collection('leaderboard')
        .orderBy('stars', descending: true)
        .limit(limit)
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        "userId": doc.id,
        ...doc.data(),
      };
    }).toList();
  }

  Future<int> getMyRank() async {
    final profile = UserService.inst.getProfile();
    final userDoc =
        await _firestore.collection('leaderboard').doc(profile!.id).get();

    if (!userDoc.exists) return -1;

    final myStars = userDoc.data()?['stars'] ?? 0;

    // Đếm số user có stars lớn hơn bạn
    final higherRank = await _firestore
        .collection('leaderboard')
        .where('stars', isGreaterThan: myStars)
        .get();

    int rank = higherRank.docs.length + 1;
    return rank;
  }
}
