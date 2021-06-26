import 'package:flutter/material.dart';
import 'package:shogi/shogi.dart';

import 'autosize_text.dart';

/// Renders a player's icon
class PlayerIcon extends StatelessWidget {
  /// A multiplier to render the icon smaller than for a piece
  static const _sizeMultiplier = 0.8;

  /// Whether the piece belongs to sente (facing upwards)
  final bool isSente;

  /// The cell's size (width, height)
  final double size;

  /// The color of the icon
  final Color color;

  const PlayerIcon({
    Key? key,
    required this.isSente,
    required this.size,
    required this.color,
  })  : assert(size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutosizeText(
      isSente ? BoardConfig.sente : BoardConfig.gote,
      textDirection: isSente ? TextDirection.upwards : TextDirection.downwards,
      size: size,
      fontSizeMultiplier: _sizeMultiplier,
      color: color,
    );
  }
}
