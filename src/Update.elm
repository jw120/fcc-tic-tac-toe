module Update (update) where

{-|

@doc update

-}


import Actions
import Board
import Models exposing (initialModel)
import PlayerMove


update : Actions.Action -> Models.Model -> Models.Model
update action model =
  case action of
    Actions.NoOp ->
      { model
      | lastAction = Actions.NoOp
      }

    Actions.StartAsBatsu ->
      { initialModel
      | lastAction = Actions.StartAsBatsu
      , player = Board.X
      }

    Actions.StartAsMaru ->
      { initialModel
      | lastAction = Actions.StartAsMaru
      , player = Board.O
      }

    Actions.Click square ->
      { model | lastAction = Actions.Click square }
        |> PlayerMove.update square
