import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shogi/shogi.dart';

import '../configs/board_colors.dart';
import '../extensions/list_extensions.dart';
import '../models/shogi_board_style.dart';
import 'board_cell.dart';
import 'coord_indicator_cell.dart';
import 'default_shogi_board_style.dart';
import 'piece.dart';
import 'piece_in_hand.dart';

/// Renders a shogi board using a list of board pieces
class ShogiBoard extends StatelessWidget {
  // A multiplier how much size a board cell should take
  static const _boardCellMultiplier = 1.0;

  // A multiplier how much size a coord cell should take. This should be <= _boardCellMultiplier.
  static const _coordCellMultiplier = 0.6;

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
        // determine the maximum size of the board. this is the min of the style.maxSize and device/layout max width, max height
        final maxSize = min(
          style.maxSize,
          min(
            min(constraints.maxWidth, MediaQuery.of(context).size.width),
            min(constraints.maxHeight, MediaQuery.of(context).size.height),
          ),
        );
        // determine size multiplier
        final totalMultiplier = ((BoardConfig.numberRows + (showPiecesInHand ? 2 : 0)) * _boardCellMultiplier) +
            (style.showCoordIndicators ? _coordCellMultiplier : 0);
        final sizePerMultiplierUnit = maxSize / totalMultiplier;
        // determine the size per board cell and coord cell
        final sizeBoardCell = sizePerMultiplierUnit * _boardCellMultiplier;
        final sizeCoordCell = sizePerMultiplierUnit * _coordCellMultiplier;
        // determine the total width and height of the board
        final totalWidth = sizeBoardCell * BoardConfig.numberColumns + (style.showCoordIndicators ? sizeCoordCell : 0);
        final totalHeight = sizeBoardCell * BoardConfig.numberRows +
            (style.showCoordIndicators ? sizeCoordCell : 0) +
            sizeBoardCell * (showPiecesInHand ? 2 : 0);

        // determine rows of widgets
        final rows = List<Widget>(numberRows);
        for (var y = 0; y < numberRows; y++) {
          final row = List<Widget>(numberColumns);
          for (var x = numberColumns - 1; x >= 0; x--) {
            final boardPiece = gameBoard.boardPieces.pieceAtPosition(
              column: style.showCoordIndicators ? x : x + 1,
              row: style.showCoordIndicators ? y : y + 1,
            );

            // if should show coord and top row/first column, assign CoordIndicatorCell else BoardCell
            row[numberColumns - 1 - x] = style.showCoordIndicators && (y == 0 || x == 0)
                ? CoordIndicatorCell(
                    size: sizeCoordCell,
                    coord: y == 0 ? x : y,
                    isTop: y == 0,
                    coordIndicatorType: style.coordIndicatorType,
                  )
                : BoardCell(
                    size: sizeBoardCell,
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
                            size: sizeBoardCell,
                            pieceColor: boardPiece.isPromoted ? style.promotedPieceColor : style.pieceColor,
                          )
                        : null,
                  );
          }

          // if top row and should show coord indicators, then wrap in an additional row to allow correct spacing
          rows[y] = style.showCoordIndicators && y == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: row.take(numberRows - 1).toList(),
                      ),
                    ),
                    row.last,
                  ],
                )
              : Row(
                  children: row,
                );
        }

        // construct board
        return Container(
          width: totalWidth,
          height: totalHeight,
          child: Column(
            children: <Widget>[
              if (showPiecesInHand)
                _PiecesInHand(
                  pieces: gameBoard.gotePiecesInHand
                      .map((p) => p.displayString(usesJapanese: style.usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: false,
                  size: sizeBoardCell,
                  pieceColor: style.pieceColor,
                  spacer: style.showCoordIndicators ? sizeCoordCell : 0,
                ),
              ...rows,
              if (showPiecesInHand)
                _PiecesInHand(
                  pieces: gameBoard.sentePiecesInHand
                      .map((p) => p.displayString(usesJapanese: style.usesJapanese))
                      .toList()
                      .convertToMapWithCountUniqueElements(),
                  isSente: true,
                  size: sizeBoardCell,
                  pieceColor: style.pieceColor,
                  spacer: style.showCoordIndicators ? sizeCoordCell : 0,
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

  /// A spacer to place at the right-most edge
  ///
  /// This is used when style.showCoordIndicators is true
  final double spacer;

  /// The color of the piece
  final Color pieceColor;

  const _PiecesInHand({
    Key key,
    this.pieces,
    @required this.isSente,
    @required this.size,
    @required this.pieceColor,
    this.spacer = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerIconColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return Align(
      alignment: isSente ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (isSente)
              // HACK using PieceInHand to render player icon
              PieceInHand(
                boardPiece: BoardConfig.sente,
                count: 1,
                isSente: isSente,
                size: size,
                pieceColor: playerIconColor,
                countColor: Colors.transparent,
              ),
            Row(
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
                  ),
                if (isSente) Container(width: spacer)
              ],
            ),
            if (!isSente)
              Row(
                children: <Widget>[
                  // HACK using PieceInHand to render player icon
                  PieceInHand(
                    boardPiece: BoardConfig.gote,
                    count: 1,
                    isSente: isSente,
                    size: size,
                    pieceColor: playerIconColor,
                    countColor: Colors.transparent,
                  ),
                  Container(width: spacer)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
