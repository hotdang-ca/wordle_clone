import 'package:flutter/material.dart';
import 'package:wordle_clone/models/wordle_result.dart';

class WordleGuessBox extends StatelessWidget {
  /// margin size
  final marginSize = 6.0;

  /// The guessed letter assigned to this box, or blank
  final String guess;

  final WordlePositionResult? result;

  const WordleGuessBox({
    this.guess = '',
    this.result,
    Key? key,
  }) : super(key: key);

  Color _colorForWordlePositionResult(WordlePositionResult? result) {
    switch (result) {
      case WordlePositionResult.absent:
        return Colors.grey;
      case WordlePositionResult.correct:
        return Colors.green;
      case WordlePositionResult.present:
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(color: Colors.blueGrey, width: 1),
      color: _colorForWordlePositionResult(result),
    );

    TextStyle textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 48.0,
    );

    return SizedBox(
      width: 100,
      height: 110,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(marginSize),
        decoration: boxDecoration,
        child: Text(
          guess,
          style: textStyle,
        ),
      ),
    );
  }
}
