import 'package:flutter/material.dart';

import 'piece.dart';

/// Renders a captured (i.e. in hand) piece with a given count
class PieceInHand extends StatelessWidget {
  /// A multiplier to render the text smaller than for a normal piece
  static const _sizeMultiplier = 0.8;

  /// A multiplier for the count container size
  static const _countContainerSizeMultiplier = 0.35;

  /// A multiplier for the count font size
  static const _countFontSizeMultiplier = 0.9;

  /// The board piece as a text string
  final String boardPiece;

  /// The count of this board piece type
  final int count;

  /// Whether the piece belongs to sente (facing upwards)
  final bool isSente;

  /// The cell's size (width, height)
  final double size;

  /// The color of the piece
  final Color pieceColor;

  /// The color of the count indicator
  final Color countColor;

  const PieceInHand({
    Key key,
    @required this.boardPiece,
    @required this.count,
    @required this.isSente,
    @required this.size,
    @required this.pieceColor,
    @required this.countColor,
  })  : assert(boardPiece != null && boardPiece != ''),
        assert(count != null && count > 0),
        assert(isSente != null),
        assert(size != null && size > 0),
        assert(pieceColor != null),
        assert(countColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: isSente
          ? AlignmentDirectional.topEnd
          : AlignmentDirectional.bottomStart,
      children: <Widget>[
        Piece(
          boardPiece: boardPiece,
          isSente: isSente,
          size: size * _sizeMultiplier,
          pieceColor: pieceColor,
        ),
        if (count > 1)
          Container(
            width: size * _countContainerSizeMultiplier,
            height: size * _countContainerSizeMultiplier,
            alignment: isSente ? Alignment.topRight : Alignment.bottomLeft,
            child: RotatedBox(
              quarterTurns: isSente ? 0 : 2,
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: countColor,
                  fontSize: size *
                      _countContainerSizeMultiplier *
                      _countFontSizeMultiplier,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
