import 'dart:convert';

import 'package:sudoku/configs/const.dart';
import 'package:sudoku/main.dart';
import 'package:sudoku/models/user_profile.dart';
import 'package:http/http.dart' as http;

class Network {
  static final Network inst = Network._internal();
  Network._internal();

  Future<String?> registerProfile(String name, String fcmToken) async {
    try {
      var url = Uri.https(baseUrl, 'register');
      var response = await http.post(url, body: {
        'username': name,
        'fcmToken': fcmToken,
      });
      final data = jsonDecode(response.body);
      log.i(data);
      if (response.statusCode != 200) {
        return data['message'] ?? 'Contact Admin';
      }
      final userId = data['userId'] as String;
      final profile = UserProfile(
        id: userId,
        name: name,
        fcmToken: fcmToken,
      );

      await Future.wait([
        UserService.inst.profileBox.clear(),
        UserService.inst.profileBox.add(profile),
      ]);
      await updateLeaderboard();
      return null;
    } catch (e) {
      final eTxt = e.toString();
      return eTxt;
    }
  }

  Future<void> updateLeaderboard() async {
    final profile = UserService.inst.getProfile();
    try {
      var url = Uri.https(baseUrl, 'leaderboard');
      final resp = await http.post(url, body: {
        'username': profile!.name,
        'userId': profile.id,
        'totalGames': 0, //UserService.inst.totalGames(),
        'winGames': 0, //UserService.inst.winGames(),
        'stars': 0, //UserService.inst.totalStars(),
      });
      log.i(resp.body);
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
