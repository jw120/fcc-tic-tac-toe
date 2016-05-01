module Main where

import ElmTest
import Check
import Check.Test
import Console
import Signal
import Task

import BoardProp
import BoardTest
import ComputerTest

allTests : ElmTest.Test
allTests =
  ElmTest.suite "elm-test unit tests"
    [ BoardTest.allTests
    , ComputerTest.allTests
    ]

allProperties : Check.Claim
allProperties =
  Check.suite "elm-check properties"
    [ BoardProp.allClaims
    ]

console : Console.IO ()
console =
  ElmTest.consoleRunner <|
    ElmTest.suite "All tests"
      [ allTests
      , Check.Test.evidenceToTest (Check.quickCheck allProperties)
      ]

port runner : Signal.Signal (Task.Task x ())
port runner = Console.run console
