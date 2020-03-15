import 'package:flutter/material.dart';

/// Renders a given board piece as text
class Piece extends StatelessWidget {
  /// A multiplier to determine font size based on cell size
  static const _fontSizeMultiplier = 0.6;

  /// The board piece as a text string
  final String boardPiece;

  /// Whether the piece belongs to sente (facing upwards)
  final bool isSente;

  /// The cell's size (width, height)
  final double size;

  /// The color of the piece
  final Color pieceColor;

  const Piece({
    Key key,
    @required this.boardPiece,
    @required this.isSente,
    @required this.size,
    @required this.pieceColor,
  })  : assert(boardPiece != null && boardPiece != ''),
        assert(isSente != null),
        assert(size != null && size > 0),
        assert(pieceColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: RotatedBox(
          quarterTurns: isSente ? 0 : 2,
          child: Text(
            boardPiece,
            style: TextStyle(
              color: pieceColor,
              fontSize: size * _fontSizeMultiplier,
            ),
          ),
        ),
      ),
    );
  }
}
