-- util.lua
-- ========
-- see:
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua
--  * https://github.com/nikbrunner/vin/blob/main/lua/vin/plugins/lsp/null_ls.lua

local M = {}

-- this will return a function that calls fzflua.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.fzflua(builtin, opts)
   local params = { builtin = builtin, opts = opts }
   return function()
      builtin = params.builtin
      opts = params.opts
      skip = params
      opts = vim.tbl_deep_extend("force", { cwd = require("lazyvim.util.init").get_root() }, opts or {})
      if builtin == "gfiles" then
         if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
            builtin = "git_files"
         else
            builtin = "files"
         end
      end
      require("fzf-lua")[builtin](opts)
   end
end

-- build null-ls sources from cfg dict
function M.build_sources(null_ls, config)
   local sources = {}

   for category, entries in pairs(config) do
      for _, entry in ipairs(entries) do
         local source = null_ls.builtins[category][entry]
         table.insert(sources, source)
      end
   end

   return sources
end

-- lsp_zero on_attach function setup
--  * default keymaps
--  * format on save
function M.lsp_zero_on_attach(lsp_zero)
   return function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      lsp_zero.buffer_autoformat({ client = client, buffer = bufnr, opts = opts })
      vim.api.nvim_create_autocmd("CursorHold", {
         buffer = bufnr,
         callback = function()
            local opts = {
               focusable = false,
               close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
               border = "rounded",
               source = "always",
               prefix = " ",
               scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
         end,
      })
   end
end

return M
