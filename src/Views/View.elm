module Views.View (..) where

{-| Top-level renderer

@doc view

-}


import Html
import Signal

import Views.Board
import Views.Buttons
import Views.DebugBox
import Views.MessageBox

import Actions
import Models


view : Signal.Address Actions.Action -> Models.Model -> Html.Html
view address model =
  Html.div
    []
    [ Views.Board.view model.board
    , Views.Buttons.view address
    , Views.MessageBox.view model.message
    , Views.DebugBox.view (model.debugMode, toString model)
    ]
