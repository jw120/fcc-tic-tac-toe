module Views.Board (..) where

import Color
import Graphics.Collage as GC exposing (defaultLine)
import Html

import Constants exposing (squareSize, maruFraction, batsuFraction)
import Game.Board exposing (Square, Piece(..))


boardSize : Int
boardSize =
  round (3 * squareSize)

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


{-
My understanding of Graphics types
Element - For rendering
Form - Main focus of the Graphcs.Collage model
Shape/Path - geometric path (no styles), converted to Form with traced etc
-}

view : Game.Board.Board -> Html.Html
view board =
    GC.collage boardSize boardSize (boardFrame ++ List.map drawPiece (Game.Board.pieces board))
      |> Html.fromElement


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


drawPiece : (Square, Piece) -> GC.Form
drawPiece (square, piece) =
  let
    xShift = toFloat ((square - 1) % 3 - 1) * squareSize
    yShift = toFloat ((square - 1) // 3 - 1) * squareSize
    pic = case piece of
      O -> maru
      X -> batsu
  in
    GC.move (xShift, -yShift) pic


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
