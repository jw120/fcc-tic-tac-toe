module BoardTest (allTests) where

import ElmTest exposing (..)

import Board exposing (Board, Piece(..), Square)



-- Avoid using == on Dicts
assertBoardEqual : Board -> Board -> Assertion
assertBoardEqual b1 b2 =
    assertEqual (Board.toList b1) (Board.toList b2)

allTests : Test
allTests =
    let
        b0 = Board.fromList []
        x1 = Board.fromList [(3, X)]
        o1 = Board.fromList [(3, O)]
        b2 = Board.fromList [(3, X), (5, O)]
        b3 = Board.fromList [(1, X), (6, X), (7, O)]
        w3 = Board.fromList [(3, X), (5, X), (7, X)]
        b8 = Board.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (8, X), (9, O)]
        d9 = Board.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (7, O), (8, X), (9, O)]
        x9 = Board.fromList [(1, X), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, O), (9, X)]
        o9 = Board.fromList [(1, O), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, X), (9, X)]
    in
        suite
            "Board - helper functions"
             [ suite "emptyBoard"
                [ test "Empty board" <| assertBoardEqual b0 <| Board.emptyBoard
                ]
            , suite "addPiece"
                [ test "First add" <| assertBoardEqual x1 <| Board.addPiece 3 X Board.emptyBoard
                , test "Second add" <| assertBoardEqual b2 <| Board.addPiece 5 O x1
                , test "Replace"  <| assertBoardEqual o1 <| Board.addPiece 3 O x1
                ]
            -- , suite "isPiece"
            --     [ test "Empty cell" <| assert <| not <| Board.isPiece 5 X b3
            --     , test "X cell" <| assert <| Board.isPiece 6 X b3
            --     , test "O cell" <| assert <| Board.isPiece 7 O b3
            --     , test "!X cell" <| assert <|  not <| Board.isPiece 6 O b3
            --     , test "!O cell" <| assert <|  not <| Board.isPiece 7 X b3
            --     ]
            -- , suite "isEmptySquare"
            --     [ test "Empty cell" <| assert <| Board.isEmptySquare 5 b3
            --     , test "X cell" <| assert <| not <| Board.isEmptySquare 6 b3
            --     , test "O cell" <| assert <| not <| Board.isEmptySquare 7 b3
            --     ]
             , suite "isFull"
                [ test "Full board" <| assert <| Board.isFull d9
                , test "Non-full board" <| assert <| not <| Board.isFull b8
                , test "Empty board" <| assert <| not <| Board.isFull b0
                ]
            --  , suite "isLine"
            --     [ test "Empty board" <| assertEqual [] <| List.filterMap (\l -> Board.isLine l b0) Board.boardLines
            --     , test "Drawn full" <| assertEqual [] <| List.filterMap (\l -> Board.isLine l d9) Board.boardLines
            --     , test "Winning 3" <| assertEqual [X] <| List.filterMap (\l -> Board.isLine l w3) Board.boardLines
            --     , test "Winning 3'" <| assertEqual (Just X) <| Board.isLine (7, 5, 3) w3
            --     ]
              , suite "hasLine"
                [ test "Incomplete boards" <| assertEqual [] <| List.filterMap Board.hasLine [b0, x1, o1, b2, b3, d9]
                , test "Winning non-full board" <| assertEqual (Just (X, (3, 5, 7))) <| Board.hasLine w3
                , test "Winning full X board" <| assertEqual (Just (X, (1, 5, 9))) <| Board.hasLine x9
                , test "Winning full O board" <| assertEqual (Just (O, (1, 4, 7))) <| Board.hasLine o9
                ]
              , suite "emptySquares"
                [ test "Empty board" <| assertEqual [1, 2, 3, 4, 5, 6, 7, 8, 9] <| Board.emptySquares b0
                , test "One piece X board" <| assertEqual [1, 2, 4, 5, 6, 7, 8, 9] <| Board.emptySquares x1
                , test "One piece O board" <| assertEqual [1, 2, 4, 5, 6, 7, 8, 9] <| Board.emptySquares o1
                , test "Two piece board" <| assertEqual [1, 2, 4, 6, 7, 8, 9] <| Board.emptySquares b2
                , test "Three piece board 1" <| assertEqual [2, 3, 4, 5, 8, 9] <| Board.emptySquares b3
                , test "Three piece board 2" <| assertEqual [1, 2, 4, 6, 8, 9] <| Board.emptySquares w3
                , test "Eight piece board" <| assertEqual [7] <| Board.emptySquares b8
                , test "Full boards" <| assertEqual [[], [], []] <| List.map Board.emptySquares [d9, x9, o9]
              ]
            ]
