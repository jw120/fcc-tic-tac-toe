module Models (Model, State(..), initialModel) where

{-|

@doc Model, State, initialModel

-}


import Actions
import Board



type alias Model =
  { board : Board.Board
  , state : State
  , player : Board.Piece -- Side of our human player
  , message : String -- Message shown under the board (e.g., "You win")
  , debugMode : Bool  -- True means we show a debug box at the bottom of our view
  , lastAction : Actions.Action -- Held only to show in debug box
  }


type State
  = Won Board.Piece -- Given player has won the game
  | Draw -- Board is full with no winner
  | PreStart -- before player has selected a side
  | Ongoing -- any other game state


initialModel : Model
initialModel =
  { board = Board.emptyBoard
  , state = PreStart
  , player = Board.X -- dummy value for pre-start
  , message = ""
  , debugMode = True
  , lastAction = Actions.NoOp
  }
