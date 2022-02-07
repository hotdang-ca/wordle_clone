import 'package:flutter_test/flutter_test.dart';
import 'package:wordle_clone/models/word_list.dart';

import 'package:wordle_clone/models/wordle_result.dart';

void main() {
  group('Guesses', () {
    test('It guesses all wrong', () {
      final wordle = WordleResult(word: 'djhbs');
      final guess = wordList.first; // 'cigar'
      final wordleResult = wordle.guessResult(guess);

      expect(wordleResult, <WordlePositionResult>[
        WordlePositionResult.absent,
        WordlePositionResult.absent,
        WordlePositionResult.absent,
        WordlePositionResult.absent,
        WordlePositionResult.absent
      ]);
    });

    test('It guesses all present', () {
      final wordle = WordleResult(word: 'raigc');
      final guess = wordList.first; // 'cigar'
      final wordleResult = wordle.guessResult(guess);

      expect(wordleResult, <WordlePositionResult>[
        WordlePositionResult.present,
        WordlePositionResult.present,
        WordlePositionResult.present,
        WordlePositionResult.present,
        WordlePositionResult.present
      ]);
    });

    test('It guesses all correct', () {
      final wordle = WordleResult(word: 'cigar');
      final guess = wordList.first; // 'cigar'
      final wordleResult = wordle.guessResult(guess);

      expect(wordleResult, <WordlePositionResult>[
        WordlePositionResult.correct,
        WordlePositionResult.correct,
        WordlePositionResult.correct,
        WordlePositionResult.correct,
        WordlePositionResult.correct
      ]);
    });
  });
}
