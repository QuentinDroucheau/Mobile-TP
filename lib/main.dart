import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MysteryNumberApp());
}

class MysteryNumberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MysteryNumberScreen(),
    );
  }
}

class MysteryNumberScreen extends StatefulWidget {
  @override
  _MysteryNumberScreenState createState() => _MysteryNumberScreenState();
}

class _MysteryNumberScreenState extends State<MysteryNumberScreen> {
  int _mysteryNumber = 0;
  int _guess = 0;
  String _message = "";

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    Random random = Random();
    _mysteryNumber = random.nextInt(100) + 1;
    _guess = 0;
    _message = 'Guess the number!';
  }

  void _checkGuess() {
    if (_guess == 0) {
      _message = 'Please enter a number.';
    } else if (_guess < _mysteryNumber) {
      _message = 'Too low! Try again.';
    } else if (_guess > _mysteryNumber) {
      _message = 'Too high! Try again.';
    } else {
      _message = 'Congratulations! You guessed the number!';
    }
    setState(() {
      _guess = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mystery Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _guess = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Guess'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
