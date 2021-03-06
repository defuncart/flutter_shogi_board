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
    Key? key,
    required this.textDirection,
    required this.size,
    required this.fontSizeMultiplier,
    required this.color,
  })  : assert(size > 0),
        assert(fontSizeMultiplier > 0 && fontSizeMultiplier <= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final charCountMultiplier = text.length > 1 ? 0.85 : 1.0;
    // TODO this needs more research + tweeking
    final textHeight =
        Theme.of(context).platform == TargetPlatform.macOS && size > 25
            ? null
            : 1 / fontSizeMultiplier;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: textDirection == TextDirection.downwards ? 2 : 0,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size * fontSizeMultiplier * charCountMultiplier,
            height: textHeight,
          ),
        ),
      ),
    );
  }
}
