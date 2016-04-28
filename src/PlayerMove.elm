module PlayerMove (update) where

{-|

Module to handle a player move: validates that it represents a valid mode and then adds a
computer move in response.

@doc update

-}

import Result exposing (andThen)

import Board exposing (Square)
import Models exposing (Model, State(..))

{-

We use a `Result Model Model` version of `Result error value` where the
error value represents a non-continuing model state (invalid move of game over)

-}


update : Board.Square -> Models.Model -> Models.Model
update square model =
  checkGameContinues model
    |> (flip andThen) (applyPlayerMove square)
    |> (flip andThen) checkGameContinues
    |> (flip andThen) getComputerMove
    |> (flip andThen) checkGameContinues
    |> extractModel


applyPlayerMove : Square -> Model -> Result Model Model
applyPlayerMove square model =
  if Board.isEmptySquare square model.board then
    Ok { model | board = Board.addPiece square (model.player) model.board }
  else
    Err model


checkGameContinues : Model -> Result Model Model
checkGameContinues model =
  case Board.hasLine model.board of
    Just (player, line) ->
      Err { model
          | state = Won player
          , message = toString player ++ " wins!"
          }

    Nothing ->
      if Board.isFull model.board then
        Err { model
            | state = Draw
            , message = "Drawn"
            }
      else
        Ok model


getComputerMove : Model -> Result Model Model
getComputerMove model =
  Ok model


extractModel : Result Model Model -> Model
extractModel result =
  case result of
    Err a ->
      a

    Ok b ->
      b
