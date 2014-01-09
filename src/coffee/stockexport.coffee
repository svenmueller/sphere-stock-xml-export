xmlbuilder = require 'xmlbuilder'
CommonUpdater = require('sphere-node-sync').CommonUpdater

class StockExport extends CommonUpdater
  constructor: (options = {}) ->
    super options
    @

  createXml: () ->
    xml = xmlbuilder.create("inventory", { "version": "1.0", "encoding": "UTF-8", "standalone": true })
    xml.e("xsdVersion").t("0.1")
    xml

module.exports = StockExport