import 'dart:convert';

import 'package:sudoku/configs/const.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/models/user_profile.dart';
import 'package:http/http.dart' as http;

class FunctionsService {
  static final FunctionsService inst = FunctionsService._internal();
  FunctionsService._internal();
  Future<String?> registerProfile(String name, String fcmToken) async {
    try {
      var url = Uri.https(baseUrl, 'register');
      var response = await http.post(url, body: {
        'username': name,
        'fcmToken': fcmToken,
      });
      if (response.statusCode != 200) {
        return null;
      }
      final data = jsonDecode(response.body);
      log.i(data);
      return data['userId'] as String?;
    } catch (e) {
      log.e(e.toString());
      return null;
    }
  }

  Future<void> updateLeaderboard() async {
    final profile = UserService.inst.getProfile();
    try {
      var url = Uri.https(baseUrl, 'leaderboard');
      await http.post(url, body: {
        'username': profile!.name,
        'userId': profile.id,
        'totalGames': UserService.inst.totalGames(),
        'winGames': UserService.inst.winGames(),
        'stars': UserService.inst.totalStars(),
      });
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<int> getUserRank() async {
    final profile = UserService.inst.getProfile();
    try {
      var url = Uri.https(baseUrl, 'leaderboard/${profile!.id}');
      var response = await http.get(url);
      log.i('Get rank response: ${response.body}');
      if (response.statusCode != 200) {
        return -1;
      }
      final data = jsonDecode(response.body);
      return data['profile']['rank'] as int;
    } catch (e) {
      return -1;
    }
  }
}
