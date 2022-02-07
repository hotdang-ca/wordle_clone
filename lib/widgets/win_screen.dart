import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Winner is you!',
        style: TextStyle(
          fontSize: 72,
        ),
      ),
    );
  }
}
