-- nvim-lint.lua
-- =================
-- see:
--  * https://github.com/mfussenegger/nvim-lint

return {
   "mfussenegger/nvim-lint",
   config = function(_, opts)
      require("lint").linters_by_ft = andros21.cfg.mason.nvim_lint
   end,
   priority = 80,
}
