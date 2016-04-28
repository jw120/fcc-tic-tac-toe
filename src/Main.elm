module Main (main) where

import Effects
import Html
import Keyboard
import Signal
import StartApp
import Task

import KeyPresses
import Models
import MouseClick
import Update
import Views.View


app : StartApp.App Models.Model
app =
  StartApp.start
    { init = ( Models.initialModel, Effects.none )
    , inputs = [ MouseClick.signal, Signal.map KeyPresses.handler Keyboard.presses ]
    , update = (\a m -> (Update.update a m, Effects.none))
    , view = Views.View.view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
  app.tasks
