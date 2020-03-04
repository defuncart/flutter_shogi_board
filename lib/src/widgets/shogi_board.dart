import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shogi/shogi.dart';

import 'board_cell.dart';
import 'coord_indicator_cell.dart';
import 'piece.dart';
import 'piece_in_hand.dart';
import '../configs/board_colors.dart';
import '../extensions/list_board_piece_extensions.dart';
import '../extensions/list_extensions.dart';

/// Renders a shogi board using a list of board pieces
class ShogiBoard extends StatelessWidget {
  /// The game board to render
  final GameBoard gameBoard;

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

  /// Whether pieces in hand should be shown. Defaults to `true`.
  ///
  /// Although this is the expected behavior in a game, in a castle situation it could set to `false`, for example.
  final bool showPiecesInHand;

  const ShogiBoard({
    Key key,
    @required this.gameBoard,
    this.pieceColor = BoardColors.black,
    this.promotedPieceColor = BoardColors.red,
    this.cellColor = Colors.transparent,
    this.borderColor = BoardColors.gray,
    this.usesJapanese = true,
    this.showCoordIndicators = true,
    this.coordIndicatorType = CoordIndicatorType.japanese,
    this.showPiecesInHand = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberRows = showCoordIndicators ? BoardConfig.numberRows + 1 : BoardConfig.numberRows;
    final numberColumns = showCoordIndicators ? BoardConfig.numberColumns + 1 : BoardConfig.numberColumns;

    return LayoutBuilder(
      builder: (_, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight) / (numberRows + (showPiecesInHand ? 2 : 0));
        final aspectRatio = numberColumns / (numberRows + (showPiecesInHand ? 2 : 0));

        List<Widget> rows = List<Widget>(numberRows);
        for (int y = 0; y < numberRows; y++) {
          List<Widget> row = List<Widget>(numberColumns);
          for (int x = numberColumns - 1; x >= 0; x--) {
            final boardPiece = gameBoard.boardPieces.pieceAtPosition(
              column: showCoordIndicators ? x : x + 1,
              row: showCoordIndicators ? y : y + 1,
            );

            row[numberColumns - 1 - x] = showCoordIndicators && (y == 0 || x == 0)
                ? CoordIndicatorCell(
                    size: size,
                    coord: y == 0 ? x : y,
                    isTop: y == 0,
                    coordIndicatorType: coordIndicatorType,
                  )
                : BoardCell(
                    size: size,
                    edge: Edge(
                      top: y == (showCoordIndicators ? 1 : 0),
                      bottom: y == numberRows - 1,
                      left: x == numberColumns - 1,
                      right: x == (showCoordIndicators ? 1 : 0),
                    ),
                    cellColor: cellColor,
                    borderColor: borderColor,
                    child: boardPiece != null
                        ? Piece(
                            boardPiece: boardPiece.displayString(usesJapanese: usesJapanese),
                            isSente: boardPiece.isSente,
                            size: size,
                            pieceColor: boardPiece.isPromoted ? promotedPieceColor : pieceColor,
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
                  pieces: gameBoard.sentePiecesInHand
                      .map((p) => p.displayString(usesJapanese: usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: false,
                  size: size,
                  pieceColor: pieceColor,
                ),
              ...rows,
              if (showPiecesInHand)
                _PiecesInHand(
                  pieces: gameBoard.gotePiecesInHand
                      .map((p) => p.displayString(usesJapanese: usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: true,
                  size: size,
                  pieceColor: pieceColor,
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
