module Game.ScoreTest (allTests) where

import ElmTest exposing (..)

import Game.Board as GB exposing (Board, Piece(..), Square)
import Game.Score as GS


allTests : Test
allTests =
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
      "Scoring"
       [ suite "winning positions"
          [ test "X won for X" <| assertEqual 100 <| GS.score x9 X
          , test "X won for O" <| assertEqual -100 <| GS.score x9 O
          , test "O won for X" <| assertEqual -100 <| GS.score o9 X
          , test "O won for O" <| assertEqual 100 <| GS.score o9 O
          , test "Draw for X" <| assertEqual 0 <| GS.score d9 X
          , test "Draw for O" <| assertEqual 0 <| GS.score d9 O
          ]
      ]
