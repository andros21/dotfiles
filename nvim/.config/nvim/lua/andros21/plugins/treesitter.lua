-- nvim-treesitter
-- ===============
-- see:
--  * https://github.com/nvim-treesitter/nvim-treesitter
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua

return {
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      keys = {
         { "<c-space>", desc = "Increment selection" },
         { "<bs>", desc = "Decrement selection", mode = "x" },
      },
      opts = {
         highlight = { enable = true },
         indent = { enable = true },
         context_commentstring = { enable = true, enable_autocmd = false },
         ensure_installed = andros21.cfg.syntax.ensure_installed,
         incremental_selection = {
            enable = true,
            keymaps = {
               init_selection = "<C-space>",
               node_incremental = "<C-space>",
               scope_incremental = "<nop>",
               node_decremental = "<bs>",
            },
         },
      },
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
      end,
   },
}
