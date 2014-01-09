querystring = require "querystring"
builder     = require "xmlbuilder"

debug = (msg)-> console.log "DEBUG: #{msg}"

exports.process = (msg, cfg, next)->
  debug "process"
