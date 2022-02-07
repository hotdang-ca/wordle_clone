import 'package:flutter/material.dart';
import 'package:wordle_clone/logic/guess_provider.dart';
import 'package:wordle_clone/widgets/win_screen.dart';
import 'package:wordle_clone/widgets/wordle_guess_row.dart';
import 'package:provider/provider.dart';

void main() {
  // const WordleApp()
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GuessProvider())],
      child: const WordleApp()));
}

class WordleApp extends StatelessWidget {
  const WordleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordleHome(title: 'Wordle-Clone'),
    );
  }
}

class WordleHome extends StatelessWidget {
  final String title;
  final FocusNode focusNode = FocusNode();

  WordleHome({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWinner = context.watch<GuessProvider>().isWinner;

    FocusScope.of(context).requestFocus(focusNode);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: isWinner
          ? const WinScreen()
          : KeyboardListener(
              focusNode: focusNode,
              autofocus: true,
              onKeyEvent: context.read<GuessProvider>().handleKeyEvent,
              child: Column(
                children: <Widget>[
                  const WordleGuessRow(
                    guessAttempt: 0,
                  ),
                  const WordleGuessRow(
                    guessAttempt: 1,
                  ),
                  const WordleGuessRow(
                    guessAttempt: 2,
                  ),
                  const WordleGuessRow(
                    guessAttempt: 3,
                  ),
                  const WordleGuessRow(
                    guessAttempt: 4,
                  ),
                  const WordleGuessRow(
                    guessAttempt: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          'Guess: ${context.read<GuessProvider>().currentGuess + 1}/${GuessProvider.maxGuesses}\n${context.read<GuessProvider>().currentWordGuess}'),
                      Text(context.read<GuessProvider>().currentWord),
                      Text(
                          'Letter Index: ${context.read<GuessProvider>().currentGuessIndex + 1}/5'),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
