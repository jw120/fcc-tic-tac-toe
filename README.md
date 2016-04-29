## TODO

* Check conventions for arg orders
* Tests working again
* CSS
* why does it take time to repaint board after first move on first run
* Make computer prefer longer games when losing. E.g. if X is player and have position
X..
OX.
...
then computer should move to block (even though player can force a win)
X..      XX.
OX.  ->  OX.  -> ...
..O      ..O
Change losing score to add number of pieces played


## Elm file organization

Explain....

Not factored into TEA components

Test code is in a separate tree - ugly that if we want to export something to use in tests, we export for everything


## Tests

Need to run `npm install` and `elm package install` within the `tests` directory

Tests are run with

```
elm-test tests/Runner.elm
```
