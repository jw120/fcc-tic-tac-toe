module Move (player, computer) where

{-|

Module to handle move, including validation and checking of game state

@doc player, computer

-}

import Effects
import Random
import Result exposing (andThen)

import Actions
import Board exposing (Square)
import Computer
import Models exposing (Model)

{-

Note: To capture the multiple-conditionals we use a `Result Model Model` version of `Result error value` where the
error value represents a non-continuing model state (invalid move or game over)

-}


{-| Handle an attemped player move including move validation, checking game over and
    triggering computer response -}
player : Board.Square -> Models.Model -> (Models.Model, Effects.Effects Actions.Action)
player square model =
    checkGameContinues model
    |> (flip andThen) (applyPlayerMove square)
    |> (flip andThen) checkGameContinues
    |> (\result -> case result of
      Ok updatedModel
        -> (updatedModel, Computer.moveEffect model.seed (Board.opposite model.player) updatedModel.board)

      Err errorModel
        -> (errorModel, Effects.none))


{-| Handle a computer move -}
computer : Random.Seed -> Board.Board -> Models.Model -> Models.Model
computer newSeed newBoard model =
  { model | board = newBoard, seed = newSeed }
    |> checkGameContinues
    |> (\result -> case result of
      Ok continuingModel
        -> continuingModel

      Err finishedModel
        -> finishedModel)


applyPlayerMove : Square -> Model -> Result Model Model
applyPlayerMove square model =
  if Board.isEmptySquare square model.board then
    Ok { model | board = Board.addPiece square (model.player) model.board }
  else -- just ignore an invalid move
    Err model


checkGameContinues : Model -> Result Model Model
checkGameContinues model =
  case Board.hasLine model.board of
    Just (player, line) ->
      Err { model
          | message = toString player ++ " wins!"
          }

    Nothing ->
      if Board.isFull model.board then
        Err { model
            | message = "Drawn"
            }
      else
        Ok model


getComputerMove : Model -> Result Model Model
getComputerMove model =
  let
    computer = Board.opposite model.player
  in
    case Computer.move model.seed (model.board) computer of
      (seed', Just (_, _, newBoard)) ->
        Ok { model | board = newBoard, seed = seed' }

      (seed', Nothing) ->
        Err { model | message = "Failed to find a computer move", seed = seed' } -- should not happen
