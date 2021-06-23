import 'package:flutter/material.dart';

import '../configs/board_colors.dart';
import '../widgets/coord_indicator_cell.dart';

/// A model used to paint a `ShogiBoard`.
@immutable
class ShogiBoardStyle {
  /// The maximum size of the board
  final double maxSize;

  /// The color of each standard piece on the board.
  final Color pieceColor;

  /// The color of each promoted piece on the board.
  final Color promotedPieceColor;

  /// The color of each cell on the board.
  final Color cellColor;

  /// The color of each cell's border.
  final Color borderColor;

  /// Whether japanese characters (i.e. 玉) or latin letters (i.e. K) should be used. Defaults to `true`.
  final bool usesJapanese;

  /// Whether coordinate indicators (on top and right of board) should be shown. Defaults to `true`.
  final bool showCoordIndicators;

  /// The type of coordinate indicators show. Defaults to `CoordIndicatorType.japanese`.
  final CoordIndicatorType coordIndicatorType;

  const ShogiBoardStyle({
    this.maxSize = double.infinity,
    this.pieceColor = BoardColors.black,
    this.promotedPieceColor = BoardColors.red,
    this.cellColor = Colors.transparent,
    this.borderColor = BoardColors.gray,
    this.usesJapanese = true,
    this.showCoordIndicators = true,
    this.coordIndicatorType = CoordIndicatorType.japanese,
  });

  /// Creates a copy of this `ShogiBoardStyle` but with the given fields replaced with the new values.
  ShogiBoardStyle copyWith({
    double? maxSize,
    Color? pieceColor,
    Color? promotedPieceColor,
    Color? cellColor,
    Color? borderColor,
    bool? usesJapanese,
    bool? showCoordIndicators,
    CoordIndicatorType? coordIndicatorType,
  }) =>
      ShogiBoardStyle(
        maxSize: maxSize ?? this.maxSize,
        pieceColor: pieceColor ?? this.pieceColor,
        promotedPieceColor: promotedPieceColor ?? this.promotedPieceColor,
        cellColor: cellColor ?? this.cellColor,
        borderColor: borderColor ?? this.borderColor,
        usesJapanese: usesJapanese ?? this.usesJapanese,
        showCoordIndicators: showCoordIndicators ?? this.showCoordIndicators,
        coordIndicatorType: coordIndicatorType ?? this.coordIndicatorType,
      );

  @override
  String toString() {
    final properties = {
      'maxSize': maxSize,
      'pieceColor': pieceColor,
      'promotedPieceColor': promotedPieceColor,
      'cellColor': cellColor,
      'borderColor': borderColor,
      'usesJapanese': usesJapanese,
      'showCoordIndicators': showCoordIndicators,
      'coordIndicatorType': coordIndicatorType,
    };
    return properties.entries.map((kvp) => kvp.value != null).toList().toString();
  }
}
