sphere-stock-xml-export
=======================

[![Build Status](https://travis-ci.org/svenmueller/sphere-stock-xml-export.png?branch=master)](https://travis-ci.org/svenmueller/sphere-stock-xml-export)

This project contains a full functional inventory export component. It outputs a single XML file containing all product stock information. The code supports all possible data points and can be used within an `elastic.io` workflow or as command line tool. It can be used to connect ERP systems as well as CRM tools to update product stock information between the different systems.

## How to develop

Install the required dependencies
```bash
npm install
```

All source files are written in `coffeescript`. [Grunt](http://gruntjs.com/) is used as build tool. The generated source files are located in `/lib`.
```bash
grunt build
```

Make sure to setup the environment for `elastic.io` integration
```bash
echo '{}' > ${HOME}/elastic.json && touch ${HOME}/.env
```

## How to run
### Command line

```
node lib/run.js --projectKey ${SPHERE_PROJECT_KEY} --clientId ${SPHERE_CLIENT_ID} --clientSecret ${SPHERE_CLIENT_SECRET} --output out.xml
```

### Specs

Generate local `config.js` file (mustn't be under version control, therefore it is added to `.gitignore`). Put project credentials in generated `config.js`. The credentials will be required for integration tests.
```bash
./create_config.sh
```

Specs are located under `/src/spec` and written as [Jasmine](http://pivotal.github.io/jasmine/) test.
```bash
grunt test
```

To run them on any file change
```bash
grunt watch:test
```

