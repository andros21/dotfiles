-- lazyvim.lua
-- ===========
-- see https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/core.lua

return {
   "LazyVim/LazyVim",
   lazy = false,
   config = function()
      _G.LazyVim = require("lazyvim.util")
      require("lazyvim.config.options")
      require("lazyvim.config.autocmds")
      require("lazyvim.config.keymaps")
   end,
   cond = true,
   version = "v12.44.1",
   priority = 1000,
}
