module Game.BoardTest where

import Game.Board as GB exposing (Board, Piece(..), Square)

import Graphics.Element exposing (Element)
import ElmTest exposing (..)


-- Avoid using == on Dicts
assertBoardEqual : Board -> Board -> Assertion
assertBoardEqual b1 b2 =
    assertEqual (GB.toList b1) (GB.toList b2)


tests : Test
tests =
    let
        b0 = GB.fromList []
        x1 = GB.fromList [(3, X)]
        o1 = GB.fromList [(3, O)]
        b2 = GB.fromList [(3, X), (5, O)]
        b3 = GB.fromList [(1, X), (6, X), (7, O)]
        b8 = GB.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (8, X), (9, O)]
        d9 = GB.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (7, O), (8, X), (9, O)]
    in
        suite
            "Board - helper functions"
             [ suite "emptyBoard"
                [ test "Empty board" <| GB.emptyBoard `assertBoardEqual` b0
                ]
            , suite "addPiece"
                [ test "First add" <| (GB.addPiece 3 X GB.emptyBoard) `assertBoardEqual` x1
                , test "Second add" <| (GB.addPiece 5 O x1) `assertBoardEqual` b2
                , test "Replace"  <| (GB.addPiece 3 O x1) `assertBoardEqual` o1
                ]
            , suite "isPiece"
                [ test "Empty cell" <| assert <| not <| GB.isPiece 5 X b3
                , test "X cell" <| assert <| GB.isPiece 6 X b3
                , test "O cell" <| assert <| GB.isPiece 7 O b3
                , test "!X cell" <| assert <|  not <| GB.isPiece 6 O b3
                , test "!O cell" <| assert <|  not <| GB.isPiece 7 X b3
                ]
            , suite "isEmptySquare"
                [ test "Empty cell" <| assert <| GB.isEmptySquare 5 b3
                , test "X cell" <| assert <| not <| GB.isEmptySquare 6 b3
                , test "O cell" <| assert <| not <| GB.isEmptySquare 7 b3
                ]
             , suite "isFull"
                [ test "Full board" <| assert <| GB.isFull d9
                , test "Non-full board" <| assert <| not <| GB.isFull b8
                , test "Empty board" <| assert <| not <| GB.isFull b0
                ]
             , suite "isLine"
             -- TBD
            ]

main : Element
main =
    elementRunner tests
