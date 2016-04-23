module Main where

import ElmTest
import Check
import Check.Test
import Console
import Signal
import Task

import Game.BoardProp
import Game.BoardTest

allTests : ElmTest.Test
allTests =
  ElmTest.suite "elm-test unit tests"
      [ Game.BoardTest.testSuite
      ]

allProperties : Check.Claim
allProperties =
  Game.BoardProp.all

console : Console.IO ()
console =
  ElmTest.consoleRunner <|
    ElmTest.suite "All tests"
      [ allTests
      , Check.Test.evidenceToTest (Check.quickCheck allProperties)
      ]

port runner : Signal.Signal (Task.Task x ())
port runner = Console.run console
