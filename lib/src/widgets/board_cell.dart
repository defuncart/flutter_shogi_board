import 'package:flutter/material.dart';

/// A model used to determine on which edge exteremes a board cell lies on.
class Edge {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const Edge({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });
}

/// Renders a board cell with an optional child content
class BoardCell extends StatelessWidget {
  /// The cell's size (width, height)
  final double size;

  /// Which edge(s) of the board the cell lies on
  final Edge edge;

  /// The color of the cell
  final Color cellColor;

  /// The color of the cell's border
  final Color borderColor;

  /// The child content to display (can be `null`)
  final Widget? child;

  const BoardCell({
    Key? key,
    required this.size,
    required this.edge,
    required this.cellColor,
    required this.borderColor,
    this.child,
  })  : assert(size != null && size > 0),
        assert(edge != null),
        assert(cellColor != null),
        assert(borderColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final standardSide = BorderSide(width: 1, color: borderColor);
    final edgeSide = BorderSide(width: 2, color: borderColor);

    return Expanded(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border(
            top: edge.top ? edgeSide : standardSide,
            bottom: edge.bottom ? edgeSide : standardSide,
            left: edge.left ? edgeSide : standardSide,
            right: edge.right ? edgeSide : standardSide,
          ),
          color: cellColor,
        ),
        child: child,
      ),
    );
  }
}
