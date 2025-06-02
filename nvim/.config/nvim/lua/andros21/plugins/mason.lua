-- mason.lua
-- =========
-- see https://github.com/williamboman/mason.nvim

return {
   "mason-org/mason.nvim",
   config = function()
      require("mason").setup()
   end,
   priority = 70,
}
