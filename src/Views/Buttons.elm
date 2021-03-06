module Views.Buttons (view) where

{-| Renderer for the start buttons

@doc view

-}


import Html
import Html.Attributes
import Html.Events
import Signal

import Actions


{-| Render the two start buttons -}
view : Signal.Address Actions.Action -> Html.Html
view address =
  Html.div
    [ Html.Attributes.class "play-button-box"]
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
