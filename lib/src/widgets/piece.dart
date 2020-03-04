import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// Renders a given board piece as text
class Piece extends StatelessWidget {
  /// The maximum font size
  static const _maxFontSize = 60.0;

  /// The minimum font size
  static const _minFontSize = 10.0;

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
          child: AutoSizeText(
            boardPiece,
            style: TextStyle(
              color: pieceColor,
              fontSize: _maxFontSize,
            ),
            minFontSize: _minFontSize,
          ),
        ),
      ),
    );
  }
}
