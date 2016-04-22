-- Collects all of our elm-test tests

module Tests (all) where

import ElmTest exposing (Test, suite)

import Game.BoardTest

all : Test
all =
    suite "elm-test unit tests"
        [ Game.BoardTest.testSuite
        ]
