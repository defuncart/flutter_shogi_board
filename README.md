# flutter_shogi_board

A shogi board widget for Flutter.

![](images/01.png)

## Getting Started

### Import the package

To use this package, add `flutter_shogi_board` as a dependency in your `pubspec.yaml`

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

For more information, see the Flutter app in the `example` directory.

## Game Board Parameters

The widget is designed to be used in portrait mode, and fills the board size to match it's parents width. The board pieces are rendered as text.

| Parameter      | Description                                                                               |
| :------------- |:------------------------------------------------------------------------------------------|
| `boardPieces`  | A `List<Position>` to render on the shogi game board.                                     |
| `pieceColor`   | Optional. The piece color, defaults to black.                                             |
| `cellColor`    | Optional. The board cell background color, defaults to transparent.                       |
| `borderColor`  | Optional. The board cell background color, defaults to gray.                              |
| `usesJapanese` | Optional. Whether japanese characters or english letters are displayed, defaults to true. |

## Roadmap

This package grew out of my desired to visualize shogi castles in Flutter, and with no widget or even shogi package available, I decided to roll my own. The following will be implemented ASAP:

- Add promoted pieces
- Ability to import a game

For the future I would like to utilize this widget not just for displaying castles, but also for tsume problems, thus user interaction will be considered.

The models and enums to their own package, if deemed necessary.

## Raising Issues and Contributing

Please report bugs and issues, and raise feature requests on the [GitHub](https://github.com/defuncart/flutter_shogi_board/issues)

To contribute, submit a PR with a detailed description and tests, if applicable.
