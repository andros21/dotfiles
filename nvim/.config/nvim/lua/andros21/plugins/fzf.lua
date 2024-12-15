-- fzf.lua
-- =======
-- see:
--  * https://github.com/ibhagwan/fzf-lua
--  * https://github.com/ibhagwan/fzf-lua#default-options
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua

local util = require("andros21.util")

return {
   "ibhagwan/fzf-lua",
   cmd = "FzfLua",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   keys = {
      { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
      { "<leader>/", util.fzflua("live_grep_native"), desc = "Find in Files (Grep)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", util.fzflua("gfiles"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>ff", util.fzflua("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", util.fzflua("files", { cwd = "." }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "commits" },
      { "<leader>gb", "<cmd>FzfLua git_bcommits<CR>", desc = "bcommits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>FzfLua autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Diagnostics document" },
      { "<leader>sD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Diagnostics workspace" },
      { "<leader>sg", util.fzflua("grep_project"), desc = "Grep (root dir)" },
      { "<leader>sG", util.fzflua("grep_project", { cwd = "." }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sw", util.fzflua("grep_cword"), desc = "Word (root dir)" },
      { "<leader>sW", util.fzflua("grep_cword", { cwd = false }), desc = "Word (cwd)" },
   },
   opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      -- Trouble
      if LazyVim.has("trouble.nvim") then
         config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
      end

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
         local o = vim.deepcopy(ctx.__call_opts)
         o.root = o.root == false
         o.cwd = nil
         o.buf = ctx.__CTX.bufnr
         LazyVim.pick.open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      -- use the same prompt for all
      local defaults = require("fzf-lua.profiles.default-title")
      local function fix(t)
         t.prompt = t.prompt ~= nil and " " or nil
         for _, v in pairs(t) do
            if type(v) == "table" then
               fix(v)
            end
         end
      end
      fix(defaults)

      local img_previewer ---@type string[]?
      for _, v in ipairs({
         { cmd = "ueberzug", args = {} },
         { cmd = "chafa", args = { "{file}", "--format=symbols" } },
         { cmd = "viu", args = { "-b" } },
      }) do
         if vim.fn.executable(v.cmd) == 1 then
            img_previewer = vim.list_extend({ v.cmd }, v.args)
            break
         end
      end

      return vim.tbl_deep_extend("force", defaults, {
         fzf_colors = true,
         fzf_opts = {
            ["--no-scrollbar"] = true,
         },
         defaults = {
            -- formatter = "path.filename_first",
            formatter = "path.dirname_first",
         },
         previewers = {
            git_diff = {
               pager = "delta --width=$FZF_PREVIEW_COLUMNS",
            },
            builtin = {
               extensions = {
                  ["png"] = img_previewer,
                  ["jpg"] = img_previewer,
                  ["jpeg"] = img_previewer,
                  ["gif"] = img_previewer,
                  ["webp"] = img_previewer,
               },
               ueberzug_scaler = "fit_contain",
            },
         },
         -- Custom LazyVim option to configure vim.ui.select
         ui_select = function(fzf_opts, items)
            return vim.tbl_deep_extend("force", fzf_opts, {
               prompt = " ",
               winopts = {
                  title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
                  title_pos = "center",
               },
            }, fzf_opts.kind == "codeaction" and {
               winopts = {
                  layout = "vertical",
                  -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
                  height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
                  width = 0.5,
                  preview = {
                     layout = "vertical",
                     vertical = "down:15,border-top",
                  },
               },
            } or {
               winopts = {
                  width = 0.5,
                  -- height is number of items, with a max of 80% screen height
                  height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
               },
            })
         end,
         winopts = {
            width = 0.8,
            height = 0.8,
            row = 0.5,
            col = 0.5,
            preview = {
               scrollchars = { "┃", "" },
            },
         },
         git = {
            status = {
               preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
            },
            commits = {
               preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
            },
            bcommits = {
               preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
            },
         },
         files = {
            cwd_prompt = false,
            fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,.cache,.venv}'",
         },
         grep = {
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --follow -g '!.git'",
         },
         lsp = {
            symbols = {
               symbol_hl = function(s)
                  return "TroubleIcon" .. s
               end,
               symbol_fmt = function(s)
                  return s:lower() .. "\t"
               end,
               child_prefix = false,
            },
            code_actions = {
               previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
            },
         },
      })
   end,
   config = function(_, opts)
      require("fzf-lua").setup(opts)
   end,
   init = function()
      LazyVim.on_very_lazy(function()
         vim.ui.select = function(...)
            require("lazy").load({ plugins = { "fzf-lua" } })
            local opts = LazyVim.opts("fzf-lua") or {}
            require("fzf-lua").register_ui_select(opts.ui_select or nil)
            return vim.ui.select(...)
         end
      end)
   end,
}
