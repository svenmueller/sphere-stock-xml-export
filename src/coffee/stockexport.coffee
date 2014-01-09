xmlbuilder = require 'xmlbuilder'
fs = require 'fs'
Q = require 'q'
CommonUpdater = require('sphere-node-sync').CommonUpdater
InventoryUpdater = require('sphere-node-sync').InventoryUpdater

class StockExport extends CommonUpdater
  constructor: (options = {}) ->
    super options
    @output = options.output
    @inventoryUpdater =  new InventoryUpdater options
    @rest = @inventoryUpdater.rest
    @

  elasticio: (msg, cfg, next, snapshot) ->
    @returnResult false, 'Not yet implemented', next

  run: (callback) ->
    @inventoryUpdater.allInventoryEntries(@rest).then (allInventoryEntries) =>
      xml = @createXml()
      for entry in allInventoryEntries
        @createXmlEntry xml, entry
      @writeOutput(xml).then (msg) =>
        @returnResult true, "Inventory exported to '#{msg}'", callback
      .fail (msg) ->
        @returnResult false, msg, callback
    .fail (msg) ->
      @returnResult false, msg, callback

  createXml: () ->
    ops =
      version: '1.0'
      encoding: 'UTF-8'
      standalone: true
    xml = xmlbuilder.create 'inventory', ops
    xml.e('xsdVersion').t '0.1'
    xml

  createXmlEntry: (xml, entry) ->
    xe = xml.e('entry')
    @add xe, entry, 'id'
    @add xe, entry, 'version'
    @add xe, entry, 'sku'
    @add xe, entry, 'quantityOnStock'

  writeOutput: (xml) ->
    deffered = Q.defer()
    content = xml.end(pretty: true, indent: '  ', newline: "\n")
    fs.writeFile @output, content, (err) =>
      if err
        deffered.reject err
      else
        deffered.resolve @output
    deffered.promise

  add: (xml, elem, attr, xAttr) ->
    xAttr = attr unless xAttr
    value = elem[attr]
    xml.e(xAttr).t(value).up() if value

module.exports = StockExport