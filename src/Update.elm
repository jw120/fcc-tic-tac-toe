module Update (update) where

{-|

@doc update

-}


import Actions
import Board
import Models exposing (reset)
import PlayerMove


update : Actions.Action -> Models.Model -> Models.Model
update action model =
  case action of
    Actions.NoOp ->
      { model
      | lastAction = Actions.NoOp
      }

    Actions.StartAsBatsu ->
      reset Board.X { model | lastAction = Actions.StartAsBatsu }

    Actions.StartAsMaru ->
      reset Board.O { model | lastAction = Actions.StartAsBatsu }

    Actions.Click square ->
      { model | lastAction = Actions.Click square }
        |> PlayerMove.update square

    Actions.ToggleDebug ->
      { model
      | lastAction = Actions.ToggleDebug
      , debugMode = not model.debugMode
      }
