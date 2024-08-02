import 'package:flutter/material.dart';
import 'package:word_game/utilities/game_provider.dart';
import 'package:word_game/widgets/game_board.dart';

class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  final WordleGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  final List<String> row1 = "QWERTYUIOP".split("");
  final List<String> row2 = "ASDFGHJKL".split("");
  final List<String> row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.game.game_message, // Access game_message through widget.game
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 20.0),
        GameBoard(widget.game),
        SizedBox(height: 40.0),
        buildKeyboardRow(row1),
        SizedBox(height: 10.0),
        buildKeyboardRow(row2),
        SizedBox(height: 10.0),
        buildKeyboardRow(row3),
      ],
    );
  }

  Widget buildKeyboardRow(List<String> row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: row.map((key) {
        Color keyColor = _getKeyColor(key);

        return InkWell(
          onTap: () {
            handleKeyPress(key);
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: keyColor,
            ),
            child: Text(
              key,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ensure text is visible
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getKeyColor(String key) {
    if (key.length == 1) {
      // Check the color based on the letter status
      Color color = Colors.grey.shade300; // Default color

      for (int i = 0; i < 5; i++) {
        if (widget.game.wordleBoard[i].any((letter) => letter.letter == key)) {
          switch (widget.game.wordleBoard[i].firstWhere((letter) => letter.letter == key).code) {
            case 1:
              color = Colors.green; // Correct letter in correct position
              break;
            case 2:
              color = Colors.amber; // Correct letter in wrong position
              break;
            case 3:
              color = Colors.grey; // Incorrect letter
              break;
          }
          break; // Exit loop once the color is determined
        }
      }

      return color;
    } else {
      // Return default color for action keys like DEL and SUBMIT
      return Colors.grey.shade300;
    }
  }

  void handleKeyPress(String key) {
    print(key);

    if (key == "DEL") {
      if (widget.game.letterId > 0) {
        setState(() {
          widget.game.insertLetter(widget.game.letterId - 1, "");
          widget.game.letterId--;
        });
      }
    } else if (key == "SUBMIT") {
      if (widget.game.letterId >= 5) {
        setState(() {
          widget.game.validateGuess();
        });
      }
    } else {
      if (widget.game.letterId < 5) {
        setState(() {
          widget.game.insertLetter(widget.game.letterId, key);
          widget.game.letterId++;
        });
      }
    }
  }
}
