import 'package:flutter/material.dart';

import 'piece.dart';

/// Renders a captured (i.e. in hand) piece with a given count
class PieceInHand extends StatelessWidget {
  /// A multiplier to render the text smaller than for a normal piece
  static const _pieceSizeMultiplier = 0.8;

  /// A multiplier for the count container size
  static const _countContainerSizeMultiplier = 0.5;

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
    Key? key,
    required this.boardPiece,
    required this.count,
    required this.isSente,
    required this.size,
    required this.pieceColor,
    required this.countColor,
  })  : assert(boardPiece != null && boardPiece != ''),
        assert(count != null && count > 0),
        assert(isSente != null),
        assert(size != null && size > 0),
        assert(pieceColor != null),
        assert(countColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final countContainerSize = size * _countContainerSizeMultiplier;
    final countFontSizeMultiplier = count > 9 ? 0.85 : 1;
    final countContainerHorizontalOffset = 0.0;
    final countContainerVerticalOffset = countContainerSize * 0.15;

    return Container(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: isSente ? Alignment.topCenter : Alignment.bottomCenter,
            child: Piece(
              boardPiece: boardPiece,
              isSente: isSente,
              size: size * _pieceSizeMultiplier,
              pieceColor: pieceColor,
            ),
          ),
          if (count > 1)
            Positioned(
              left: isSente ? null : countContainerHorizontalOffset,
              right: isSente ? countContainerHorizontalOffset : null,
              top: isSente ? null : countContainerVerticalOffset,
              bottom: isSente ? countContainerVerticalOffset : null,
              child: Container(
                width: countContainerSize,
                height: countContainerSize,
                alignment: Alignment.center,
                child: RotatedBox(
                  quarterTurns: isSente ? 0 : 2,
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: countColor,
                      fontSize: size *
                          _pieceSizeMultiplier *
                          _countContainerSizeMultiplier *
                          _countFontSizeMultiplier *
                          countFontSizeMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
