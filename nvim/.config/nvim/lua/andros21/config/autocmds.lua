-- autocmds.lua
-- ============
-- see https://www.lazyvim.org/configuration/general#auto-commands

local function augroup(name)
   return vim.api.nvim_create_augroup("andros21_" .. name, { clear = true })
end

-- wrap and check for spell also in txt files
vim.api.nvim_create_autocmd("FileType", {
   group = augroup("wrap_spell"),
   pattern = { "text" },
   callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
   end,
})
--
-- wrap and check for spell also in txt files
vim.api.nvim_create_autocmd("FileType", {
   group = augroup("wrap_width"),
   pattern = { "gitcommit", "markdown", "text" },
   callback = function()
      vim.opt_local.textwidth = 60
   end,
})

-- trim trial spaces and last lines
vim.api.nvim_create_autocmd("BufWritePre", {
   group = augroup("trail_trim"),
   pattern = { "*" },
   callback = function()
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()
   end,
})
