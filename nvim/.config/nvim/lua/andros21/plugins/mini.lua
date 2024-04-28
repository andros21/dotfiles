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
   },

   -- auto pairs
   {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      opts = {
         mappings = {
            ["`"] = {
               action = "closeopen",
               pair = "``",
               neigh_pattern = "[^\\`].",
               register = { cr = false },
            },
         },
      },
   },

   -- surround
   {
      "echasnovski/mini.surround",
      opts = {},
   },

   -- comment
   {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      opts = {},
   },

   -- bufremove
   {
      "echasnovski/mini.bufremove",
      event = "VeryLazy",
      opts = {},
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
   },

   -- trailspace
   {
      "echasnovski/mini.trailspace",
      event = "VeryLazy",
      opts = {},
   },

   -- jump
   {
      "echasnovski/mini.jump",
      event = "VeryLazy",
      opts = {},
      config = function(_, opts)
         require("mini.jump").setup(opts)
         vim.api.nvim_set_hl(0, "MiniJump", { fg = "#d08770" })
      end,
   },

   -- jump2d
   {
      "echasnovski/mini.jump2d",
      event = "VeryLazy",
      opts = {},
   },
}
