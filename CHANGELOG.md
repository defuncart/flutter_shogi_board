## [0.0.7] - 30/06/2020

* Updated to use shogi 0.0.5. Raises Dart sdk version >= 2.12.
* Optimize piece size.
* Pieces in hand count position aligned to bottom of piece.
* New pieces in hand ordering (rook -> pawn), gote mirror of sente.
* Aligns analysis options with flutter_lints.

## [0.0.6] - 22/08/2020

* Updated to use shogi 0.0.4. Raises Dart sdk version >= 2.7.
* Updated CoordinateCell's size to be smaller than BoardCell, thus better visual appearance.
* Adds better dark mode support, now player icon will be rendered according to theme brightness and coord indicators will match border color.
* Aligns analysis options with pedantic.

## [0.0.5] - 11/03/2020

* Updated to use shogi 0.0.3. Raises Dart sdk version >= 2.6.
* Added ability to render pieces in hand for each player.
* Updated the example to demonstrate castle building, a static tsume (with pieces in hand) and a proverb. This example is now compatible with web.
* Added `ShogiBoardStyle` and `DefaultShogiBoardStyle`.
* Updated `CoordIndicatorCell` and `Piece` text to adaptive to containing cell sizes.

## [0.0.4] - 10/02/2020

* Updated to use shogi 0.0.2.
* Added ability to show coordinate indicators on the board.
* Updated example to show the animation of building a castle.

## [0.0.3] - 13/10/2019

* Moved business logic components from this package to new shogi package.

## [0.0.2] - 06/10/2019

* Fixed meta package version conflict ^1.1.7 with Flutter: 1.7.8+hotfix.4.

## [0.0.1] - 06/10/2019

* Initial release of flutter_shogi_board package for Flutter.
