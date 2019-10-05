import 'package:meta/meta.dart';

import '../models/position.dart';

/// A model representing a shogi game board
class GameBoard {
  /// A list of board positions
  final List<Position> positions;

  const GameBoard({
    @required this.positions,
  });

  /// Returns a string representation of the model
  @override
  String toString() => '{$positions}';
}
