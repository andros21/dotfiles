-- util.lua
-- ========
-- see:
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua

local M = {}

-- this will return a function that calls fzflua.
-- cwd will default to lazyvim.util.root.get
-- for `files`, git_files or find_files will be chosen depending on .git
function M.fzflua(builtin, opts)
   local params = { builtin = builtin, opts = opts }
   return function()
      builtin = params.builtin
      opts = params.opts
      skip = params
      opts = vim.tbl_deep_extend("force", { cwd = require("lazyvim.util.init").root.get() }, opts or {})
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

-- lsp_zero on_attach function setup
--  * default keymaps
--  * format on save
function M.lsp_zero_on_attach(lsp_zero)
   return function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      lsp_zero.buffer_autoformat({ client = client, buffer = bufnr, opts = opts })
   end
end

-- get formatter.nvim filetype table of required builtin
function M.get_filetypes(config)
   local filetypes = {}
   for filetype, fmts in pairs(config) do
      filetypes[filetype] = {}
      for _, fmt in pairs(fmts) do
         local require = 'return require("formatter.filetypes.' .. filetype .. '").' .. fmt
         local ffmt = loadstring(require)
         table.insert(filetypes[filetype], ffmt())
      end
   end
   return filetypes
end

-- get requirements that must be installed with mason
function M.get_requirements(config)
   local unique = {}
   local requirements = {}
   local function contains(table, val)
      for i = 1, #table do
         if table[i] == val then
            return true
         end
      end
      return false
   end
   for key, filetypes in pairs(config) do
      if key ~= "exclude_install" then
         for _, deps in pairs(filetypes) do
            for i, dep in pairs(deps) do
               unique[dep] = i
            end
         end
      end
   end
   for dep, _ in pairs(unique) do
      if not contains(config.exclude_install, dep) then
         table.insert(requirements, dep)
      end
   end
   return requirements
end

return M
