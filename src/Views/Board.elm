module Views.Board (view) where

{-| Renderer for the Board

@doc view

-}


import Graphics.Collage as GC
import Html

import ViewConstants exposing (squareSize, maruFraction, batsuFraction, gridLineStyle, maruLineStyle, batsuLineStyle)
import Board exposing (Square, Piece(..), Board)


{-
Note - My understanding of Graphics types
Element - For rendering
Form - Main focus of the Graphcs.Collage model
Shape/Path - geometric path (no styles), converted to Form with traced etc
-}


{-| Render a Board as Html -}
view : Board -> Html.Html
view board =
  let
    size = round (3.0 * squareSize)
  in
    boardFrame ++ List.map drawPiece (Board.toList board)
      |> GC.collage size size
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
