module Actions (Action(..)) where

{-|

@doc Action

-}

import Random
import Time

import Board

type Action
  = NoOp
  | StartAsBatsu -- Player clicks to (re)-start as X
  | StartAsMaru -- Player clicks to (re)-start as O
  | PlayerMoved Board.Square -- Player clicks on a board square
  | ComputerMoved (Random.Seed, Board.Board) -- After computer moves
  | ToggleDebug -- Player presses d
  | StartingTick Time.Time -- Called from init to put currentTime into seed
