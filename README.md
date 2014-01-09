sphere-stock-xml-export
=======================

This project contains a full functional product stock information export to create separate XMLs from each product stock information. The code supports all possible data points and will be used within an elastic.io workflow. It can be used to connect ERP systems as well as CRM tools to update product stock information between the different systems.

## How to develop
[![Build Status](https://travis-ci.org/commercetools/sphere-stock-xml-export.png?branch=master)](https://travis-ci.org/commercetools/sphere-stock-xml-export)

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
grunt built|test|coverage
```

This will generate source files into `./build` folder.

Make sure to setup the correct environment for `elastic.io` integration

```bash
echo '{}' > ${HOME}/elastic.json && touch ${HOME}/.env
```

### Specs

Specs are located under `./src/spec` folder and written as [Jasmine test](http://pivotal.github.io/jasmine/).

To run them simply execute

```bash
jasmine-node --captureExceptions build/test
```

or

```bash
npm test
```

which will also execute `elasticio`
