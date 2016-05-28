Written in elm 0.16.

To compile

```
elm make src/Main.elm --output elm.js
./build.sh
```

Then open `dist/index..html`

Hosted at [jw120.github.io](https://jw120.github.io)


## Tests

Need to run `npm install` and `elm package install` within the `tests` directory

Tests are run with

```
elm-test tests/Runner.elm
```

## Bugs

* Does not work on iOS (taps do no register as clicks and the
  positioning is off). Fixing clicks requires tinkering with the
  now-obsolete Elm version 0.16 (and the Canvas code for mouse
  handling seems clunky)
* Tests currently not working - failing with a dependency error from lazy-list
