-- mini.lua
-- ========
-- see:
--  * https://github.com/echasnovski/mini.nvim
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/util.lua
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua

return {

   {
      "echasnovski/mini.nvim",
   },

   -- active indent guide and indent text objects
   {
      "echasnovski/mini.indentscope",
      version = false, -- wait till new 0.7.0 release to put it back on semver
      event = { "BufReadPre", "BufNewFile" },
      opts = {
         -- symbol = "▏",
         symbol = "│",
         options = { try_as_border = true },
      },
      init = function()
         vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            callback = function()
               vim.b.miniindentscope_disable = true
            end,
         })
      end,
      config = function(_, opts)
         require("mini.indentscope").setup(opts)
      end,
   },

   -- auto pairs
   {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      config = function(_, opts)
         require("mini.pairs").setup(opts)
      end,
   },

   -- surround
   {
      "echasnovski/mini.surround",
      config = function(_, opts)
         require("mini.surround").setup(opts)
      end,
   },

   -- comment
   {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      config = function(_, opts)
         require("mini.comment").setup(opts)
      end,
   },

   -- bufremove
   {
      "echasnovski/mini.bufremove",
      event = "VeryLazy",
      keys = {
         {
            "<leader>bd",
            function()
               require("mini.bufremove").delete(0, false)
            end,
            desc = "Delete Buffer",
         },
         {
            "<leader>bD",
            function()
               require("mini.bufremove").delete(0, true)
            end,
            desc = "Delete Buffer (Force)",
         },
      },
      config = function(_, opts)
         require("mini.bufremove").setup(opts)
      end,
   },

   -- trailspace
   {
      "echasnovski/mini.trailspace",
      event = "VeryLazy",
      config = function(_, opts)
         require("mini.trailspace").setup(opts)
      end,
   },
}
