module Actions (Action(..)) where

{-|

@doc Action

-}


import Board

type Action
  = NoOp
  | StartAsBatsu -- Player clicks to (re)-start as X
  | StartAsMaru -- Player clicks to (re)-start as O
  | Click Board.Square -- Player clicks on a board square
  | ToggleDebug -- Player presses d
