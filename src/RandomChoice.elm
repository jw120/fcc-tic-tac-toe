module RandomChoice (fromList) where

{- | Provides a function to choose a random element from a non-empty list.

@doc fromList

-}


import List.Nonempty
import Random

fromList : Random.Seed  -> List.Nonempty.Nonempty a -> ( Random.Seed, a)
fromList seed xs =
  let
    gen = Random.int 0 (List.Nonempty.length xs - 1)
    (i, seed') = Random.generate gen seed
  in
    ( seed', List.Nonempty.get i xs)
