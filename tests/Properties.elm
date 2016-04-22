-- Collects all of our elm-check properties

module Properties (all) where

import Check exposing (Claim, that, is, for)
import Check.Producer as Producer
import List

all : Claim
all =
  Check.suite
    "elm-check properties"
    [ Check.claim
        "Reversing a list twice yields the original list"
        `that` (\list -> List.reverse (List.reverse list))
        `is` identity
        `for` Producer.list Producer.int
    , Check.claim
        "Reversing a list does not modify its length"
        `that` (\list -> List.length (List.reverse list))
        `is` (\list -> List.length list)
        `for` Producer.list Producer.int
    ]
