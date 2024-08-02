import 'package:flutter/material.dart';
import 'package:word_game/utilities/game_provider.dart';
import 'package:word_game/widgets/game_keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late WordleGame _game;

  @override
  void initState() {
    super.initState();
    _game = WordleGame(); // Initialize the game instance
    _game.initGame(); // Call initGame on the instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Wordle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          GameKeyboard(_game), // Pass the initialized game instance
        ],
      ),
    );
  }
}
