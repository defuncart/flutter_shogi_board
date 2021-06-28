import 'package:flutter_shogi_board/src/widgets/shogi_board.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shogi/shogi.dart';

void main() {
  group('GameBoardExtension', () {
    final gameBoard = GameBoard(
      boardPieces: null,
      sentePiecesInHand: [
        BoardPiece(pieceType: PieceType.gold, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.silver, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.pawn, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.rook, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.bishop, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.knight, player: PlayerType.sente),
        BoardPiece(pieceType: PieceType.lance, player: PlayerType.sente),
      ],
      gotePiecesInHand: [
        BoardPiece(pieceType: PieceType.gold, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.silver, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.pawn, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.rook, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.bishop, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.knight, player: PlayerType.gote),
        BoardPiece(pieceType: PieceType.lance, player: PlayerType.gote),
      ],
    );

    test('senteOrderedPiecesInHand', () {
      expect(
        gameBoard.senteOrderedPiecesInHand,
        [
          BoardPiece(pieceType: PieceType.rook, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.bishop, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.gold, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.silver, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.knight, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.lance, player: PlayerType.sente),
          BoardPiece(pieceType: PieceType.pawn, player: PlayerType.sente),
        ],
      );
    });

    test('goteOrderedPiecesInHand', () {
      expect(
        gameBoard.goteOrderedPiecesInHand,
        [
          BoardPiece(pieceType: PieceType.pawn, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.lance, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.knight, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.silver, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.gold, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.bishop, player: PlayerType.gote),
          BoardPiece(pieceType: PieceType.rook, player: PlayerType.gote),
        ],
      );
    });
  });
}
