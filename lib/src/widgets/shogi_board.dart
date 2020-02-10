import 'package:flutter/material.dart';
import 'package:shogi/shogi.dart';

import '../configs/board_colors.dart';
import '../utils/package_utils.dart';
import '../widgets/board_cell.dart';
import '../widgets/coord_indicator_cell.dart';

/// Renders a shogi board using a list of board pieces
class ShogiBoard extends StatelessWidget {
  /// A list of board pieces
  final List<BoardPiece> boardPieces;

  /// The color of each standard piece on the board
  final Color pieceColor;

  /// The color of each promoted piece on the board
  final Color promotedPieceColor;

  /// The color of each cell on the board
  final Color cellColor;

  /// The color of each cell's border
  final Color borderColor;

  /// Whether japanese characters (i.e. 玉) or latin letters (i.e. K) should be used. Defaults to `true`.
  final bool usesJapanese;

  /// Whether coordinate indicators (on top and right of board) should be shown. Defaults to `true`.
  final bool showCoordIndicators;

  /// The type of coordinate indicators show. Defaults to `CoordIndicatorType.japanese`.
  final CoordIndicatorType coordIndicatorType;

  const ShogiBoard({
    @required this.boardPieces,
    this.pieceColor = BoardColors.black,
    this.promotedPieceColor = BoardColors.red,
    this.cellColor = Colors.transparent,
    this.borderColor = BoardColors.gray,
    this.usesJapanese = true,
    this.showCoordIndicators = true,
    this.coordIndicatorType = CoordIndicatorType.japanese,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberRows = showCoordIndicators ? BoardConfig.numberRows + 1 : BoardConfig.numberRows;
    final numberColumns = showCoordIndicators ? BoardConfig.numberColumns + 1 : BoardConfig.numberColumns;

    return LayoutBuilder(
      builder: (_, constraints) {
        final size = (constraints.hasBoundedWidth ? constraints.maxWidth : constraints.maxHeight) / numberRows;

        List<Widget> rows = List<Widget>(numberRows);
        for (int y = 0; y < numberRows; y++) {
          List<Widget> row = List<Widget>(numberColumns);
          for (int x = numberColumns - 1; x >= 0; x--) {
            final boardPiece = PackageUtils.pieceAtPosition(
              boardPieces,
              showCoordIndicators ? y : y + 1,
              showCoordIndicators ? x : x + 1,
            );

            row[numberColumns - 1 - x] = showCoordIndicators && (y == 0 || x == 0)
                ? CoordIndicatorCell(
                    size: size, coord: y == 0 ? x : y, isTop: y == 0, coordIndicatorType: coordIndicatorType)
                : BoardCell(
                    boardPiece: boardPiece?.displayString(usesJapanese: usesJapanese) ?? '',
                    sente: boardPiece?.isSente ?? true,
                    size: size,
                    edge: Edge(
                      top: y == (showCoordIndicators ? 1 : 0),
                      bottom: y == numberRows - 1,
                      left: x == numberColumns - 1,
                      right: x == (showCoordIndicators ? 1 : 0),
                    ),
                    pieceColor: boardPiece != null ? (boardPiece.isPromoted ? promotedPieceColor : pieceColor) : null,
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
