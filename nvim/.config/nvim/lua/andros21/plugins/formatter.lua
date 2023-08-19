-- formatter.lua
-- =================
-- see:
--  * https://github.com/mhartington/formatter.nvim

local util = require("andros21.util")

return {
   "mhartington/formatter.nvim",
   config = function(_, opts)
      require("formatter").setup({
         filetype = util.get_filetypes(andros21.cfg.mason.formatter),
      })
   end,
   priority = 80,
}
