module Game.Board (..) where

import Dict


-- Types


{-

Board squares are numbered:

1 2 3
4 5 6
7 8 9

-}

type alias Square =
  Int


type Piece
  = X | O


type alias Board =
  Dict.Dict Square Piece


type alias Line =
  (Square, Square, Square)



-- Constants for board Geometry


boardSquares : List Square
boardSquares = [1 .. 9]


boardLines : List Line
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


boardCentres : List Square
boardCentres = [ 5 ]


boardSides : List Square
boardSides = [ 2, 4, 6, 8 ]


boardCorners : List Square
boardCorners = [ 1, 3, 7, 9 ]


-- Helper functions to make boards (mainly for testing)

fromList : List (Square, Piece) -> Board
fromList = Dict.fromList

emptyBoard : Board
emptyBoard = Dict.empty

toList : Board -> List (Square, Piece)
toList = Dict.toList



-- Helper functioms to manipulate boardCorners

addPiece : Square -> Piece -> Board -> Board
addPiece = Dict.insert



-- Helper functions for board lookup


-- Is the board's square occupied by the piece
isPiece : Square -> Piece -> Board -> Bool
isPiece square piece board =
  Dict.get square board == Just piece


-- Is the board's square empty
isEmptySquare : Square -> Board -> Bool
isEmptySquare square board =
  Dict.get square board == Nothing


-- Is every square of the board non-empty
isFull : Board -> Bool
isFull board =
  boardSquares
    |> List.any (\s -> isEmptySquare s board)
    |> not

-- Is the specified line taken (i.e., all three squares have the same piece)
isLine : Line -> Maybe Piece
isLine line =
  Nothing


-- Does the board have a complete line
hasLine : Board -> Maybe (Piece, Line)
hasLine board =
  Nothing -- TBD

  {-
  let
    isLine' : Line -> Maybe (Line, Piece)
    isLine' line = Maybe.map (\result -> (line, result)) (isLine line)
    possibleLines : List (Line, Piece)
    possibleLines = List.filterMap boardLines
  in
    case possibleLines of
    [(piece, line)] ->
      Just (piece, line)

    _ ->
      Nothing
-}




-- Which squares are empty
emptySquares : Board -> List Square
emptySquares board =
  boardSquares
    |> List.filter (\s -> isEmptySquare s board)
