module Computer (move, moveEffect) where

{-|

Logic to generate a computer move

@doc move, moveEffect

-}


import Effects
import List
import List.Nonempty exposing ((:::))
import Maybe
import Random
import Task

import Actions
import Board exposing (Board, Piece(..), Square)
import RandomChoice


type alias Score =
  Int

type alias Move =
  (Piece, Square, Board)


{-| Generate the computer's move on given board for the given side -}
move : Random.Seed -> Board -> Piece -> (Random.Seed, Maybe Move)
move seed board player =
  case Board.toList board of
    [] ->
      heuristicEmpty seed board player

    [(square, _)] ->
      heuristicOne seed square board player

    _ ->
      bestScoredMove player board
        |> Maybe.map fst
        |> (\m -> (seed, m))


{-| Create an effect which will generate the computer's move -}
moveEffect : Random.Seed -> Board.Piece -> Board.Board -> Effects.Effects Actions.Action
moveEffect seed player board =
  let
    toAction : (Random.Seed, Maybe Move) -> Actions.Action
    toAction (seed', m) =
      Maybe.map (\(_, _, b) -> b) m
        |> Maybe.withDefault board
        |> (\b -> Actions.ComputerMoved (seed', b))
  in
    Task.succeed ()
      |> Task.map (\() -> toAction (move seed board player))
      |> Effects.task


{-| Heuristic for moving on an empty board: always play in centre -}
heuristicEmpty : Random.Seed -> Board -> Piece -> (Random.Seed, Maybe Move)
heuristicEmpty seed board player =
  (seed, Just (player, 5, Board.addPiece 5 player board))


{-| Heuristic for moving on a board with one piece -}
heuristicOne : Random.Seed -> Square -> Board -> Piece -> (Random.Seed, Maybe Move)
heuristicOne seed occupied board player =
  let
    (seed', response) = if occupied == 5 then
        RandomChoice.fromList seed (List.Nonempty.Nonempty 2 [4, 6, 8])
    else
        (seed, 5)
  in
    (seed', Just (player, response, Board.addPiece response player board))


{- Main game logic function. Implements minimax. Return the best move in a list of moves with scores. Nothing if list is empty -}
bestScoredMove : Piece -> Board -> Maybe (Move, Score)
bestScoredMove player board =
  let
    moves : List Move
    moves = availableMoves board player
    scoredMoves : List (Move, Score)
    scoredMoves = List.map addScore moves
    optimizeForPlayer : List Score -> Score
    optimizeForPlayer =
        (if player == X then List.maximum else List.minimum)
          >> Maybe.withDefault 0
    bestScore : Score
    bestScore = List.map snd scoredMoves
      |> optimizeForPlayer
    bestScoredMoves : List (Move, Score)
    bestScoredMoves = List.filter (\(move, score) -> score == bestScore) scoredMoves
  in
    List.head bestScoredMoves


{- Helper function - calculates the score of a given board -}
score : Board -> Piece -> Score
score board player =
  case Board.hasLine board of
    Just (winner, _) ->
      if winner == X then 100 else -100

    Nothing ->
      if Board.isFull board then
        0
      else
        bestScoredMove player board
          |> Maybe.map snd
          |> Maybe.withDefault 0


{- Helper function that generates all possible moves -}
availableMoves : Board -> Piece -> List Move
availableMoves board piece =
  Board.emptySquares board
    |> List.map (\square -> (piece, square, Board.addPiece square piece board))


{- Helper function to add the score to a move -}
addScore : Move -> (Move, Score)
addScore (piece, square, board) =
  ((piece, square, board), score (Board.addPiece square piece board) (Board.opposite piece))
