local plugin_loader = {}

plugin_loader.load = function()
  local plugins = require "plugins"
  require("lazy").setup(plugins, opts)
end

return plugin_loader
