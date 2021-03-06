import 'dart:ui';

import 'package:flutter_shogi_board/flutter_shogi_board.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('No Parameters', () {
    const style = ShogiBoardStyle();
    expect(style, isNotNull);
    expect(style.pieceColor, isNotNull);
    expect(style.promotedPieceColor, isNotNull);
    expect(style.cellColor, isNotNull);
    expect(style.borderColor, isNotNull);
    expect(style.usesJapanese, isNotNull);
    expect(style.showCoordIndicators, isNotNull);
    expect(style.coordIndicatorType, isNotNull);
  });

  test('Piece Color', () {
    const color = Color(0xffFFFFFF);
    const style = ShogiBoardStyle(pieceColor: color);
    expect(style.pieceColor, color);
  });

  test('copyWith Piece Color', () {
    const color = Color(0xffFFFFFF);
    const style1 = ShogiBoardStyle();
    final style2 = style1.copyWith(pieceColor: color);
    expect(style2.pieceColor, color);
    expect(style2.promotedPieceColor, style1.promotedPieceColor);
    expect(style2.cellColor, style1.cellColor);
    expect(style2.borderColor, style1.borderColor);
    expect(style2.usesJapanese, style1.usesJapanese);
    expect(style2.showCoordIndicators, style1.showCoordIndicators);
    expect(style2.coordIndicatorType, style1.coordIndicatorType);
  });
}
