-- Runs Tests.elm (elm-test) and Properties.elm (elm-check)

module Main where

import ElmTest
import Check
import Check.Test
import Console
import Signal
import Task

import Properties
import Tests

console : Console.IO ()
console =
  ElmTest.consoleRunner <|
    ElmTest.suite "All tests"
      [ Tests.all
      , Check.Test.evidenceToTest (Check.quickCheck Properties.all)
      ]

port runner : Signal.Signal (Task.Task x ())
port runner = Console.run console
