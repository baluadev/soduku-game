import 'package:hive/hive.dart';
import 'package:sudoku/sudoku_dart/lib/sudoku_dart.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 10)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int totalPoints; // điểm thưởng để hồi sinh, thêm tip

  @HiveField(2)
  int gamesPlayed;

  @HiveField(3)
  int gamesWon;

  @HiveField(4)
  int gamesLost;

  @HiveField(5)
  bool? removeAds;

  @HiveField(6)
  bool? darkMode;

  @HiveField(7)
  bool? enableSound;

  UserProfile({
    required this.name,
    this.totalPoints = 0,
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.gamesLost = 0,
    this.removeAds = false,
    this.darkMode = false,
    this.enableSound = false,
  });
}

@HiveType(typeId: 11)
class GameHistory extends HiveObject {
  @HiveField(0)
  Level level;

  @HiveField(1)
  bool isWin;

  @HiveField(2)
  Duration timeTaken;

  @HiveField(3)
  DateTime playedAt;

  @HiveField(4)
  int rewardPoints;

  GameHistory({
    required this.level,
    required this.isWin,
    required this.timeTaken,
    required this.playedAt,
    required this.rewardPoints,
  });
}

class UserService {
  static final UserService inst = UserService._internal();
  factory UserService() => inst;
  UserService._internal();

  static const userProfileBox = 'user_profile_box';
  static const gameHistoryBox = 'game_history_box';

  late Box<UserProfile> _profileBox;
  late Box<GameHistory> _historyBox;

  Future<void> init() async {
    _profileBox = await Hive.openBox<UserProfile>(userProfileBox);
    _historyBox = await Hive.openBox<GameHistory>(gameHistoryBox);
  }

  // Lấy user profile
  UserProfile? getProfile() {
    if (_profileBox.isEmpty) return null;
    return _profileBox.getAt(0);
  }

  // Tạo mới user profile
  Future<void> createProfile(String name) async {
    final profile = UserProfile(name: name);
    await _profileBox.clear();
    await _profileBox.add(profile);
  }

  //darkMode
  bool darkMode() {
    final profile = getProfile();
    return profile?.darkMode ?? false;
  }

  void toogleDarkMode(bool value) {
    final profile = getProfile();
    if (profile != null) {
      profile.darkMode = value;
      profile.save();
    }
  }

  //sound
  bool enableSound() {
    final profile = getProfile();
    return profile?.enableSound ?? false;
  }

  void toogleEnableSound(bool value) {
    final profile = getProfile();
    if (profile != null) {
      profile.enableSound = value;
      profile.save();
    }
  }

  //remove ads
  bool isAdsRemoved() {
    final profile = getProfile();
    return profile?.removeAds ?? false;
  }

  void setAdsRemoved(bool value) {
    final profile = getProfile();
    if (profile != null) {
      profile.removeAds = value;
      profile.save();
    }
  }

  // Cập nhật khi hoàn thành ván
  Future<void> addGameResult({
    required Level level,
    required bool isWin,
    required Duration timeTaken,
    int rewardPoints = 0,
  }) async {
    final history = GameHistory(
      level: level,
      isWin: isWin,
      timeTaken: timeTaken,
      playedAt: DateTime.now(),
      rewardPoints: rewardPoints,
    );

    await _historyBox.add(history);

    final profile = getProfile();
    if (profile != null) {
      profile.gamesPlayed += 1;
      if (isWin) {
        profile.gamesWon += 1;
        profile.totalPoints += rewardPoints;
      } else {
        profile.gamesLost += 1;
      }
      await profile.save();
    }
  }

  List<GameHistory> getHistory() {
    return _historyBox.values.toList();
  }
}
