import 'package:flutter/material.dart';

import '../configs/board_colors.dart';

/// An enum to describe what type of coordinate indicator show be shown
enum CoordIndicatorType {
  number,
  japanese,
  arabic,
}

/// Renders a coordinate indicator cell with a given size and text contents
class CoordIndicatorCell extends StatelessWidget {
  /// A multiplier to determine font size based on cell size
  static const _fontSizeMultiplier = 0.5;

  /// The cell's size (width, height)
  final double size;

  /// The coordinate
  final int coord;

  /// Whether the cell is at the top of the board (as opposed to right)
  final bool isTop;

  /// The coordinate indicator type
  final CoordIndicatorType coordIndicatorType;

  /// The text color
  final Color color;

  const CoordIndicatorCell({
    required this.size,
    required this.coord,
    required this.isTop,
    this.coordIndicatorType = CoordIndicatorType.japanese,
    this.color = BoardColors.gray,
    Key? key,
  }) : super(key: key);

  static const _arabic = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
  static const _japanese = ['一', '二', '三', '四', '五', '六', '七', '八', '九'];

  @override
  Widget build(BuildContext context) {
    //determine text to display
    String? text;
    if (coord != 0) {
      if (isTop || coordIndicatorType == CoordIndicatorType.number) {
        text = coord.toString();
      } else if (coordIndicatorType == CoordIndicatorType.japanese) {
        text = _japanese[coord - 1];
      } else if (coordIndicatorType == CoordIndicatorType.arabic) {
        text = _arabic[coord - 1];
      }
    }

    return SizedBox(
      height: size,
      width: size,
      child: text == null
          ? null
          : Center(
              child: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: size * _fontSizeMultiplier,
                ),
              ),
            ),
    );
  }
}
