import '../configs/board_config.dart';
import '../configs/game_boards.dart';
import '../enums/player_type.dart';
import '../models/position.dart';
import '../utils/package_utils.dart';

/// A class of utils methods used when constructing a shogi board
class ShogiUtils {
  /// Converts an array of strings [K-59, ...] into an array of positions
  static List<Position> stringArrayToPositionArray(List<String> strPositions, {player = PlayerType.sente}) {
    final positions = List<Position>();
    for (final strPos in strPositions) {
      // split string K-59 into [k, 59]
      final components = strPos.split('-');
      assert(components.length == 2);

      // convert components into piece type and (row, column) - note adjusting value to be [0, 8]
      final pieceType = PackageUtils.pieceStringToType(components[0]);
      final row = int.parse(components[1][0]) - 1;
      final column = int.parse(components[1][1]) - 1;

      positions.add(Position(row: row, column: column, pieceType: pieceType, player: player));
    }
    return positions;
  }

  /// Flips a list of positions to another player
  ///
  /// Thus sente K-59 would be gote K-51 etc.
  static List<Position> flipPositions(List<Position> originalPositions) {
    final newPositions = List<Position>();
    for (final position in originalPositions) {
      final newRow = (position.row - (BoardConfig.numberRows - 1)).abs();
      final newColumn = (position.column - (BoardConfig.numberColumns - 1)).abs();
      final newPlayer = position.player == PlayerType.gote ? PlayerType.sente : PlayerType.gote;

      newPositions.add(Position(row: newRow, column: newColumn, pieceType: position.pieceType, player: newPlayer));
    }
    return newPositions;
  }

  /// A backing variable used for sente's initial board pieces
  static List<Position> _initialBoardSente;

  /// A backing variable used for gote's initial board pieces
  static List<Position> _initialBoardGote;

  /// A backing variable used for the overall initial board pieces
  static List<Position> _initialBoard;

  /// The initial board pieces
  static List<Position> get initialBoard => _initialBoard ??= [
        ...(_initialBoardSente ??= stringArrayToPositionArray(GameBoards.initialBoardSente)),
        ...(_initialBoardGote ??= flipPositions(_initialBoardSente))
      ];
}
