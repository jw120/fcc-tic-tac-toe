module Views.DebugBox (..) where

import Html
import Html.Attributes
import Signal

import Actions
import Models

view : Signal.Address Actions.Action -> Models.Model -> Html.Html
view _ model =
  Html.div
    [ Html.Attributes.class "cdebug-box" ]
    [ Html.text <| if model.debugMode then Models.showAppModel model else "" ]
