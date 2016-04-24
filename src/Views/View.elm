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
    [ Views.Board.view model.board
    , Views.Buttons.view address
    , Views.DebugBox.view (model.debugMode, Models.showAppModel model)
    ]
