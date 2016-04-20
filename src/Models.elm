module Models (..) where

import Actions
import Dict

{-
1 2 3
4 5 6
7 8 9
-}
type alias Square =
  Int

type Piece
  = X | O

type alias Board =
  Dict.Dict Square Piece

type alias Line =
  (Square, Square, Square)

has : Board -> Square -> Piece -> Bool
has board square piece =
  Dict.get square board == Just piece

isEmptySquare : Board -> Square -> Bool
isEmptySquare board square =
  Dict.get square board == Nothing

type alias Model =
  { board : Board
  , debugMode : Bool
  , lastAction : Actions.Action
  }

initialModel : Model
initialModel =
  { board = Dict.empty
  , debugMode = True
  , lastAction = Actions.NoOp
  }

-- For debugging
showAppModel : Model -> String
showAppModel =
  toString
