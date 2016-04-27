module PlayerMove (update) where

{-|

Module to handle a player move: validates that it represents a valid mode and then adds a
computer move in response.

@doc update

-}


import Board
import Models


update : Board.Square -> Models.Model -> Models.Model
update square model =
  { model
  | board = Board.addPiece square (model.player) model.board
  }
