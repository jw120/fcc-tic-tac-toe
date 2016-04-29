module Actions (Action(..)) where

{-|

@doc Action

-}


import Board

type Action
  = NoOp
  | StartAsBatsu -- Player clicks to (re)-start as X
  | StartAsMaru -- Player clicks to (re)-start as O
  | PlayerMoved Board.Square -- Player clicks on a board square
  | ComputerMoved Board.Board -- After computer moves
  | ToggleDebug -- Player presses d
