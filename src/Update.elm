module Update (update) where

{-|

@doc update

-}


import Actions
import Models
import PlayerMove


update : Actions.Action -> Models.Model -> Models.Model
update action model =
  case action of
    Actions.NoOp ->
      { model
      | lastAction = Actions.NoOp
      }

    Actions.StartAsBatsu ->
      { model
      | lastAction = Actions.StartAsBatsu
      }

    Actions.StartAsMaru ->
      { model
      | lastAction = Actions.StartAsMaru
      }

    Actions.Click square ->
      { model | lastAction = Actions.Click square }
        |> PlayerMove.update square
