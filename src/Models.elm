module Models (Model, initial, reset) where

{-|

@doc Model, initialModel, reset

-}


import Effects
import Random

import Actions
import Board
import Computer


type alias Model =
  { board : Board.Board
  , player : Board.Piece -- Side of our human player
  , message : String -- Message shown under the board (e.g., "You win")
  , debugMode : Bool  -- True means we show a debug box at the bottom of our view
  , seed : Random.Seed
  , lastAction : Actions.Action -- Held only to show in debug box
  }


initial : (Model, Effects.Effects Actions.Action)
initial =
  ( { board = Board.emptyBoard
  , player = Board.X
  , message = ""
  , debugMode = False
  , lastAction = Actions.NoOp
  , seed = Random.initialSeed 0 -- replaced via StartingTick
  }, Effects.tick Actions.StartingTick )


-- reset the model for a new game
reset : Board.Piece -> Model -> (Model, Effects.Effects Actions.Action)
reset player model =
  let
    baseModel =
      { model
      | board = Board.emptyBoard
      , message = ""
      , player = player
      }
  in case player of
    Board.X ->
      ( baseModel, Effects.none)

    Board.O ->
      ( baseModel, Computer.moveEffect model.seed Board.X baseModel.board )
