import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wordle_clone/logic/guess_provider.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'A winner is you!',
              style: TextStyle(
                fontSize: 72,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            child: const SizedBox(
              width: 300,
              height: 88,
              child: Center(
                child: Text(
                  'New game',
                  style: TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
            ),
            onPressed: context.read<GuessProvider>().newGame,
          ),
        ],
      ),
    );
  }
}
