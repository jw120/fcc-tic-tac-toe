module Views.MessageBox (view) where

{-| Renderer for the message

@doc view

-}

import Html
import Html.Attributes


{-| Render the message box -}
view : String -> Html.Html
view message =
  Html.div
    [ Html.Attributes.class "message-box" ]
    [ Html.text <| message ]
