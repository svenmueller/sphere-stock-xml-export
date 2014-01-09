elasticio = require '../elasticio.js'
Config = require '../config'

describe "elasticio integration", ->
  it "not yet implemented", (done) ->
    cfg =
      sphereClientId: Config.config.client_id
      sphereClientSecret: Config.config.client_secret
      sphereProjectKey: Config.config.project_key
    msg = ''
    elasticio.process msg, cfg, (next) ->
      expect(next.status).toBe false
      done()