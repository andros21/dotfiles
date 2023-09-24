-- mason-tool-installer.lua
-- =================
-- see:
--  * https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

local util = require("andros21.util")

return {
   "WhoIsSethDaniel/mason-tool-installer.nvim",
   config = function(_, opts)
      require("mason-tool-installer").setup({
         ensure_installed = util.get_requirements(andros21.cfg.mason),
      })
   end,
   priority = 100,
}
