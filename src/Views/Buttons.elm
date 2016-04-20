module Views.Buttons (..) where

import Html
import Html.Attributes
import Html.Events
import Signal

import Actions
import Models

view : Signal.Address Actions.Action -> Models.Model -> Html.Html
view address model =
  Html.div
    []
    [ playButton address Actions.StartAsBatsu "Start as X"
    , playButton address Actions.StartAsMaru "Start as O"
    ]

playButton : Signal.Address Actions.Action -> Actions.Action -> String -> Html.Html
playButton address action label =
  Html.button
    [ Html.Attributes.class "play-button"
    , Html.Events.onClick address action
    ]
    [ Html.text label ]
