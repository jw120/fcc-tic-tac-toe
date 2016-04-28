module Board
  ( Square, Piece(..), Board, Line
  , opposite
  , fromList, toList, emptyBoard, isEmpty, isValid
  , getPiece, isFull, isEmptySquare, hasLine, emptySquares
  , addPiece
  ) where

{-| This module provides the basic data types needed for our TicTacToe game. Board
squares are numbered from 1 to 9

  1 2 3
  4 5 6
  7 8 9

# Types
@doc Square, Piece, Board, Line

# Piece helper function
@doc opposite

# Basic Board helper functions
@doc fromList, toList, emptyBoard, isEmpty, isValid

# Board examination functions
@doc getPiece, isFull, hasLine, isEmptySquare, mptySquares

# Board manipulation function
@doc addPiece

-}


import BoardConstants

import Dict


-- Types


{-| A square on the TicTacToe board - numbered 1..9 (1 is top-left, 3 is top-right, 9 is bottom-right) -}
type alias Square =
  Int


{-| A TicTacToe piece -}
type Piece
  = X
  | O


{-| A TicTacToe board -}
type alias Board =
  Dict.Dict Square Piece


{-| A line of three adjacent squares on the TicTacToe board -}
type alias Line =
  (Square, Square, Square)


-- Piece Helper function


{-| Convert X to O and vice versa -}
opposite : Piece -> Piece
opposite p =
  case p of
    X ->
      O

    O ->
      X


-- Basic Board helper functions


fromList : List (Square, Piece) -> Board
fromList = Dict.fromList


toList : Board -> List (Square, Piece)
toList = Dict.toList


emptyBoard : Board
emptyBoard = Dict.empty


isEmpty : Board -> Bool
isEmpty = Dict.isEmpty


{-| True if all squares in the board are valid (i.e., in range 1 to 9). Used for testing -}
isValid : Board -> Bool
isValid =
  Dict.filter (\k _ -> k < 1 || k > 9)
    >> Dict.isEmpty


-- Board examination functions


{-| Return the piece at a given Square (or Nothing if the square is empty) -}
getPiece : Square -> Board -> Maybe Piece
getPiece = Dict.get


{-| Is every square of the board non-empty -}
isFull : Board -> Bool
isFull board =
  [1 .. 9]
    |> List.any (\s -> isEmptySquare s board)
    |> not


isEmptySquare : Square -> Board -> Bool
isEmptySquare square board =
  Dict.get square board == Nothing


{-| If the board contains a complete line, return it -}
hasLine : Board -> Maybe (Piece, Line)
hasLine board =
  let
    isLine' : Line -> Maybe (Piece, Line)
    isLine' l =
      isLine l board
        |> Maybe.map (\p -> (p, l))
  in
    List.filterMap isLine' BoardConstants.boardLines
      |> List.head


{-| Return all the unoccupied squares on the board -}
emptySquares : Board -> List Square
emptySquares board =
  [1 .. 9]
    |> List.filter (\s -> isEmptySquare s board)


-- Board manipulation function


{-| Add the given piece to the board (overwriting any piece already in that square) -}
addPiece : Square -> Piece -> Board -> Board
addPiece = Dict.insert


-- Internal helper functions (not exported)


isPiece : Square -> Piece -> Board -> Bool
isPiece square piece board =
  Dict.get square board == Just piece


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
