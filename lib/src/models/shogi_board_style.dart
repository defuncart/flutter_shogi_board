import 'package:flutter/material.dart';

import '../configs/board_colors.dart';
import '../widgets/coord_indicator_cell.dart';

/// A model used to paint a `ShogiBoard`
@immutable
class ShogiBoardStyle {
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

  const ShogiBoardStyle({
    this.pieceColor = BoardColors.black,
    this.promotedPieceColor = BoardColors.red,
    this.cellColor = Colors.transparent,
    this.borderColor = BoardColors.gray,
    this.usesJapanese = true,
    this.showCoordIndicators = true,
    this.coordIndicatorType = CoordIndicatorType.japanese,
  })  : assert(pieceColor != null),
        assert(promotedPieceColor != null),
        assert(cellColor != null),
        assert(borderColor != null),
        assert(usesJapanese != null),
        assert(showCoordIndicators != null),
        assert(coordIndicatorType != null);
}
