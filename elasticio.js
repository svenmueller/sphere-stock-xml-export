StockExport = require('./main').StockExport

exports.process = function(msg, cfg, next, snapshot) {
  console.log("msg: %j", msg)
  config = {
    client_id: cfg.sphereClientId,
    client_secret: cfg.sphereClientSecret,
    project_key: cfg.sphereProjectKey
  };
  var im = new StockExport({
    config: config,
    logentries_token: cfg.logEntriesToken
  });
  im.elasticio(msg, cfg, next, snapshot);
}
