module Models (..) where

import Game.Board

import Actions


type alias Model =
  { board : Game.Board.Board
  , debugMode : Bool
  , lastAction : Actions.Action
  }

initialModel : Model
initialModel =
  { board = Game.Board.emptyBoard
  , debugMode = True
  , lastAction = Actions.NoOp
  }

-- For debugging
showAppModel : Model -> String
showAppModel =
  toString
