-- lsp-zero.lua
-- ============
-- see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/tutorial.md#setup-lsp-zero

return {
   "VonHeikemen/lsp-zero.nvim",
   branch = "v2.x",
   dependencies = {
      { "neovim/nvim-lspconfig" },
      {
         "williamboman/mason.nvim",
         build = function()
            pcall(vim.cmd, "MasonUpdate")
         end,
      },
      { "williamboman/mason-lspconfig.nvim" },
   },
   priority = 75,
}
