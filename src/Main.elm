module Main (main) where

import Effects
import Html
-- import Keyboard
import StartApp
import Task

-- import Actions
import Models
--import Presses
import Update
import Views.View


app : StartApp.App Models.Model
app =
  StartApp.start
    { init = ( Models.initialModel, Effects.none )
    , inputs = [ ]
    , update = (\a m -> (Update.update a m, Effects.none))
    , view = Views.View.view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
  app.tasks
