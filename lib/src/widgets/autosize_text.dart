import 'package:flutter/material.dart';

/// An enum describing the possible text directions
enum TextDirection {
  upwards,
  downwards,
}

/// Autosizes font size for Text widget within a square bounding box
class AutosizeText extends StatelessWidget {
  /// The text to be autosized
  final String text;

  /// The text's direction
  final TextDirection textDirection;

  /// The cell's size (width, height)
  final double size;

  /// A multiplier for how big the font size should be related to bounding box
  final double fontSizeMultiplier;

  /// The text's color of the icon
  final Color color;

  const AutosizeText(
    this.text, {
    Key key,
    @required this.textDirection,
    @required this.size,
    @required this.fontSizeMultiplier,
    @required this.color,
  })  : assert(text != null),
        assert(textDirection != null),
        assert(size != null && size > 0),
        assert(fontSizeMultiplier != null &&
            fontSizeMultiplier > 0 &&
            fontSizeMultiplier <= 1),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: RotatedBox(
          quarterTurns: textDirection == TextDirection.downwards ? 2 : 0,
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: size * fontSizeMultiplier,
              height: 1 / fontSizeMultiplier,
            ),
          ),
        ),
      ),
    );
  }
}
