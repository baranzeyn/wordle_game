import 'dart:math';

class WordleGame {
  List<String> guessedWords = []; // Eklenen liste
  int rowId = 0;
  int letterId = 0;
  String game_message = "";
  String game_guess = "";
  static List<String> word_list = [
    "WORLD",
    "FIGHT",
    "BRAIN",
    "PLANE",
    "EARTH",
    "ROBOT"
  ];
  bool gameOver = false;

  // Setting the game row
  List<Letter> wordleRow = List.generate(
    5,
        (index) => Letter("", 0),
  );

  // Setting the gameBoard
  List<List<Letter>> wordleBoard = List.generate(
    5,
        (index) => List.generate(
      5,
          (index) => Letter("", 0),
    ),
  );

  // Initialize the game
  void initGame() {
    final random = Random();
    int index = random.nextInt(word_list.length);
    game_guess = word_list[index].toUpperCase();
    print("Game guess: $game_guess"); // Debugging

    // Reset game state
    gameOver = false;
    rowId = 0;
    letterId = 0;
    wordleBoard = List.generate(
      5,
          (index) => List.generate(
        5,
            (index) => Letter("", 0),
      ),
    );
  }

  // Pass a try (move to the next row)
  void passTry() {
    print("Passing try. Current rowId: $rowId"); // Debugging
    if (rowId < 4) {
      rowId++;
      letterId = 0;
    } else {
      gameOver = true;
      game_message = "Game Over!";
    }
  }

  // Insert a letter into the board
  void insertLetter(int index, String letter) {
    if (index >= 0 && index < 5) {
      wordleBoard[rowId][index] = Letter(letter, 0);
    }
  }

  // Check if the word exists in the word list
  bool checkWordExist(String word) {
    bool exists = word_list.contains(word.toUpperCase());
    print("Checking if '$word' exists: $exists"); // Debugging
    return exists;
  }

  // Check if the guessed word is the same as the current game word
  bool checkWordIsNotCurrentGameWord(String word) {
    return word.toUpperCase() != game_guess;
  }



  // Validate the current guess with color codes
  void validateGuess() {
    String guess = getCurrentRowWord();

    if (guess.length != game_guess.length) {
      game_message = "Invalid guess length!";
      return;
    }

    if (checkWordExist(guess)) {
      if (guess == game_guess) {
        // Doğru tahmin
        game_message = "Congratulations! You've guessed the word!";
        gameOver = true;
        guessedWords.add(guess); // Doğru tahmini ekleyin

        // Kutuları yeşil renkte gösterin
        for (int i = 0; i < guess.length; i++) {
          wordleBoard[rowId][i].code = 1; // Doğru harf doğru pozisyonda
        }
      } else {
        // Yanlış tahmin
        if (!guessedWords.contains(guess)) {
          guessedWords.add(guess); // Tahmin edilen kelimeyi ekleyin
        }

        List<bool> checked = List.generate(guess.length, (index) => false);

        // İlk geçiş: Doğru pozisyondaki doğru harfleri kontrol et (yeşil)
        for (int i = 0; i < guess.length; i++) {
          String char = guess[i].toUpperCase();
          if (game_guess[i] == char) {
            wordleBoard[rowId][i].code = 1; // Doğru harf doğru pozisyonda
            checked[i] = true; // Bu harfi doğru pozisyon olarak işaretleyin
          }
        }

        // İkinci geçiş: Yanlış pozisyondaki doğru harfleri kontrol et (amber)
        for (int i = 0; i < guess.length; i++) {
          String char = guess[i].toUpperCase();
          if (!checked[i] && game_guess.contains(char)) {
            wordleBoard[rowId][i].code = 2; // Doğru harf yanlış pozisyonda
          } else if (!checked[i]) {
            wordleBoard[rowId][i].code = 3; // Yanlış harf
          }
        }

        passTry();
        game_message = "Try again!";
      }
    } else {
      game_message = "The word does not exist. Try again!";
    }
  }




  // Get the current row as a word string
  String getCurrentRowWord() {
    return wordleBoard[rowId]
        .map((letter) => letter.letter ?? "")
        .join();
  }

  // Check if a letter is in the correct position
  bool isLetterInCorrectPosition(String letter) {
    int index = getCurrentRowWord().indexOf(letter);
    return index != -1 && game_guess[index] == letter.toUpperCase();
  }

  // Check if a letter is in the wrong position
  bool isLetterInWrongPosition(String letter) {
    return game_guess.contains(letter.toUpperCase()) &&
        !isLetterInCorrectPosition(letter);
  }
}

class Letter {
  String? letter;
  int code = 0; // 0 = default, 1 = green, 2 = amber, 3 = gray

  Letter(this.letter, this.code);
}
