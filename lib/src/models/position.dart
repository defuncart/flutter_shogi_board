import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../enums/piece_type.dart';
import '../enums/player_type.dart';
import '../utils/package_utils.dart';

/// A model representing a position on the shogi board
class Position {
  /// The row index
  final int row;

  /// The column index
  final int column;

  /// The board piece type
  final PieceType pieceType;

  /// Which player the piece belongs to
  final PlayerType player;

  const Position({
    @required this.row,
    @required this.column,
    @required this.pieceType,
    this.player = PlayerType.sente,
  });

  /// Whether the position belongs to sente
  bool get isSente => player == PlayerType.sente;

  /// A display string of the position
  String displayString({bool usesJapanese = true}) =>
      PackageUtils.pieceTypeToString(pieceType, usesJapanese: usesJapanese);

  /// Returns a string representation of the model
  @override
  String toString() => '($column, $row): ${describeEnum(player)} ${describeEnum(pieceType)}';
}
