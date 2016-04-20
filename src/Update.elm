module Update where

import Actions
import Models

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
