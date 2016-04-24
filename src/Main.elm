module Main (main) where

import Effects
import Html
import Signal
import StartApp
import Task

import Models
import MouseHandler
import Update
import Views.View


app : StartApp.App Models.Model
app =
  StartApp.start
    { init = ( Models.initialModel, Effects.none )
    , inputs = [ MouseHandler.clickSignal ]
    , update = (\a m -> (Update.update a m, Effects.none))
    , view = Views.View.view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
  app.tasks
