// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 10;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      name: fields[0] as String,
      totalPoints: fields[1] as int,
      gamesPlayed: fields[2] as int,
      gamesWon: fields[3] as int,
      gamesLost: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.totalPoints)
      ..writeByte(2)
      ..write(obj.gamesPlayed)
      ..writeByte(3)
      ..write(obj.gamesWon)
      ..writeByte(4)
      ..write(obj.gamesLost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameHistoryAdapter extends TypeAdapter<GameHistory> {
  @override
  final int typeId = 11;

  @override
  GameHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHistory(
      level: fields[0] as Level,
      isWin: fields[1] as bool,
      timeTaken: fields[2] as Duration,
      playedAt: fields[3] as DateTime,
      rewardPoints: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameHistory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.isWin)
      ..writeByte(2)
      ..write(obj.timeTaken)
      ..writeByte(3)
      ..write(obj.playedAt)
      ..writeByte(4)
      ..write(obj.rewardPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
