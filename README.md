sphere-stock-xml-export
=======================

This project contains a full functional inventory export to create one XML file containing all product stock information. The code supports all possible data points and can be used within an elastic.io workflow or as command line tool. It can be used to connect ERP systems as well as CRM tools to update product stock information between the different systems.

## How to develop
[![Build Status](https://travis-ci.org/svenmueller/sphere-stock-xml-export.png?branch=master)](https://travis-ci.org/svenmueller/sphere-stock-xml-export)

Install the required dependencies

```bash
npm install
```

Generate local `config.js` file (mustn't be under version control, therefore added to `.gitignore`)
```bash
./create_config.sh
```

Source files are written in `coffeescript`. Use [Grunt](http://gruntjs.com/) to build them

```bash
grunt build
```

The generated source files are located in `/lib`.

Make sure to setup the environment for `elastic.io` integration

```bash
echo '{}' > ${HOME}/elastic.json && touch ${HOME}/.env
```

### Specs

Specs are located under `/src/spec` and written as [Jasmine](http://pivotal.github.io/jasmine/) test.

To run them execute

```bash
grunt test
```

or

```bash
npm test
```

which will also execute `elastic.io`

To run them on any file change

```bash
grunt watch:test
```
