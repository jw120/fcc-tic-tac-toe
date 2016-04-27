module ViewConstants
  (squareSize, clickableFraction, maruFraction, batsuFraction
  , gridLineStyle, maruLineStyle, batsuLineStyle
  ) where

{-| Constants that define the appearance of our view

# Board geometry
@doc squareSize, clickableFraction, maruFraction, batsuFraction

# Board line styles
@doc gridLineStyle, maruLineStyle, batsuLineStyle

-}


import Color
import Graphics.Collage exposing (defaultLine)



{-| Board is made of 100x100 squares -}
squareSize : Float
squareSize =
  100.0


{-| What fraction of the height and width of the square is clickable -}
clickableFraction : Float
clickableFraction =
  0.80


{-|  Size of maru's as a fraction of squareSize -}
maruFraction : Float
maruFraction =
  0.3


{-| Size of batsu's as a fraction of squareSize -}
batsuFraction : Float
batsuFraction =
  0.3


gridLineStyle : Graphics.Collage.LineStyle
gridLineStyle =
  { defaultLine
  | width = 2
  }


maruLineStyle : Graphics.Collage.LineStyle
maruLineStyle =
  { defaultLine
  | color = Color.red
  , width = 10
  }


batsuLineStyle : Graphics.Collage.LineStyle
batsuLineStyle =
  { defaultLine
  | color = Color.blue
  , width = 10
  }
