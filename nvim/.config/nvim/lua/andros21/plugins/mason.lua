-- mason.lua
-- =========
-- see https://github.com/williamboman/mason.nvim

return {
   "williamboman/mason.nvim",
   config = function()
      require("mason").setup()
   end,
   priority = 70,
}

