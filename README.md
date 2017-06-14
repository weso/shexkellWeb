# Shexkell Web #
Web interface for [Shexkell](https://github.com/weso/shexkell)

## Structure ##

The project structure is the following:

### ShexkellWeb API ###
Backend service that performs the validation. Receives HTTP requests with
the data to validate, and responds with the resulting ShapeMap. Uses the
[Spock web framework](https://hackage.haskell.org/package/Spock).

The dependency to Shexkell is referenced in the file `stack.yaml`

To run the service:
```sh
$ cd ShexkellWeb-API
$ stack setup
$ stack build
$ stack exec ShexkellWeb-exe
```

By default, the service listens on port 8080

### ShexkellWeb Interface ###
Front-end to the API. Allows to enter the validation data in the web
browser.

To set up the project:

You must have `npm` and `gulp` installed.

```sh
$ cd ShexkellWeb-Interface
$ npm install # Choose the default options
$ cd semantic
$ gulp build
```

The path to the API endpoint is hardcoded in `scripts/shexkell.js`

Once set up, open the file `shexkell.html` in your web browser of choice


