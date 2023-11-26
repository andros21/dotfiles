-- bufferline.lua
-- ==============
-- see:
--  * https://github.com/akinsho/bufferline.nvim
--  * https://github.com/shaunsingh/nord.nvim#bufferline-support

return {
   "akinsho/bufferline.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      local highlights = require("nord").bufferline.highlights({
         italic = true,
         bold = true,
      })
      require("bufferline").setup({
         highlights = highlights,
         options = {
            buffer_close_icon = "✖",
            hover = {
               enabled = true,
               delay = 70,
               reveal = { "close" },
            },
         },
      })
   end,
}
