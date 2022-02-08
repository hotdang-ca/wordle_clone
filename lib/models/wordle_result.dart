import 'dart:math';

import 'package:wordle_clone/models/word_list.dart';

enum WordlePositionResult {
  present,
  correct,
  absent,
}

/// At the start of the game, this will hold a word, and provide
/// methods for which to guess the word.
class WordleResult {
  static bool isWinner(List<WordlePositionResult> result) {
    return result.every((e) => e == WordlePositionResult.correct);
  }

  final String word;

  WordleResult({required this.word});

  factory WordleResult.fromWordList() {
    return WordleResult(
        word: wordList.elementAt(Random().nextInt(wordList.length - 1)));
  }

  List<WordlePositionResult> guessResult(String guess) {
    if (guess.length != 5) {
      throw ('Incorrect length.');
    }

    var wordleResult = <WordlePositionResult>[
      WordlePositionResult.absent,
      WordlePositionResult.absent,
      WordlePositionResult.absent,
      WordlePositionResult.absent,
      WordlePositionResult.absent,
    ];

    // Check for exact matches
    for (int x = 0; x < guess.length; x++) {
      String evaluatedLetter = String.fromCharCode(guess.codeUnitAt(x));
      String matchingWordLetter = String.fromCharCode(word.codeUnitAt(x));

      if (evaluatedLetter.toLowerCase() == matchingWordLetter.toLowerCase()) {
        wordleResult[x] = WordlePositionResult.correct;
      }
    }

    // Check for presence
    for (int x = 0; x < guess.length; x++) {
      if (wordleResult[x] == WordlePositionResult.correct) {
        continue;
      }

      String evaluatedLetter = String.fromCharCode(guess.codeUnitAt(x));

      if (word.contains(evaluatedLetter)) {
        wordleResult[x] = WordlePositionResult.present;
      }
    }

    return wordleResult;
  }

  // @override
  // String toString() {
  //   /// TODO: returns a string representing all guesses
  //   // const String absent = '⬜';
  //   // const String present = '🟨';
  //   // const String correct = '🟩';

  //   return super.toString();
  // }
}
