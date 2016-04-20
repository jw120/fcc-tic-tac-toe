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
        w3 = GB.fromList [(3, X), (5, X), (7, X)]
        b8 = GB.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (8, X), (9, O)]
        d9 = GB.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (7, O), (8, X), (9, O)]
        x9 = GB.fromList [(1, X), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, O), (9, X)]
        o9 = GB.fromList [(1, O), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, X), (9, X)]

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
                [ test "Empty board" <| assertEqual [] <| List.filterMap (\l -> GB.isLine l b0) GB.boardLines
                , test "Drawn full" <| assertEqual [] <| List.filterMap (\l -> GB.isLine l d9) GB.boardLines
                , test "Winning 3" <| assertEqual [X] <| List.filterMap (\l -> GB.isLine l w3) GB.boardLines
                , test "Winning 3'" <| assertEqual (Just X) <| GB.isLine (7, 5, 3) w3
                ]
              , suite "hasLine"
                [ test "Incomplete boards" <| assertEqual [] <| List.filterMap GB.hasLine [b0, x1, o1, b2, b3, d9]
                , test "Winning non-full board" <| assertEqual (Just (X, (3, 5, 7))) <| GB.hasLine w3
                , test "Winning full X board" <| assertEqual (Just (X, (1, 5, 9))) <| GB.hasLine x9
                , test "Winning full O board" <| assertEqual (Just (O, (1, 4, 7))) <| GB.hasLine o9
                ]
              , suite "emptySquares"
                [ test "Empty board" <| assertEqual [1, 2, 3, 4, 5, 6, 7, 8, 9] <| GB.emptySquares b0
                , test "One piece X board" <| assertEqual [1, 2, 4, 5, 6, 7, 8, 9] <| GB.emptySquares x1
                , test "One piece O board" <| assertEqual [1, 2, 4, 5, 6, 7, 8, 9] <| GB.emptySquares o1
                , test "Two piece board" <| assertEqual [1, 2, 4, 6, 7, 8, 9] <| GB.emptySquares b2
                , test "Three piece board 1" <| assertEqual [2, 3, 4, 5, 8, 9] <| GB.emptySquares b3
                , test "Three piece board 2" <| assertEqual [1, 2, 4, 6, 8, 9] <| GB.emptySquares w3
                , test "Eight piece board" <| assertEqual [7] <| GB.emptySquares b8
                , test "Full boards" <| assertEqual [[], [], []] <| List.map GB.emptySquares [d9, x9, o9]
              ]
            ]

main : Element
main =
    elementRunner tests
