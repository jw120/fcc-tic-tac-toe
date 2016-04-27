module Game.ComputerMove (..) where

{-|

Module to generate a computer move

@doc move

-}


import List
import Maybe

import Board exposing (Board, Piece(..), Square)


type alias Score =
  Int

type alias Move =
  (Piece, Square, Board)

type alias Response
  = Lost -- Computer has lost (and does not move)
  | ContinuingMove Move -- Computer moves and game continues
  | WinningMove Move -- Computer moves and wins
  | DrawingMove Move -- Computer moves and board is drawn and full

type GameState
  = Won Piece
  | Draw
  | Ongoing
  | Start -- no pieces on board


{-
Need to separate point-of-view from who is about to play
Use +100 for X and -100 for O?

-}

move : Board -> Piece -> Maybe Move
move board piece =
  Nothing

-- Evaluate the position for given side (who is about to play), +100 X win to -100 O win scale
score : Board -> Piece -> Score
score board ourSide =
  case gameState board of
    Won X ->
      100

    Won O ->
      -100

    Draw ->
      0

    Start ->
      0

    Ongoing ->
      let
        moves : List Move
        moves = availableMoves board ourSide
        scoredMoves : List (Move, Score)
        scoredMoves = List.map addScore moves
        listBest : List comparable -> Maybe comparable
        listBest = if ourSide == X then List.maximum else List.minimum
        bestScore : Maybe Score
        bestScore = List.map snd scoredMoves
          |> listBest
      in
        List.map snd scoredMoves
          |> listBest
          |> Maybe.withDefault 0 -- 0 score if no moves

availableMoves : Board -> Piece -> List Move
availableMoves board piece =
  GB.emptySquares board
    |> List.map (\square -> (piece, square, GB.addPiece square piece board))

addScore : Move -> (Move, Score)
addScore (piece, square, board) =
  ((piece, square, board), score (GB.addPiece square piece board) (GB.opposite piece))


gameState : Board -> GameState
gameState board =
  case GB.hasLine board of
    Just (X, _) ->
      Won X

    Just (O, _) ->
      Won O

    Nothing ->
      if GB.isFull board then
        Draw
      else if GB.isEmpty board then
        Start
      else
        Ongoing
