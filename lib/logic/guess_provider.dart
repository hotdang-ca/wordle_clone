import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle_clone/models/word_list.dart';
import 'package:wordle_clone/models/wordle_result.dart';

class GuessProvider with ChangeNotifier {
  static const maxGuesses = 6;

  late bool isWinner;

  late String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// This guess's word
  late String _currentWordGuess;
  String get currentWordGuess => _currentWordGuess;

  /// Previous word guesses
  late List<String> _previousWordGuesses;
  List<String> get previousWordGuesses => _previousWordGuesses;

  late List<List<WordlePositionResult>> _previousResults;

  /// Current Word
  late WordleResult wordleResult;
  String get currentWord => wordleResult.word;

  /// Current guess word index, zero-indexed
  late int currentGuessIndex;

  /// Current guess
  late int _currentGuess;
  int get currentGuess => _currentGuess;

  GuessProvider() {
    initGame();
  }

  // creates a new game
  void initGame() {
    wordleResult = WordleResult.fromWordList();
    _currentWordGuess = '';
    currentGuessIndex = 0;
    _currentGuess = 0;
    _previousWordGuesses = <String>[];
    _previousResults = <List<WordlePositionResult>>[];
    isWinner = false;
    _errorMessage = null;

    notifyListeners();
  }

  void clearErrors() {
    _errorMessage = null;
    notifyListeners();

    return;
  }

  void takeNextGuess(String word) {
    if (_currentGuess >= maxGuesses) {
      throw ('You took too many guesses.');
    }

    _currentWordGuess = word;
    _currentGuess++;

    notifyListeners();
  }

  String letterForGuessAt(int index) {
    if (index >= currentGuessIndex) {
      // we're guessing out of order. Something bad.
      // throw ('Index greater than currentGuessIndex');
      return '';
    }

    return String.fromCharCode(_currentWordGuess.codeUnitAt(index));
  }

  String letterForPreviousGuessAt(int guessIndex, int letterIndex) {
    if (guessIndex >= currentGuess) {
      return '';
    } // should only happen for future rows

    // since it's a previous word, it will definitely have all indicies for the letter
    String word = previousWordGuesses.elementAt(guessIndex);
    String letter = String.fromCharCode(word.codeUnitAt(letterIndex));

    return letter;
  }

  WordlePositionResult? resultAt(int guessIndex, int letterIndex) {
    if (guessIndex >= currentGuess) {
      return null;
    }

    if (guessIndex >= _previousResults.length) {
      return null;
    }

    List<WordlePositionResult> result = _previousResults.elementAt(guessIndex);
    return result.elementAt(letterIndex);
  }

  void newGame() {
    // same as game init
    // init the game
    initGame();
  }

  void handleKeyEvent(KeyEvent keyEvent) {
    // Not interested
    if (keyEvent is KeyUpEvent) return;

    final logicalKey = keyEvent.logicalKey;

    // listen to 'ENTER' key
    if ([LogicalKeyboardKey.enter, LogicalKeyboardKey.numpadEnter]
        .contains(logicalKey)) {
      // enter was pressed! Do the guess!
      if (currentWord.length > currentGuessIndex) {
        return;
      }

      if (![...uncommonWordList, ...wordList].contains(_currentWordGuess)) {
        _errorMessage = 'That\'s not a real word :p\nTry again.';
        notifyListeners();

        return;
      }

      _previousWordGuesses.add(_currentWordGuess);

      // Get a wordle result
      var guessResult = wordleResult.guessResult(_currentWordGuess);
      _previousResults.add(guessResult);

      isWinner = WordleResult.isWinner(guessResult);

      _currentGuess++;
      currentGuessIndex = 0;
      _currentWordGuess = '';

      notifyListeners();
      return;
    }

    // Listen to 'ESC' key -- cancel a guess
    if (logicalKey == LogicalKeyboardKey.escape) {
      _currentWordGuess = ''; // TODO: create a "new game" method
      currentGuessIndex = 0;

      notifyListeners();
      return;
    }

    // Listen to backspace key -- remove last charater
    if ([LogicalKeyboardKey.backspace, LogicalKeyboardKey.delete]
        .contains(logicalKey)) {
      if (currentGuessIndex == 0) return;

      _currentWordGuess =
          _currentWordGuess.substring(0, _currentWordGuess.length - 1);
      currentGuessIndex--;

      notifyListeners();
      return;
    }

    // TODO: handle numbers/symbols
    if (keyEvent.character == null) {
      // some other control char
      return;
    }

    if (currentGuessIndex >= currentWord.length) {
      return;
    }

    _currentWordGuess =
        '$_currentWordGuess${keyEvent.character!.toLowerCase()}';
    currentGuessIndex++;

    notifyListeners();
  }
}
