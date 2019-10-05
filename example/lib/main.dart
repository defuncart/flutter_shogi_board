import 'package:flutter/material.dart';
import 'package:flutter_shogi_board/flutter_shogi_board.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ShogiBoard(
              boardPieces: ShogiUtils.initialBoard,
            ),
          ),
        ),
      ),
    ),
  );
}
