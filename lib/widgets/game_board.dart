import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_game/utilities/game_provider.dart';



class GameBoard extends StatelessWidget {
  final WordleGame game;
  GameBoard(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
            (row) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
                (col) {
              final letter = game.wordleBoard[row][col];
              Color boxColor;

              switch (letter.code) {
                case 1:
                  boxColor = Colors.green; // Doğru pozisyondaki doğru harf
                  break;
                case 2:
                  boxColor = Colors.amber; // Yanlış pozisyondaki doğru harf
                  break;
                case 3:
                  boxColor = Colors.grey; // Yanlış harf
                  break;
                default:
                  boxColor = Colors.black12; // Varsayılan renk
                  break;
              }

              return Container(
                margin: EdgeInsets.all(4.0),
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    letter.letter ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
