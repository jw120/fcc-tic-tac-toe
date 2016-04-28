module KeyPresses (..) where

import Char

import Actions

handler : Int -> Actions.Action
handler key =
  case Char.fromCode key of
    'd' -> Actions.ToggleDebug
    'D' -> Actions.ToggleDebug
    _ -> Actions.NoOp
