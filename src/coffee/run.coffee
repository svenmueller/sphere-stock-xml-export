argv = require('optimist')
  .usage('Usage: $0 --projectKey key --clientId id --clientSecret secret --output file')
  .demand(['projectKey', 'clientId', 'clientSecret', 'output'])
  .argv
StockExport = require('../main').StockExport

options =
  config:
    project_key: argv.projectKey
    client_id: argv.clientId
    client_secret: argv.clientSecret
  output: argv.output

exporter = new StockExport options
exporter.run (msg) ->
  console.log msg
  process.exit 1 unless msg.status