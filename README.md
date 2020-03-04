# flutter_shogi_board

A shogi board widget for Flutter. This widget can be used to render static game board positions, tsume problems or shogi castles.

![](images/01.png)

Shogi (将棋) is a two-player strategy board game native to Japan, belonging to the same family as chess and xiangqi. 

## Getting Started

### Import the package

To import this package, simply add `flutter_shogi_board` as a dependency in `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_shogi_board:
```

Note that this package requires dart >= 2.3.0.

### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_shogi_board/flutter_shogi_board.dart';
import 'package:shogi/shogi.dart';

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
```

For more information, see the Flutter app in the `example` directory. This example is also hosted [online](http://defuncart.com/flutter_shogi_board/).

## Game Board Parameters

The widget is designed to be used in portrait mode, and fills the board size to match it's parents width. The board pieces are rendered as text.

| Parameter             | Description                                                                                |
|:----------------------|:-------------------------------------------------------------------------------------------|
| `boardPieces`         | A `List<BoardPiece>` to render on the shogi game board.                                    |
| `pieceColor`          | Optional. The standard piece color, defaults to black.                                     |
| `promotedPieceColor`  | Optional. The promoted piece color, defaults to red.                                       |
| `cellColor`           | Optional. The board cell background color, defaults to transparent.                        |
| `borderColor`         | Optional. The board cell background color, defaults to gray.                               |
| `usesJapanese`        | Optional. Whether japanese characters or english letters are displayed, defaults to true.  |
| `showCoordIndicators` | Optional. Whether board coordinate indicators should be shown, defaults to true.           |
| `coordIndicatorType`  | Optional. The type of coordinate indicators show, defaults to CoordIndicatorType.japanese. |
| `showPiecesInHand`    | Optional. Whether pieces in hand should be shown, defaults to true.                        |

## Importing a Game Board

As the game board is presently static, a board position can be notated by `{PieceType}-{Row}{Column}`, i.e. `K-59`. Note that 11 is the top left board cell as per japanese notation.

```dart
final yagura = ['L-99', 'N-89', 'K-88', 'G-78', 'P-97', 'P-87', 'S-77', 'G-67', 'P-76', 'P-66', 'P-56'];

final boardPieces = ShogiUtils.stringArrayToBoardPiecesArray(yagura);
```

If sente or gote aren't specified, then sente is chosen by default. To import pieces for both players, use the notation `{Player}:{PieceType}-{Row}{Column}`.

```dart
final tsume1 = ['G:K-51', 'G:S-61', 'G:S-41', 'S:+P-53', 'S:+B-25'];
```

|                    |                    |
|:-------------------|:-------------------|
| ![](images/02.png) | ![](images/03.png) |


## Future Plans

This package grew out of my desired to visualize shogi castles in Flutter, and with no game board widget or even a shogi engine available, I decided to roll my own. The package [shogi](https://github.com/defuncart/shogi) contains the initial business logic from this package and will be simultaneously developed upon.

For the future I would like to utilize this widget not just for displaying static game boards, but also for tsume problems, thus user interaction may be considered.

## Raising Issues and Contributing

Please report bugs and issues, and raise feature requests on [GitHub](https://github.com/defuncart/flutter_shogi_board/issues).

To contribute, submit a PR with a detailed description and tests, if applicable.
