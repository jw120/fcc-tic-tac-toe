module Game.ScoreTest (allTests) where

import ElmTest exposing (..)

import Board exposing (Board, Piece(..), Square)
import Game.Score as GS

{-

Test positions:

b3    x8    o8    b8    d9    x9    o9
X..   XOO   OXO   .OO   XOX   XOX   OOX
..X   OXX   XXO   XOX   OOX   OXO   OXO
O..   XO.   XO.   XXO   OXO   OOX   OXX

-}


allTests : Test
allTests =
  let
    b0 = Board.fromList []
    x1 = Board.fromList [(3, X)]
    o1 = Board.fromList [(3, O)]
    b2 = Board.fromList [(3, X), (5, O)]
    b3 = Board.fromList [(1, X), (6, X), (7, O)]
    w3 = Board.fromList [(3, X), (5, X), (7, X)]
    x8 = Board.fromList [(1, X), (2, O), (3, O), (4, O), (5, X), (6, X), (7, X), (8, O)]
    o8 = Board.fromList [(1, O), (2, X), (3, O), (4, X), (5, X), (6, O), (7, X), (8, O)]
    b8 = Board.fromList [(2, O), (3, O), (4, X), (5, O), (6, X), (7, X), (8, X), (9, O)]
    d9 = Board.fromList [(1, X), (2, O), (3, X), (4, O), (5, O), (6, X), (7, O), (8, X), (9, O)]
    x9 = Board.fromList [(1, X), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, O), (9, X)]
    o9 = Board.fromList [(1, O), (2, O), (3, X), (4, O), (5, X), (6, O), (7, O), (8, X), (9, X)]
  in
    suite
      "Scoring"
       [ suite "winning positions"
          [ test "X won for X" <| assertEqual 100 <| GS.score x9 X
          , test "X won for O" <| assertEqual 100 <| GS.score x9 O
          , test "O won for X" <| assertEqual -100 <| GS.score o9 X
          , test "O won for O" <| assertEqual -100 <| GS.score o9 O
          , test "Draw for X" <| assertEqual 0 <| GS.score d9 X
          , test "Draw for O" <| assertEqual 0 <| GS.score d9 O
          ]
      , suite "one move available positions"
         [ test "X to play and win for X" <| assertEqual 100 <| GS.score x8 X
         , test "X to play and win for O" <| assertEqual 0 <| GS.score x8 O
         , test "O to play and win for X" <| assertEqual 0 <| GS.score o8 X
         , test "O to play and win for O" <| assertEqual -100 <| GS.score o8 O
         , test "XO to play and win for X" <| assertEqual 100 <| GS.score b8 X
         , test "XO to play and win for O" <| assertEqual -100 <| GS.score b8 O
         ]
     , suite "3 piece board"
        [ test "X to play" <| assertEqual 100 <| GS.score b3 X
        , test "O to play"  <| assertEqual 0 <| GS.score b3 O
        ]
     , suite "1 piece board"
        [ test "X to play" <| assertEqual 0 <| GS.score o1 X
        , test "O to play"  <| assertEqual 0 <| GS.score x1 O
        ]
    , suite "empty board"
       [ test "X to play" <| assertEqual 0 <| GS.score b0 X
       , test "O to play"  <| assertEqual 0 <| GS.score b0 O
       ]
      , suite "availableMoves helper"
        [ test "Empty board"
          <| assertEqual (List.map (\i -> (X, i, Board.addPiece i X b0)) [1..9])
          <| GS.availableMoves b0 X
        , test "Full boards"
          <| assertEqual [[], [], [], [], [], []]
          <|
            [ GS.availableMoves d9 X
            , GS.availableMoves d9 O
            , GS.availableMoves x9 X
            , GS.availableMoves x9 O
            , GS.availableMoves o9 X
            , GS.availableMoves o9 O
            ]
        ]
      ]
