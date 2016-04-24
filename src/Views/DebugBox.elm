module Views.DebugBox (..) where

import Html
import Html.Attributes


view : (Bool, String) -> Html.Html
view (debugOn, message) =
  Html.div
    [ Html.Attributes.class "debug-box" ]
    [ Html.text <| if debugOn then message else "" ]
