import '../enums/piece_type.dart';
import '../models/board_piece.dart';

/// A class of util methods used in the package
class PackageUtils {
  /// Returns the piece at position (row, column), `null` if no piece exists
  static BoardPiece pieceAtPosition(List<BoardPiece> boardPieces, int row, int column) {
    final result = boardPieces.where((piece) => piece.row == row && piece.column == column);
    return result.isNotEmpty ? result.first : null;
  }

  /// Maps piece type to Japanese characters
  static const Map<PieceType, String> _piecesJP = {
    PieceType.king: '玉',
    PieceType.gold: '金',
    PieceType.silver: '銀',
    PieceType.knight: '桂',
    PieceType.lance: '香',
    PieceType.bishop: '角',
    PieceType.rook: '飛',
    PieceType.pawn: '歩',
  };

  /// Maps piece type to English letters
  static const Map<PieceType, String> _piecesEN = {
    PieceType.king: 'K',
    PieceType.gold: 'G',
    PieceType.silver: 'S',
    PieceType.knight: 'N',
    PieceType.lance: 'L',
    PieceType.bishop: 'B',
    PieceType.rook: 'R',
    PieceType.pawn: 'P',
  };

  /// Converts a piece type to string
  ///
  /// `useJapanese` is optional and defaults to `true`
  static String pieceTypeToString(PieceType pieceType, {bool usesJapanese = true}) =>
      usesJapanese ? _piecesJP[pieceType] : _piecesEN[pieceType];

  /// Converts a string to piece type.
  ///
  /// Assumes that the input string is in EN, that is, `K` instead of `玉` etc.
  static PieceType pieceStringToType(String pieceString) =>
      _piecesEN.entries.where((p) => p.value == pieceString).first.key;
}
