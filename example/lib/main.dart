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
    'Tsume (5手詰)': (context) => _showPage(context, _Tsume()),
    'Proverb': (context) => _showPage(context, _Proverb()),
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
    final boardPieces = [
      ...ShogiUtils.stringArrayToBoardPiecesArray([
        '☗:S-14',
        '☗:+R-53',
        '☖:K-24',
        '☖:G-16',
      ]),
      BoardPiece(player: PlayerType.sente, pieceType: PieceType.gold, position: null),
      BoardPiece(player: PlayerType.sente, pieceType: PieceType.silver, position: null),
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

class _Proverb extends StatelessWidget {
  const _Proverb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avoid a Sitting King'),
      ),
      body: DefaultShogiBoardStyle(
        style: ShogiBoardStyle(
          maxSize: 400,
          coordIndicatorType: CoordIndicatorType.arabic,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 16),
                Text(
                    'It is extremely dangerous to start fighting with the King sitting on the original square. In Diagram 1, Black has already advanced a Silver onto 4f with his King in the original position. If he wants to launch an attack from here, how would he play?'),
                Container(height: 16),
                _SFENBoard(
                  sfenString: 'ln3k1nl/1r3bg2/p1ppsgspp/1p2ppp2/7P1/2PPPSP2/PPS2P2P/2G1G2R1/LNB1k2NL b -',
                  label: 'Diagram 1',
                  // showPiecesInHand: false,
                ),
                Container(height: 16),
                _MovesList(
                  moves: [
                    'P-3e',
                    'Px3e',
                    'Sx3e',
                    'P*3d',
                    'P-2d',
                    'Px2d',
                    'Sx2d',
                    'Sx2d',
                    'Bx2d',
                    'Bx2d',
                    'Rx2d',
                  ],
                  playerFirstMove: PlayerType.sente,
                ),
                Container(height: 16),
                _SFENBoard(
                  sfenString: 'ln3k1nl/1r4g2/p1ppsg2p/1p2pppR1/9/2PPP4/PPS2P2P/2G1G4/LN2k2NL b bspBS2P',
                  label: 'Diagram 2',
                  showPiecesInHand: true,
                ),
                Container(height: 16),
                Text(
                  '''So far, Black's climbing Silver appears to have made a point. But White has a devastating move to play here.''',
                ),
                Container(height: 8),
                _MovesList(
                  moves: [
                    'B*1e',
                  ],
                  playerFirstMove: PlayerType.gote,
                ),
                Container(height: 8),
                Text(
                    'You cannot be too careful when you have a sitting King. Black had to play K6i first in this case. Then the attack would have been successful.'),
                Container(height: 8),
                Text(
                  'Content taken from http://www.shogi.net/kakugen/.',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Container(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SFENBoard extends StatelessWidget {
  final String sfenString;
  final String label;
  final bool showPiecesInHand;

  const _SFENBoard({
    @required this.sfenString,
    this.label,
    this.showPiecesInHand = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          ShogiBoard(
            gameBoard: ShogiUtils.sfenStringToGameBoard(sfenString),
            showPiecesInHand: showPiecesInHand,
          ),
          if (label != null)
            Column(
              children: <Widget>[
                if (!showPiecesInHand) Container(height: 4),
                Text(label),
              ],
            ),
        ],
      ),
    );
  }
}

class _MovesList extends StatelessWidget {
  final List<String> moves;
  final PlayerType playerFirstMove;

  const _MovesList({
    @required this.moves,
    this.playerFirstMove = PlayerType.sente,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: <Widget>[
          for (int i = 0; i < moves.length; i++)
            Text((i % 2 == 0 && playerFirstMove == PlayerType.sente ? BoardConfig.sente : BoardConfig.gote) + moves[i]),
        ],
      ),
    );
  }
}
