-- lazyvim.lua
-- ===========
-- see https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/core.lua

return {
   "LazyVim/LazyVim",
   lazy = false,
   config = function()
      require("lazyvim.config.options")
      require("lazyvim.config.autocmds")
      require("lazyvim.config.keymaps")
   end,
   cond = true,
   version = "*",
   priority = 1000,
}
