import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({
    Key? key,
  }) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  var tiles = List.filled(9, 0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
      )),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              result(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: [
                      for (var i = 0; i < 9; i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              tiles[i] = 1;
                              runAi();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: Colors.red.shade100,
                              child: Center(
                                  child: Text(tiles[i] == 0
                                      ? ''
                                      : tiles[i] == 1
                                          ? 'X'
                                          : 'O')),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      tiles = List.filled(9, 0);
                    });
                  },
                  child: Text(
                    'Restart',
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Text result() {
    return Text(
      isWinning(1, tiles)
          ? 'You won!'
          : isWinning(2, tiles)
              ? 'You lost !'
              : '',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isWinning(1, tiles)
              ? Colors.green
              : isWinning(2, tiles)
                  ? Colors.red
                  : Colors.black),
    );
  }

  void runAi() async {
    await Future.delayed(Duration(milliseconds: 200));
    int? winning;
    int? blocking;
    int? normal;
    for (var i = 0; i < 9; i++) {
      var val = tiles[i];
      if (val > 0) {
        continue;
      }
      var future = [...tiles]..[i] = 2;
      if (isWinning(2, future)) {
        winning = i;
      }
      future[i] = 1;
      if (isWinning(1, future)) {
        blocking = i;
      }
      normal = i;
    }
    var move = winning ?? blocking ?? normal;
    if (move != null) {
      setState(() {
        tiles[move] = 2;
      });
    }
  }

  bool isWinning(int who, List<int> tiles) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
        (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
        (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
        (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
        (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
        (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
        (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
        (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }
}
