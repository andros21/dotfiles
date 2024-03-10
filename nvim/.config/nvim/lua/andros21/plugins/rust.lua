-- rust.lua
-- ========
-- see:
--  * https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/quick-recipes.md#setup-with-rustaceanvim
--  * https://github.com/mrcjkb/rustaceanvim

local util = require("andros21.util")

return {
   "mrcjkb/rustaceanvim",
   version = "^4",
   ft = { "rust" },
   config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.on_attach(util.lsp_zero_on_attach(lsp_zero))
      vim.g.rustaceanvim = {
         server = {
            capabilities = lsp_zero.get_capabilities(),
         },
      }
   end,
   priority = 80,
}
