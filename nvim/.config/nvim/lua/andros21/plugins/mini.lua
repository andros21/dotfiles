-- mini.lua
-- ========
-- see:
--  * https://github.com/echasnovski/mini.nvim
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua

_G.LazyVim = require("lazyvim.util")

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
         modes = { insert = true, command = true, terminal = false },
         -- skip autopair when next character is one of these
         skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
         -- skip autopair when the cursor is inside these treesitter nodes
         skip_ts = { "string" },
         -- skip autopair when next character is closing pair
         -- and there are more closing pairs than opening pairs
         skip_unbalanced = true,
         -- better deal with markdown code blocks
         markdown = true,
      },
      config = function(_, opts)
         LazyVim.mini.pairs(opts)
      end,
   },

   -- surround
   {
      "echasnovski/mini.surround",
      keys = function(_, keys)
         -- Populate the keys based on the user's options
         local opts = LazyVim.opts("mini.surround")
         local mappings = {
            { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
            { opts.mappings.delete, desc = "Delete Surrounding" },
            { opts.mappings.find, desc = "Find Right Surrounding" },
            { opts.mappings.find_left, desc = "Find Left Surrounding" },
            { opts.mappings.highlight, desc = "Highlight Surrounding" },
            { opts.mappings.replace, desc = "Replace Surrounding" },
            { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
         }
         mappings = vim.tbl_filter(function(m)
            return m[1] and #m[1] > 0
         end, mappings)
         return vim.list_extend(mappings, keys)
      end,
      opts = {
         mappings = {
            add = "gsa", -- Add surrounding in Normal and Visual modes
            delete = "gsd", -- Delete surrounding
            find = "gsf", -- Find surrounding (to the right)
            find_left = "gsF", -- Find surrounding (to the left)
            highlight = "gsh", -- Highlight surrounding
            replace = "gsr", -- Replace surrounding
            update_n_lines = "gsn", -- Update `n_lines`
         },
      },
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

   -- animate scroll
   {
      "echasnovski/mini.animate",
      event = "VeryLazy",
      cond = vim.g.neovide == nil,
      opts = function(_, opts)
         -- don't use animate when scrolling with the mouse
         local mouse_scrolled = false
         for _, scroll in ipairs({ "Up", "Down" }) do
            local key = "<ScrollWheel" .. scroll .. ">"
            vim.keymap.set({ "", "i" }, key, function()
               mouse_scrolled = true
               return key
            end, { expr = true })
         end

         vim.api.nvim_create_autocmd("FileType", {
            pattern = "grug-far",
            callback = function()
               vim.b.minianimate_disable = true
            end,
         })

         Snacks.toggle({
            name = "Mini Animate",
            get = function()
               return not vim.g.minianimate_disable
            end,
            set = function(state)
               vim.g.minianimate_disable = not state
            end,
         }):map("<leader>ua")

         local animate = require("mini.animate")
         return vim.tbl_deep_extend("force", opts, {
            resize = {
               timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
            },
            scroll = {
               timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
               subscroll = animate.gen_subscroll.equal({
                  predicate = function(total_scroll)
                     if mouse_scrolled then
                        mouse_scrolled = false
                        return false
                     end
                     return total_scroll > 1
                  end,
               }),
            },
         })
      end,
   },
}
