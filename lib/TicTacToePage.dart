import 'package:flutter/material.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({Key? key}) : super(key: key);

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, ''); // Represents the Tic Tac Toe board

  String currentPlayer = 'X'; // Current player's symbol ('X' or 'O')
  bool gameFinished = false; // Flag to track if the game has finished

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back icon is pressed
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Let's Fight!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return _buildGridItem(index);
            },
          ),
          if (gameFinished)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Restart Game'),
              ),
            ),
        ],
      ),
    );
  }

  // Widget for building each grid item in the Tic Tac Toe board
  Widget _buildGridItem(int index) {
    return GestureDetector(
      onTap: () {
        // Handle tapping on the grid item
        if (board[index] == '' && !gameFinished) {
          setState(() {
            // Update the board when a valid move is made
            board[index] = currentPlayer;
            if (_checkWinner()) {
              _showWinnerDialog();
            } else if (_isBoardFull()) {
              _showDrawDialog();
            } else {
              // Switch to the next player's turn
              currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[50],
          border: Border.all(color: Colors.indigo),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(
              fontSize: 40,
              color: (board[index] == 'X') ? Colors.red : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  // Check if there is a winner on the current board
  bool _checkWinner() {
    // Check rows, columns, and diagonals
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        gameFinished = true;
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        gameFinished = true;
        return true;
      }
    }

    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      gameFinished = true;
      return true;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      gameFinished = true;
      return true;
    }

    return false;
  }

  // Check if the Tic Tac Toe board is full (a draw)
  bool _isBoardFull() {
    return !board.contains('');
  }

  // Show a dialog when there is a winner
  void _showWinnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$currentPlayer Wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  // Show a dialog when the game is a draw
  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("It's a Draw!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  // Reset the game to its initial state
  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameFinished = false;
    });
  }
}
