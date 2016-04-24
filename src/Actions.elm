module Actions (..) where

import Game.Board

type Action
  = NoOp
  | StartAsBatsu
  | StartAsMaru
  | Click Game.Board.Square
