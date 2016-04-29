## TODO

* Check conventions for arg orders
* Speed up with heuristics
* Tests working again
* CSS
* why does it take time to repaint board after first move on first run


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
