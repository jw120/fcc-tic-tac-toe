To compile

```
elm make src/Main.elm --output elm.js
./build.sh
```

Then open `dist/index.html`



## Tests

Need to run `npm install` and `elm package install` within the `tests` directory

Tests are run with

```
elm-test tests/Runner.elm
```

Tests currently not working - failing with a dependency error from lazy-list
