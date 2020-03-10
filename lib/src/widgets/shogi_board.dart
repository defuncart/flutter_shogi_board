import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shogi/shogi.dart';

import 'board_cell.dart';
import 'coord_indicator_cell.dart';
import 'default_shogi_board_style.dart';
import 'piece.dart';
import 'piece_in_hand.dart';
import '../configs/board_colors.dart';
import '../extensions/list_extensions.dart';
import '../models/shogi_board_style.dart';

/// Renders a shogi board using a list of board pieces
class ShogiBoard extends StatelessWidget {
  /// The game board to render
  final GameBoard gameBoard;

  /// The (optional) style to render the `ShogiBoard`
  final ShogiBoardStyle style;

  /// Whether pieces in hand should be shown. Defaults to `true`.
  ///
  /// Although this is the expected behavior in a game, in a castle situation it could set to `false`, for example.
  final bool showPiecesInHand;

  const ShogiBoard({
    Key key,
    @required this.gameBoard,
    this.style,
    this.showPiecesInHand = true,
  })  : assert(gameBoard != null),
        assert(showPiecesInHand != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // determine style
    final style = this.style ?? DefaultShogiBoardStyle.of(context).style;

    // determine number of columns and rows depending if coordinates should be shown
    final numberColumns = style.showCoordIndicators ? BoardConfig.numberColumns + 1 : BoardConfig.numberColumns;
    final numberRows = style.showCoordIndicators ? BoardConfig.numberRows + 1 : BoardConfig.numberRows;

    return LayoutBuilder(
      builder: (_, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight) / (numberRows + (showPiecesInHand ? 2 : 0));
        final aspectRatio = numberColumns / (numberRows + (showPiecesInHand ? 2 : 0));

        List<Widget> rows = List<Widget>(numberRows);
        for (int y = 0; y < numberRows; y++) {
          List<Widget> row = List<Widget>(numberColumns);
          for (int x = numberColumns - 1; x >= 0; x--) {
            final boardPiece = gameBoard.boardPieces.pieceAtPosition(
              column: style.showCoordIndicators ? x : x + 1,
              row: style.showCoordIndicators ? y : y + 1,
            );

            row[numberColumns - 1 - x] = style.showCoordIndicators && (y == 0 || x == 0)
                ? CoordIndicatorCell(
                    size: size,
                    coord: y == 0 ? x : y,
                    isTop: y == 0,
                    coordIndicatorType: style.coordIndicatorType,
                  )
                : BoardCell(
                    size: size,
                    edge: Edge(
                      top: y == (style.showCoordIndicators ? 1 : 0),
                      bottom: y == numberRows - 1,
                      left: x == numberColumns - 1,
                      right: x == (style.showCoordIndicators ? 1 : 0),
                    ),
                    cellColor: style.cellColor,
                    borderColor: style.borderColor,
                    child: boardPiece != null
                        ? Piece(
                            boardPiece: boardPiece.displayString(usesJapanese: style.usesJapanese),
                            isSente: boardPiece.isSente,
                            size: size,
                            pieceColor: boardPiece.isPromoted ? style.promotedPieceColor : style.pieceColor,
                          )
                        : null,
                  );
          }
          rows[y] = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row,
          );
        }

        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Column(
            children: <Widget>[
              if (showPiecesInHand)
                _PiecesInHand(
                  pieces: gameBoard.gotePiecesInHand
                      .map((p) => p.displayString(usesJapanese: style.usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: false,
                  size: size,
                  pieceColor: style.pieceColor,
                ),
              ...rows,
              if (showPiecesInHand)
                _PiecesInHand(
                  pieces: gameBoard.sentePiecesInHand
                      .map((p) => p.displayString(usesJapanese: style.usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: true,
                  size: size,
                  pieceColor: style.pieceColor,
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Renders a row of pieces in hand
class _PiecesInHand extends StatelessWidget {
  /// A map of pieces and their count
  final Map<String, int> pieces;

  /// Whether the piece belongs to sente (facing upwards)
  final bool isSente;

  /// The cell's size (width, height)
  final double size;

  /// The color of the piece
  final Color pieceColor;

  const _PiecesInHand({
    this.pieces,
    @required this.isSente,
    @required this.size,
    @required this.pieceColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pieces.length > 0
        ? Align(
            alignment: isSente ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: size,
              child: Row(
                mainAxisAlignment: isSente ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: <Widget>[
                  for (final kvp in pieces.entries)
                    PieceInHand(
                      boardPiece: kvp.key,
                      count: kvp.value,
                      isSente: isSente,
                      size: size,
                      pieceColor: pieceColor,
                      countColor: BoardColors.red,
                    )
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: size,
          );
  }
}
