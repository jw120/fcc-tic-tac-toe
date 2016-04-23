module Game.ScoreProp (allClaims) where

import Check exposing (that, is, for)

import Game.Board as GB exposing (Board, Piece(..), Square)
import Game.Score as GS exposing (Score)
import Game.BoardProp


allClaims : Check.Claim
allClaims =
  Check.suite
    "Game.Score properties"
    [ scoreProperties
    ]


scoreProperties : Check.Claim
scoreProperties =
  Check.suite
    "score properties"
    [ Check.claim
      "Opposite sides have negated scores"
      `that` (\bl -> let b = GB.fromList bl in GS.score b X + GS.score b O)
      `is` always 0
      `for` Game.BoardProp.boardListProducer
    ]
