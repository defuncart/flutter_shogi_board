import 'package:shogi/shogi.dart';

/// A class of util methods used in the package
class PackageUtils {
  /// Returns the piece at position (row, column), `null` if no piece exists
  static BoardPiece pieceAtPosition(List<BoardPiece> boardPieces, int row, int column) {
    final result = boardPieces.where((piece) => piece.row == row && piece.column == column);
    return result.isNotEmpty ? result.first : null;
  }
}
