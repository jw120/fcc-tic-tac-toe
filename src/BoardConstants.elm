module BoardConstants (boardLines) where

{-| Provides board geometry constants to keep code DRY

@doc boardLines

-}


boardLines : List (Int, Int, Int)
boardLines =
  [ (1, 2, 3)
  , (4, 5, 6)
  , (7, 8, 9)
  , (1, 4, 7)
  , (2, 5, 8)
  , (3, 6, 9)
  , (1, 5, 9)
  , (3, 5, 7)
  ]
