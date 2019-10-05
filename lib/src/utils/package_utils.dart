import '../enums/piece_type.dart';
import '../enums/player_type.dart';
import '../models/position.dart';

/// A class of util methods used in the package
class PackageUtils {
  /// Returns a string representaion of the piece at position (row, column)
  static String pieceStringAtPosition(List<Position> boardPieces, int row, int column) {
    final result = boardPieces.where((piece) => piece.row == row && piece.column == column);
    return result.isNotEmpty ? pieceTypeToString(result.first.pieceType) : '';
  }

  /// Returns whether the piece at position (row, column) belongs to sente or not
  static bool pieceDirectionAtPosition(List<Position> boardPieces, int row, int column) {
    final result = boardPieces.where((piece) => piece.row == row && piece.column == column);
    return result.isNotEmpty ? result.first.player == PlayerType.sente : true;
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
  static String pieceTypeToString(PieceType pieceType) => _piecesJP[pieceType];

  /// Converts a string to piece type.
  ///
  /// Assumes that the input string is in EN, that is, `K` instead of `玉` etc.
  static PieceType pieceStringToType(String pieceString) =>
      _piecesEN.entries.where((p) => p.value == pieceString).first.key;
}
