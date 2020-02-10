import 'package:flutter/material.dart';
import 'package:flutter_shogi_board/flutter_shogi_board.dart';
import 'package:shogi/shogi.dart';

void main() {
  runApp(
    MaterialApp(
      home: _Demo(),
    ),
  );
}

class _Demo extends StatefulWidget {
  _Demo({Key key}) : super(key: key);

  @override
  __DemoState createState() => __DemoState();
}

class __DemoState extends State<_Demo> {
  List<Move> moves;
  List<BoardPiece> boardPieces;

  @override
  void initState() {
    super.initState();

    String game = """
1: ☗P77-76
2: ☗S79-68
3: ☗S68-77
4: ☗G69-78
5: ☗P57-56
6: ☗K59-69
7: ☗G49-58
8: ☗B88-79
9: ☗P67-66
10: ☗G58-67
11: ☗B79-68
12: ☗K69-79
13: ☗K79-88
""";
    moves = CustomNotationConverter().movesFromFile(game);
    boardPieces = ShogiUtils.stringArrayToBoardPiecesArray(GameBoards.initialBoardSente);

    playSequence();
  }

  Future<void> playSequence() async {
    final duration = Duration(seconds: 2);

    await Future.delayed(duration);

    for (final move in moves) {
      setState(() {
        boardPieces = GameEngine.makeMove(boardPieces, move);
      });

      await Future.delayed(duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ShogiBoard(
            boardPieces: boardPieces,
          ),
        ),
      ),
    );
  }
}
