local M = {}

function M:init()
    require "config.defaults"
    require "config.settings"

    require("config.keymappings").load_defaults()
end

return M
