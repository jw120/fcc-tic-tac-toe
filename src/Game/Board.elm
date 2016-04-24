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

-- Heler functions for pieces

opposite : Piece -> Piece
opposite p =
  case p of
    X -> O
    O -> X


-- Helper functions to make boards (mainly for testing)

fromList : List (Square, Piece) -> Board
fromList = Dict.fromList

emptyBoard : Board
emptyBoard = Dict.empty

toList : Board -> List (Square, Piece)
toList = Dict.toList



-- Helper functioms to manipulate and test boards

addPiece : Square -> Piece -> Board -> Board
addPiece = Dict.insert

getPiece : Square -> Board -> Maybe Piece
getPiece = Dict.get

isValid : Board -> Bool
isValid =
  Dict.filter (\k _ -> k < 1 || k > 9)
    >> Dict.isEmpty

isEmpty : Board -> Bool
isEmpty = Dict.isEmpty

pieces : Board -> List (Square, Piece)
pieces board =
  Dict.toList board


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
isLine : Line -> Board -> Maybe Piece
isLine (l1, l2, l3) b =
  let
    p1 = getPiece l1 b
    p2 = getPiece l2 b
    p3 = getPiece l3 b
  in
    if p1 == p2 && p2 == p3 then
      p1
    else
      Nothing

-- Does the board have a complete line
hasLine : Board -> Maybe (Piece, Line)
hasLine board =
  let
    isLine' : Line -> Maybe (Piece, Line)
    isLine' l =
      isLine l board
        |> Maybe.map (\p -> (p, l))
  in
    List.filterMap isLine' boardLines
      |> List.head


-- Which squares are empty
emptySquares : Board -> List Square
emptySquares board =
  boardSquares
    |> List.filter (\s -> isEmptySquare s board)
