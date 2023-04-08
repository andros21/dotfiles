-- mason-null-ls.lua
-- =================
-- see:
--  * https://github.com/jay-babu/mason-null-ls.nvim#primary-source-of-truth-is-null-ls

return {
   "jay-babu/mason-null-ls.nvim",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
   },
   opts = {
      ensure_installed = nil,
      automatic_installation = { exclude = andros21.cfg.null_ls.exclude_install },
      automatic_setup = false,
   },
   priority = 100,
}
