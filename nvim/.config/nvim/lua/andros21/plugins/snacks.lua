-- snacks.nvim
-- ===========
-- see:
--  * https://www.lazyvim.org/plugins/ui#snacksnvim
--  * https://www.lazyvim.org/plugins/util#snacksnvim

-- Terminal Mappings
local function term_nav(dir)
   ---@param self snacks.terminal
   return function(self)
      return self:is_floating() and "<c-" .. dir .. ">"
         or vim.schedule(function()
            vim.cmd.wincmd(dir)
         end)
   end
end

return {
   "folke/snacks.nvim",
   priority = 1000,
   lazy = false,
  -- stylua: ignore
  keys = {
  },
   opts = function()
      ---@type snacks.Config
      return {
         input = { enabled = true },
         notifier = { enabled = true },
         scope = { enabled = true },
         scroll = { enabled = false },
         statuscolumn = { enabled = false }, -- we set this in options.lua
         toggle = { map = LazyVim.safe_keymap_set },
         words = { enabled = true },
         toggle = { map = LazyVim.safe_keymap_set },
         notifier = { enabled = not LazyVim.has("noice.nvim") },
         terminal = {
            win = {
               keys = {
                  nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                  nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                  nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                  nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
               },
            },
         },
      }
   end,
   keys = {
      {
         "<leader>n",
         function()
            Snacks.notifier.show_history()
         end,
         desc = "Notification History",
      },
      {
         "<leader>un",
         function()
            Snacks.notifier.hide()
         end,
         desc = "Dismiss All Notifications",
      },
   },
}
