xmlbuilder = require 'xmlbuilder'
fs = require 'fs'
Q = require 'q'
CommonUpdater = require('sphere-node-sync').CommonUpdater
InventoryUpdater = require('sphere-node-sync').InventoryUpdater


###
Elastic.io component exporting inventory items from Sphere.io.
For each inventory item a XML file will be written.
###
class StockExport extends CommonUpdater
  constructor: (options = {}) ->
    super options
    @output = options.output
    @inventoryUpdater =  new InventoryUpdater options
    @rest = @inventoryUpdater.rest
    @

  ###
  Fetch inventory items from Sphere and export a single xml file containing all inventory information.
  @param {string} msg The message to process.
  @param {hash} cfg The component's configuration.
  @param {function} next The callback function to be invoked when the component finished its work.
  @param {string} snapshot The optional snapshot parameter which is used by a component for deduplication.
  @return The result of the callback.
  ###
  elasticio: (msg, cfg, next, snapshot) ->
    @returnResult false, 'Not yet implemented', next

  ###
  Fetch inventory items from Sphere and create a single xml file containing all inventory information.
  @param {function} callback The callback function to be invoked when the method finished its work.
  @return The result of the callback.
  ###
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

  ###
  Creates a plain XML instance.
  @return {number} The result of adding num1 and num2.
  ###
  createXml: () ->
    ops =
      version: '1.0'
      encoding: 'UTF-8'
      standalone: true
    xml = xmlbuilder.create 'inventory', ops
    xml.e('xsdVersion').t '0.1'
    xml

  ###
  Adds inventory data to given xml instance.
  @param {xml} xml The xml instance to be used.
  @param {inventory} entry The inventory data to be used in the template.
  @return {xml} The xml with inventory data.
  ###
  createXmlEntry: (xml, entry) ->
    xe = xml.e('entry')
    @add xe, entry, 'id'
    @add xe, entry, 'version'
    @add xe, entry, 'sku'
    @add xe, entry, 'quantityOnStock'

  ###
  Writes an xml file..
  @param {xml} xml The xml file to be written.
  @return {promise} The promise for writing the xml file.
  ###
  writeOutput: (xml) ->
    deffered = Q.defer()
    content = xml.end(pretty: true, indent: '  ', newline: "\n")
    fs.writeFile @output, content, (err) =>
      if err
        deffered.reject err
      else
        deffered.resolve @output
    deffered.promise

  ###
  Adds an element to given xml instance.
  @param {xml} xml The xml instance to be used.
  @param {element} elem The xml element to be added.
  @param {string} attr The name of the element.
  @param {string} xAttr ???
  @return {xml} The xml with added element.
  ###
  add: (xml, elem, attr, xAttr) ->
    xAttr = attr unless xAttr
    value = elem[attr]
    xml.e(xAttr).t(value).up() if value

module.exports = StockExport