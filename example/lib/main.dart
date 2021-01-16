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
    'Yagura castle building animation': (context) =>
        _showPage(context, _CastleBuildingAnimation()),
    'Tsume (5手詰)': (context) => _showPage(context, _Tsume()),
    'KIF Viewer': (context) => _showPage(context, _KIFViewer()),
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
  _CastleBuildingAnimationState createState() =>
      _CastleBuildingAnimationState();
}

class _CastleBuildingAnimationState extends State<_CastleBuildingAnimation> {
  List<Move> moves;
  GameBoard gameBoard;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    final game = '''
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
''';
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
      () => gameBoard =
          ShogiUtils.stringArrayToGameBoard(StaticGameBoards.yagura),
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
    final boardPieces = [
      ...ShogiUtils.stringArrayToBoardPiecesArray([
        '☗:S-14',
        '☗:+R-53',
        '☖:K-24',
        '☖:G-16',
      ]),
      BoardPiece(
          player: PlayerType.sente, pieceType: PieceType.gold, position: null),
      BoardPiece(
          player: PlayerType.sente,
          pieceType: PieceType.silver,
          position: null),
    ];
    final gameBoard = GameBoard(boardPieces: boardPieces);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ShogiBoard(
            gameBoard: gameBoard,
            style: ShogiBoardStyle(
              cellColor: BoardColors.brown,
              showCoordIndicators: false,
            ),
          ),
        ),
      ),
    );
  }
}

class _KIFViewer extends StatefulWidget {
  _KIFViewer({Key key}) : super(key: key);

  @override
  _KIFViewerState createState() => _KIFViewerState();
}

class _KIFViewerState extends State<_KIFViewer> {
  List<GameBoard> _game;
  int _currentIndex = 0;

  GameBoard get _gameBoard => _game[_currentIndex];
  bool get _canSkipStart => _currentIndex != 0;
  bool get _canRewind => _currentIndex > 0;
  bool get _canFastForward => _currentIndex < _game.length - 1;
  bool get _canSkipEnd => _currentIndex != _game.length - 1;

  @override
  void initState() {
    super.initState();

    final game = '''
手合割：平手
先手：
後手：

手数----指手----消費時間--
   1 ７六歩(77)
   2 ３四歩(33)
   3 ２二角成(88)
   4 同　銀(31)
   5 １五角打
''';
    final moves = KIFNotationConverter().movesFromFile(game);
    _game = [ShogiUtils.initialBoard];
    for (final move in moves) {
      _game.add(
        GameEngine.makeMove(_game.last, move),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                '''
1 ７六歩(77)
2 ３四歩(33)
3 ２二角成(88)
4 同　銀(31)
5 １五角打''',
              ),
              Expanded(
                child: ShogiBoard(
                  gameBoard: _gameBoard,
                  showPiecesInHand: false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: _canSkipStart
                        ? () => setState(() => _currentIndex = 0)
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.fast_rewind),
                    onPressed: _canRewind
                        ? () => setState(() => _currentIndex--)
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.fast_forward),
                    onPressed: _canFastForward
                        ? () => setState(() => _currentIndex++)
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: _canSkipEnd
                        ? () => setState(() => _currentIndex = _game.length - 1)
                        : null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
