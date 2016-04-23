module Game.Score (..) where

import List
import Maybe

import Game.Board as GB exposing (Board, Piece(..), Square)


type alias Score =
  Int

type alias Move =
  (Piece, Square, Board)

type GameState
  = Won Piece
  | Draw
  | Ongoing


-- Evaluate the position for given side (who is about to play), +100 to -100 scale
score : Board -> Piece -> Score
score board ourSide =
  case gameState board of
    Won winner ->
      if winner == ourSide then 100 else -100

    Draw ->
      0

    Ongoing ->
      let
        moves : List Move
        moves = availableMoves board ourSide
        scoredMoves : List (Move, Score)
        scoredMoves = List.map addScore moves
        bestScore : Maybe Score
        bestScore = List.maximum <| List.map snd scoredMoves
      in
        List.map snd scoredMoves
          |> List.maximum
          |> Maybe.withDefault 0 -- 0 score if no moves

availableMoves : Board -> Piece -> List Move
availableMoves board piece =
  GB.emptySquares board
    |> List.map (\square -> (piece, square, GB.addPiece square piece board))

addScore : Move -> (Move, Score)
addScore (piece, square, board) =
  ((piece, square, board), score (GB.addPiece square piece board) piece)


gameState : Board -> GameState
gameState board =
  case GB.hasLine board of
    Just (X, _) ->
      Won X

    Just (O, _) ->
      Won O

    Nothing ->
      if GB.isFull board then Draw else Ongoing

{-

Suppose we have board state

B = abO
    cOX
    XXO

And it is X to play.

X has four available moves to [a, b, c]
After X has played the board could be in the states [B'Xa, B'Xb, B'Xc]





-}
