libxmljs = require "libxmljs"

describe "validateXML", ->
  xit "validate", ->
    xsd = "
    xsdDoc = libxmljs.parseXmlString(xsd)

    xml = "
    xmlDoc = libxmljs.parseXmlString(xml)
    expect(xmlDoc.validate(xsdDoc)).toBe true