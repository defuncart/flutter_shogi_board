import 'package:flutter/material.dart';

import '../models/shogi_board_style.dart';

/// The `ShogiBoardStyle` to apply to descendant `ShogiBoard` widgets without an explicit style.
class DefaultShogiBoardStyle extends InheritedWidget {
  /// The shogi board style
  final ShogiBoardStyle style;

  const DefaultShogiBoardStyle({
    Key key,
    @required Widget child,
    @required this.style,
  })  : assert(child != null),
        assert(style != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If no such instance exists, returns an instance created by `DefaultShogiBoardStyle.fallback`, which contains fallback values.
  static DefaultShogiBoardStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DefaultShogiBoardStyle>() ?? DefaultShogiBoardStyle.fallback();

  /// A const-constructible `DefaultShogiBoardStyle` that provides fallback values.
  ///
  /// Returned from `of` when the given `BuildContext` doesn't have an enclosing default `ShogiBoardStyle`.
  ///
  /// This constructor creates a `DefaultShogiBoardStyle` that lacks a child, which means the constructed value cannot be incorporated into the tree.
  const DefaultShogiBoardStyle.fallback() : style = const ShogiBoardStyle();
}
