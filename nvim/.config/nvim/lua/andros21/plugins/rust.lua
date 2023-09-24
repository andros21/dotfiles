-- rust.lua
-- ========
-- see:
--  * https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/quick-recipes.md#setup-with-rust-tools
--  * https://github.com/simrat39/rust-tools.nvim

local util = require("andros21.util")

return {
   "simrat39/rust-tools.nvim",
   config = function(_, opts)
      local lsp_zero = require("lsp-zero").preset({})
      lsp_zero.on_attach(util.lsp_zero_on_attach(lsp_zero))
      lsp_zero.skip_server_setup({ "rust_analyzer" })
      lsp_zero.setup()
      local rust_tools = require("rust-tools")
      rust_tools.setup({
         server = {
            on_attach = function(_, bufnr)
               vim.keymap.set("n", "<leader>ca", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            end,
         },
      })
   end,
   priority = 80,
}
