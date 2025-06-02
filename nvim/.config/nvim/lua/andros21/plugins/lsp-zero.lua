-- lsp-zero.lua
-- ============
-- see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/tutorial.md#setup-lsp-zero

return {
   "VonHeikemen/lsp-zero.nvim",
   branch = "v3.x",
   dependencies = {
      { "neovim/nvim-lspconfig" },
      {
         "mason-org/mason.nvim",
         build = function()
            pcall(vim.cmd, "MasonUpdate")
         end,
      },
      { "mason-org/mason-lspconfig.nvim" },
   },
   priority = 75,
}
