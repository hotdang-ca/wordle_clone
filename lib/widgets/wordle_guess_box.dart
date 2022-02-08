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

  double _findAppropriateWidthForContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 414.0) {
      return 60.0;
    }

    return 100.0;
  }

  double _findAppropriateHeightForContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 414.0) {
      return 72.0;
    }

    return 110.0;
  }

  @override
  Widget build(BuildContext context) {
    final double _scaleAppropriateWidth =
        _findAppropriateWidthForContext(context);
    final double _scaleAppropriateHeight =
        _findAppropriateHeightForContext(context);

    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(color: Colors.blueGrey, width: 1),
      color: _colorForWordlePositionResult(result),
    );

    TextStyle textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 48.0,
    );

    return SizedBox(
      width: _scaleAppropriateWidth,
      height: _scaleAppropriateHeight,
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
