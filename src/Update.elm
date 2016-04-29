module Update (update) where

{-|

@doc update

-}


import Effects
import Random
import Time

import Actions
import Board
import Models
import Move


update : Actions.Action -> Models.Model -> (Models.Model, Effects.Effects Actions.Action)
update action model =
  let
    taggedModel = { model | lastAction = action }
  in case action of
    Actions.NoOp ->
      ( taggedModel, Effects.none )

    Actions.StartAsBatsu ->
      Models.reset Board.X taggedModel

    Actions.StartAsMaru ->
      Models.reset Board.O taggedModel

    Actions.PlayerMoved square ->
      Move.player square taggedModel

    Actions.ComputerMoved (newSeed, newBoard) ->
      (  Move.computer newSeed newBoard taggedModel , Effects.none )

    Actions.ToggleDebug ->
      ( { taggedModel | debugMode = not taggedModel.debugMode }, Effects.none)

    Actions.StartingTick time ->
      ( { taggedModel | seed = Random.initialSeed (round (Time.inMilliseconds time)) }, Effects.none)
