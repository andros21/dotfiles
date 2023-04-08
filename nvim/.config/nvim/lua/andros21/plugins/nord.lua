-- nord.lua
-- ========
-- see https://github.com/shaunsingh/nord.nvim

return {
   "shaunsingh/nord.nvim",
   config = function()
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      require("nord").set()
      -- nord color override
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#262626" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#af87d7" })
   end,
   priority = 100,
}
