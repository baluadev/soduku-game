import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';
import 'package:sudoku/state/sudoku_state.dart';
import 'package:sudoku_dart/sudoku_dart.dart';

/// LocalizationUtils
class LocalizationUtils {
  static String localizationLevelName(BuildContext context, Level level) {
    switch (level) {
      case Level.eggshell:
        return AppLocalizations.of(context)!.levelEggshell;
      case Level.cracked:
        return AppLocalizations.of(context)!.levelCracked;
      case Level.chick:
        return AppLocalizations.of(context)!.levelChick;
      case Level.fledgeling:
        return AppLocalizations.of(context)!.levelFledgeling;
      case Level.wiseowl:
        return AppLocalizations.of(context)!.levelWiseowl;
    }
  }

  static String localizationGameStatus(
      BuildContext context, SudokuGameStatus status) {
    switch (status) {
      case SudokuGameStatus.initialize:
        return AppLocalizations.of(context)!.gameStatusInitialize;
      case SudokuGameStatus.gaming:
        return AppLocalizations.of(context)!.gameStatusGaming;
      case SudokuGameStatus.pause:
        return AppLocalizations.of(context)!.gameStatusPause;
      case SudokuGameStatus.fail:
        return AppLocalizations.of(context)!.gameStatusFailure;
      case SudokuGameStatus.success:
        return AppLocalizations.of(context)!.gameStatusVictory;
    }
  }
}
