module Constants where

-- Board is made of 100x100 squares
squareSize : Float
squareSize =
  100.0

-- What fraction of the height and width of the square is clickable
clickableFraction : Float
clickableFraction =
  0.80

-- Size of maru's as a fraction of squareSize
maruFraction : Float
maruFraction =
  0.3

-- Size of batsu's as a fraction of squareSize
batsuFraction : Float
batsuFraction =
  0.3
