local plugin_loader = {}

plugin_loader.load = function()
  local plugins = require "plugins"
  require("lazy").setup({
    spec = {
      { import = plugins },
    },
    checker = { enabled = true },
  })
end

return plugin_loader
