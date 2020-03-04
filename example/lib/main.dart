import 'package:flutter/material.dart';
import 'package:flutter_shogi_board/flutter_shogi_board.dart';
import 'package:shogi/shogi.dart';

void main() {
  runApp(
    MaterialApp(
      home: _HomeScreen(),
    ),
  );
}

class _HomeScreen extends StatelessWidget {
  final Map<String, Function(BuildContext)> routes = {
    'Yagura castle building animation': (context) => _showPage(context, _CastleBuildingAnimation()),
    'Tsume (5手詰）': (context) => _showPage(context, _Tsume()),
  };

  static void _showPage(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  _HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_shogi_board'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(routes.keys.toList()[index]),
          trailing: Icon(Icons.navigate_next),
          onTap: () => routes.values.toList()[index](context),
        ),
      ),
    );
  }
}

class _CastleBuildingAnimation extends StatefulWidget {
  _CastleBuildingAnimation({Key key}) : super(key: key);

  @override
  _CastleBuildingAnimationState createState() => _CastleBuildingAnimationState();
}

class _CastleBuildingAnimationState extends State<_CastleBuildingAnimation> {
  List<Move> moves;
  GameBoard gameBoard;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    final game = """
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
    gameBoard = ShogiUtils.initialBoard;

    playSequence();
  }

  @override
  void dispose() {
    _isDisposed = true;

    super.dispose();
  }

  Future<void> playSequence() async {
    final duration = Duration(seconds: 2);

    await Future.delayed(duration);

    for (final move in moves) {
      if (_isDisposed) {
        return;
      }

      setState(
        () => gameBoard = GameEngine.makeMove(gameBoard, move),
      );

      await Future.delayed(duration);
    }

    if (_isDisposed) {
      return;
    }

    setState(
      () => gameBoard = ShogiUtils.stringArrayToGameBoard(StaticGameBoards.yagura),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ShogiBoard(
            gameBoard: gameBoard,
            showPiecesInHand: false,
          ),
        ),
      ),
    );
  }
}

class _Tsume extends StatelessWidget {
  const _Tsume({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameBoard = GameBoard(
      boardPieces: ShogiUtils.stringArrayToBoardPiecesArray([
        '☗:S-14',
        '☗:+R-53',
        '☖:K-24',
        '☖:G-16',
      ]),
      sentePiecesInHand: [
        BoardPiece(player: PlayerType.sente, pieceType: PieceType.gold, position: null),
        BoardPiece(player: PlayerType.sente, pieceType: PieceType.silver, position: null),
      ],
      gotePiecesInHand: [],
    );

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ShogiBoard(
            gameBoard: gameBoard,
            cellColor: BoardColors.brown,
            showCoordIndicators: false,
          ),
        ),
      ),
    );
  }
}
