-- lazyvim.lua
-- ===========
-- see https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/core.lua

return {
   "LazyVim/LazyVim",
   lazy = false,
   config = function()
      _G.LazyVim = require("lazyvim.util")
      _G.Snacks = require("snacks")
      require("lazyvim.config.options")
      require("lazyvim.config.autocmds")
      require("lazyvim.config.keymaps")
   end,
   cond = true,
   version = "v14.6.0",
   priority = 1000,
}
