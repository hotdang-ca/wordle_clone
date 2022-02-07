import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wordle_clone/logic/guess_provider.dart';
import 'package:wordle_clone/widgets/wordle_guess_box.dart';

class WordleGuessRow extends StatelessWidget {
  final int guessAttempt;

  const WordleGuessRow({required this.guessAttempt, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var guessProvider = context.watch<GuessProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (idx) => WordleGuessBox(
          guess: guessProvider.currentGuess == guessAttempt
              ? guessProvider.letterForGuessAt(idx)
              : guessProvider.letterForPreviousGuessAt(guessAttempt, idx),
          result: guessProvider.resultAt(guessAttempt, idx),
        ),
      ),
    );
  }
}
