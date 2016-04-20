module Views.View (..) where

import Html
import Signal

import Views.Board
import Views.Buttons
import Views.DebugBox

import Actions
import Models

view : Signal.Address Actions.Action -> Models.Model -> Html.Html
view address model =
  Html.div
    []
    [ Views.Board.view address model
    , Views.Buttons.view address model
    , Views.DebugBox.view address model
    ]
