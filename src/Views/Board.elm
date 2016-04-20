module Views.Board (..) where

import Color
import Graphics.Collage as GC exposing (defaultLine)
import Html
import Signal

import Actions
import Models

-- Board is made of 100x100 squares
squareSize : Float
squareSize =
  100.0

boardSize : Int
boardSize =
  round (3 * squareSize)

maruFraction : Float
maruFraction =
  0.3

batsuFraction : Float
batsuFraction =
  0.3

gridLineStyle : GC.LineStyle
gridLineStyle =
  { defaultLine
  | width = 2
  }

maruLineStyle : GC.LineStyle
maruLineStyle =
  { defaultLine
  | color = Color.red
  , width = 10
  }

batsuLineStyle : GC.LineStyle
batsuLineStyle =
  { defaultLine
  | color = Color.blue
  , width = 10
  }

dummyMailbox : Signal.Mailbox ()
dummyMailbox = Signal.mailbox ()

dummySignal : Signal.Message
dummySignal =
  Signal.message dummyMailbox.address ()


{-
My understanding of Graphics types
Element - For rendering
Form - Main focus of the Graphcs.Collage model
Shape/Path - geometric path (no styles), converted to Form with traced etc
-}

-- view : Signal.Address Action -> Models.AppModel -> Html.Html
view : Signal.Address Actions.Action -> Models.Model -> Html.Html
view address model =
    GC.collage boardSize boardSize (boardFrame ++ [ maru, batsu ])
      |> Html.fromElement
      -- |> (\e -> Html.div [ Html.Events.onclick address ])

boardFrame : List GC.Form
boardFrame =
  let
    tr = GC.traced gridLineStyle
  in
    [ tr <| GC.segment ( -1.5 * squareSize,  0.5 * squareSize ) (  1.5 * squareSize,  0.5 * squareSize)
    , tr <| GC.segment ( -1.5 * squareSize, -0.5 * squareSize ) (  1.5 * squareSize, -0.5 * squareSize)
    , tr <| GC.segment ( -0.5 * squareSize, -1.5 * squareSize ) ( -0.5 * squareSize,  1.5 * squareSize)
    , tr <| GC.segment (  0.5 * squareSize, -1.5 * squareSize ) (  0.5 * squareSize,  1.5 * squareSize)
    ]

maru : GC.Form
maru =
  GC.circle (maruFraction * squareSize)
  |> GC.outlined maruLineStyle
  |> GC.move (squareSize, -squareSize)


batsu : GC.Form
batsu =
  GC.group
    [ GC.traced batsuLineStyle <| GC.segment
        ( -batsuFraction * squareSize, -batsuFraction * squareSize )
        (  batsuFraction * squareSize,  batsuFraction * squareSize )
    , GC.traced batsuLineStyle <| GC.segment
        (  batsuFraction * squareSize, -batsuFraction * squareSize )
        ( -batsuFraction * squareSize,  batsuFraction * squareSize )
    ]
