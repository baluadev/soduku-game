import 'package:hive/hive.dart';
import 'package:sudoku/sudoku_dart/lib/sudoku_dart.dart';
import 'package:uuid/uuid.dart';

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
  final String id;

  @HiveField(1)
  Level level;

  @HiveField(2)
  bool isWin;

  @HiveField(3)
  String timeTaken;

  @HiveField(4)
  final DateTime startTime;

  @HiveField(5)
  final DateTime endTime;

  @HiveField(6)
  final int lifeUsed;

  @HiveField(7)
  final int hintsUsed;

  @HiveField(8)
  final int starsEarned; // điểm thưởng

  GameHistory({
    required this.id,
    required this.level,
    required this.isWin,
    required this.timeTaken,
    required this.startTime,
    required this.endTime,
    required this.lifeUsed,
    required this.hintsUsed,
    required this.starsEarned,
  });

  GameHistory copyWith({
    bool? isWin,
    String? timeTaken,
    DateTime? endTime,
    int? lifeUsed,
    int? hintsUsed,
    int? starsEarned,
  }) {
    return GameHistory(
      id: this.id,
      level: this.level,
      isWin: isWin ?? this.isWin,
      timeTaken: timeTaken ?? this.timeTaken,
      startTime: this.startTime,
      endTime: endTime ?? this.endTime,
      lifeUsed: lifeUsed ?? this.lifeUsed,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      starsEarned: starsEarned ?? this.starsEarned,
    );
  }
}

class UserService {
  static final UserService inst = UserService._internal();
  factory UserService() => inst;
  UserService._internal();

  static const userProfileBox = 'user_profile_box';
  static const gameHistoryBox = 'game_history_box';

  late Box<UserProfile> profileBox;
  late Box<GameHistory> _historyBox;

  Future<void> init() async {
    profileBox = await Hive.openBox<UserProfile>(userProfileBox);
    _historyBox = await Hive.openBox<GameHistory>(gameHistoryBox);
  }

  // Lấy user profile
  UserProfile? getProfile() {
    if (profileBox.isEmpty) return null;
    return profileBox.getAt(0);
  }

  // Tạo mới user profile
  Future<void> createProfile(String name) async {
    final profile = UserProfile(name: name);
    await profileBox.clear();
    await profileBox.add(profile);
  }

  //darkMode
  bool? darkMode() {
    final profile = getProfile();
    return profile?.darkMode;
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

  Future<void> updateGameResult(
    String id, {
    required bool isWin,
    required String timeTaken,
    required DateTime endTime,
    required int lifeUsed,
    required int hintsUsed,
    required int starsEarned,
  }) async {
    // tìm index của bản ghi có id tương ứng
    final index = _historyBox.values.toList().indexWhere((h) => h.id == id);
    if (index == -1) {
      throw Exception("GameHistory with id $id not found");
    }

    final history = _historyBox.getAt(index);

    if (history != null) {
      final updated = history.copyWith(
        isWin: isWin,
        timeTaken: timeTaken,
        endTime: endTime,
        lifeUsed: lifeUsed,
        hintsUsed: hintsUsed,
        starsEarned: starsEarned,
      );
      await _historyBox.putAt(index, updated);
    }
  }

  Future<String> addGameResult(Level level) async {
    var uuid = Uuid().v1();
    final history = GameHistory(
      id: uuid,
      level: level,
      isWin: false,
      timeTaken: '00:00',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      lifeUsed: 0,
      hintsUsed: 0,
      starsEarned: 0,
    );
    await _historyBox.add(history);
    return uuid;
  }

  GameHistory? getHistoryById(String id) {
    try {
      return _historyBox.values.firstWhere(
        (history) => history.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  List<GameHistory> getAllHistories() {
    try {
      return _historyBox.values.toList();
    } catch (e) {
      return [];
    }
  }
}
