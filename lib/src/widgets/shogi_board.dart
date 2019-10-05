import 'package:flutter/material.dart';

import '../configs/board_config.dart';
import '../models/position.dart';
import '../utils/package_utils.dart';
import '../widgets/board_cell.dart';

/// Renders a shogi board using a list of board pieces
class ShogiBoard extends StatelessWidget {
  /// A list of board pieces
  final List<Position> boardPieces;

  /// The color of each standard piece on the board
  final Color pieceColor;

  /// The color of each cell on the board
  final Color cellColor;

  /// The color of each cell's border
  final Color borderColor;

  /// If `true` uses japanese characters (i.e. 玉), otherwise english letters (i.e. K)
  final bool usesJapanese;

  const ShogiBoard({
    @required this.boardPieces,
    this.pieceColor = Colors.black87,
    this.cellColor = Colors.transparent,
    this.borderColor = Colors.black54,
    this.usesJapanese = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final size =
            (constraints.hasBoundedWidth ? constraints.maxWidth : constraints.maxHeight) / BoardConfig.numberRows;

        List<Widget> rows = List<Widget>(BoardConfig.numberRows);
        for (int y = 0; y < BoardConfig.numberRows; y++) {
          List<Widget> row = List<Widget>(BoardConfig.numberColumns);
          for (int x = BoardConfig.numberColumns - 1; x >= 0; x--) {
            final boardPiece = PackageUtils.pieceAtPosition(boardPieces, x, y);
            row[BoardConfig.numberColumns - 1 - x] = BoardCell(
              boardPiece: boardPiece?.displayString(usesJapanese: usesJapanese) ?? '',
              sente: boardPiece?.isSente ?? true,
              size: size,
              edge: Edge(
                top: y == 0,
                bottom: y == BoardConfig.numberRows - 1,
                left: x == BoardConfig.numberColumns - 1,
                right: x == 0,
              ),
              pieceColor: pieceColor,
              cellColor: cellColor,
              borderColor: borderColor,
            );
          }
          rows[y] = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row,
          );
        }

        return AspectRatio(
          aspectRatio: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rows,
          ),
        );
      },
    );
  }
}
