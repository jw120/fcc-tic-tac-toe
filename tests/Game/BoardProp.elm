
module Game.BoardProp (all) where

import Check exposing (that, is, for)
import Check.Producer as Producer
import List
import Random
import Shrink

import Game.Board as GB exposing (Board, Piece(..), Square)

{-

Producers to generate random instances for checking

-}

-- Don't use Producer.rangedInt as it needlessly shrinks to 0
squareProducer : Producer.Producer Square
squareProducer =
  { generator = Random.int 1 9
  , shrinker = Shrink.noShrink
  }

-- Don't use Producer.bool as it needlessly shrinks True to False
pieceProducer : Producer.Producer Piece
pieceProducer =
  { generator = Random.map (\b -> if b then X else O) Random.bool
  , shrinker = Shrink.noShrink
  }

maybeSquareGenerator : Random.Generator (Maybe Piece)
maybeSquareGenerator =
  Random.int 0 2
    |> Random.map (\x -> case x of
        1 -> Just X
        2 -> Just O
        _ -> Nothing)

boardListGenerator : Random.Generator (List (Square, Piece))
boardListGenerator =
  Random.list 9 maybeSquareGenerator
    |> Random.map (List.indexedMap (\i -> Maybe.map (\p -> (i + 1, p))))
    |> Random.map (List.filterMap identity)

boardListProducer : Producer.Producer (List (Square, Piece))
boardListProducer =
  { generator = boardListGenerator
  , shrinker = Shrink.list Shrink.noShrink
  }

{-

Claims

-}

all : Check.Claim
all =
  Check.suite
    "Game.Board properties"
    [ addPieceProperties
    , emptySquareProperties
    , lineProperties
    ]
    

addPieceProperties : Check.Claim
addPieceProperties =
  Check.suite
    "addPiece properties"
    [ Check.claim
      "Adding a piece always gives a valid board"
      `that` (\(s, p, bl) -> GB.isValid (GB.addPiece s p (GB.fromList bl)))
      `is` (\_ -> True)
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    , Check.claim
      "Adding a piece gives a board with that piece"
      `that` (\(s, p, bl) -> GB.getPiece s (GB.addPiece s p (GB.fromList bl)))
      `is` (\(_, p, bl) -> Just p)
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    , Check.claim
      "Adding a piece is idempotent"
      `that` (\(s, p, bl) -> GB.addPiece s p (GB.addPiece s p (GB.fromList bl)))
      `is` (\(s, p, bl) -> GB.addPiece s p (GB.fromList bl))
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    ]

emptySquareProperties : Check.Claim
emptySquareProperties =
  Check.suite
    "emptySquares properties"
    [ Check.claim
      "emptySquares counts correctly"
      `that` (GB.fromList >> GB.emptySquares >> List.length)
      `is` (List.length >> (\n -> 9 - n))
      `for` boardListProducer
    ]

-- validate that if lines returned by hasLine are found by isLine
hasTriggersIs : Board -> Bool
hasTriggersIs b =
  case GB.hasLine b of
    Just (p, l) -> GB.isLine l b == Just p
    Nothing -> True

lineProperties : Check.Claim
lineProperties =
  Check.suite
    "line properties"
    [ Check.claim
      "hasLine triggers isLine"
      `that` (GB.fromList >> hasTriggersIs)
      `is` always True
      `for` boardListProducer
    ]
