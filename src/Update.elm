module Update where

import Actions
import Game.Board
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

    Actions.Click square ->
      { model
      | lastAction = Actions.Click square
      , board = Game.Board.addPiece square Game.Board.X model.board
      }
