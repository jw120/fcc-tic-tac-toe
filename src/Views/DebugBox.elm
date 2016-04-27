module Views.DebugBox (view) where

{-| Renderer for the debug text

@doc view

-}


import Html
import Html.Attributes


{-| Render the debug box -}
view : (Bool, String) -> Html.Html
view (debugOn, message) =
  Html.div
    [ Html.Attributes.class "debug-box" ]
    [ Html.text <| if debugOn then message else "" ]
