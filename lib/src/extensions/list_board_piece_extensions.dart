import 'package:meta/meta.dart';
import 'package:shogi/shogi.dart';

/// A class of extension methods for List<BoardPiece>
extension ListBoardPieceExtensions on List<BoardPiece> {
  /// Returns the piece at position (column, row). Returns `null` if no piece exists.
  BoardPiece pieceAtPosition({@required int column, @required int row}) => this.firstWhere(
        (piece) => piece.position.column == column && piece.position.row == row,
        orElse: () => null,
      );
}
