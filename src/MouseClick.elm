module MouseClick (signal) where

{- |

Create a signal from mouse clicks on the board to plug into StartApp

@doc signal

-}


import Mouse
import Signal

import Actions
import ViewConstants exposing (squareSize, clickableFraction)



signal : Signal.Signal Actions.Action
signal =
    Signal.sampleOn Mouse.clicks Mouse.position
      |> Signal.map decodePosition


decodePosition : (Int, Int) -> Actions.Action
decodePosition (x, y) =
  let
    -- (xSquare, ySquare) are the coordinates of the click scaled by the squareSize
    xSquare : Int
    xSquare = x // (round squareSize)
    ySquare : Int
    ySquare = y // (round squareSize)
    -- (xOffset, yOffset) are the distances fromt the centre of the square as a fraction of the squareSize
    xOffset : Float
    xOffset = abs ((toFloat x - squareSize * (toFloat xSquare + 0.5)) / (0.5 * squareSize))
    yOffset : Float
    yOffset = abs ((toFloat y - squareSize * (toFloat ySquare + 0.5)) / (0.5 * squareSize))
  in
    if xSquare < 0 || xSquare > 2 || ySquare < 0 || ySquare > 2  then
      Actions.NoOp -- Clicked outside the board
    else if xOffset > clickableFraction || yOffset > clickableFraction then
      Actions.NoOp -- Clicked too far away from centre
    else
      Actions.PlayerMoved (1 + xSquare + 3 * ySquare)
