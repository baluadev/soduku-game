import 'dart:math';

import 'core.dart';
import 'tools.dart';

enum Level { eggshell, cracked, chick, fledgeling, wiseowl }

Sudoku generate({Level level = Level.eggshell}) {
  // level to dig hole count
  int digHoleCount = 30;
  switch (level) {
    case Level.eggshell:
      digHoleCount = 30;
      break;
    case Level.cracked:
      digHoleCount = 38;
      break;
    case Level.chick:
      digHoleCount = 45;
      break;
    case Level.fledgeling:
      digHoleCount = 50;
      break;
    case Level.wiseowl:
      digHoleCount = 55;
      break;
    default:
      break;
  }

  return _generate(digHoleCount);
}

Sudoku _generate(int digHoleCount) {
  List<int> randCenterZoneIndexes =
      shuffle(List.generate(9, (index) => index + 1)).cast<int>();
  List<int> simplePuzzle = List.generate(81, (index) => index);
  for (int i = 0; i < simplePuzzle.length; ++i) {
    if (Matrix.getZone(index: i) == 4) {
      simplePuzzle[i] = randCenterZoneIndexes.removeAt(0);
    } else {
      simplePuzzle[i] = -1;
    }
  }
  Sudoku sudoku = new Sudoku(simplePuzzle);
  Sudoku? generatedSudoku = _internalGenerate(sudoku.solution, digHoleCount);
  if (generatedSudoku != null) {
    return generatedSudoku;
  }
  // reduce the difficulty
  print("reduce the difficulty ${digHoleCount} => ${digHoleCount - 2}");
  return _generate(digHoleCount - 2);
}

Sudoku? _internalGenerate(List<int> digHolePuzzle, int digHoleCount) {
  List<int> candidateIndexes;
  // fixedPosition should each by zone and calculate by random index and sort them
  Random rand = Random();
  List fixedPositions =
      List.generate(9, (zone) => Matrix.getIndexByZone(zone, rand.nextInt(9)))
          .cast<int>();

  // candidateIndexes = List.generate(81,(idx)=>idx);
  // for(final (i,fixedPosition) in fixedPositions.indexed){
  //   candidateIndexes.removeAt(fixedPosition-i);
  // }

  candidateIndexes = [];
  fixedPositions.sort();
  for (int i = 0; i < 81; ++i) {
    if (fixedPositions.isNotEmpty && fixedPositions.first == i) {
      fixedPositions.removeAt(0);
      continue;
    }
    candidateIndexes.add(i);
  }
  candidateIndexes = shuffle(candidateIndexes).cast<int>();

  int digHoleFulfill = 0;
  int old = -1, index = 0;
  for (int i = 0; i < candidateIndexes.length; ++i) {
    index = candidateIndexes[i];
    old = digHolePuzzle[index];
    digHolePuzzle[index] = -1;
    try {
      new Sudoku(digHolePuzzle, strict: true);
      digHoleFulfill++;
    } catch (e) {
      digHolePuzzle[index] = old;
    }
    if (digHoleFulfill >= digHoleCount) {
      break;
    }
  }

  return digHoleFulfill >= digHoleCount ? new Sudoku(digHolePuzzle) : null;
}
