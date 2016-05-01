
module BoardProp (allClaims, boardListProducer) where

import Check exposing (that, is, for)
import Check.Producer as Producer
import List
import Random
import Shrink

import Board exposing (Board, Piece(..), Square)

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

allClaims : Check.Claim
allClaims =
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
      `that` (\(s, p, bl) -> Board.isValid (Board.addPiece s p (Board.fromList bl)))
      `is` (\_ -> True)
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    , Check.claim
      "Adding a piece gives a board with that piece"
      `that` (\(s, p, bl) -> Board.getPiece s (Board.addPiece s p (Board.fromList bl)))
      `is` (\(_, p, bl) -> Just p)
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    , Check.claim
      "Adding a piece is idempotent"
      `that` (\(s, p, bl) -> Board.addPiece s p (Board.addPiece s p (Board.fromList bl)))
      `is` (\(s, p, bl) -> Board.addPiece s p (Board.fromList bl))
      `for` Producer.tuple3 (squareProducer, pieceProducer, boardListProducer)
    ]

emptySquareProperties : Check.Claim
emptySquareProperties =
  Check.suite
    "emptySquares properties"
    [ Check.claim
      "emptySquares counts correctly"
      `that` (Board.fromList >> Board.emptySquares >> List.length)
      `is` (List.length >> (\n -> 9 - n))
      `for` boardListProducer
    ]

-- validate thatlines returned by hasLine are lines`
hasTriggersWithLine : Board -> Bool
hasTriggersWithLine b =
  case Board.hasLine b of
    Just (p, (s1, s2, s3)) ->
      Board.getPiece s1 b == Just p &&
      Board.getPiece s2 b == Just p &&
      Board.getPiece s3 b == Just p

    Nothing ->
      True

lineProperties : Check.Claim
lineProperties =
  Check.suite
    "line properties"
    [ Check.claim
      "hasLine triggers isLine"
      `that` (Board.fromList >> hasTriggersWithLine)
      `is` always True
      `for` boardListProducer
    ]
