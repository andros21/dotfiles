-- null-ls.lua
-- ===========
-- see:
--  * https://github.com/nikbrunner/vin/blob/main/lua/vin/plugins/lsp/null_ls.lua
--  * https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/integrate-with-null-ls.md#format-on-save

local util = require("andros21.util")

return {
   "jose-elias-alvarez/null-ls.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function(_, opts)
      local null_ls = require("null-ls")
      local lsp_zero = require("lsp-zero").preset({})
      lsp_zero.on_attach(util.lsp_zero_on_attach(lsp_zero))

      null_ls.setup({
         sources = util.build_sources(null_ls, andros21.cfg.null_ls.sources),
      })
   end,
   priority = 80,
}
