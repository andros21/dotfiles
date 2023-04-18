-- fzf.lua
-- =======
-- see:
--  * https://github.com/ibhagwan/fzf-lua
--  * https://github.com/ibhagwan/fzf-lua#default-options
--  * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua

local util = require("andros21.util")

return {
   "ibhagwan/fzf-lua",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   keys = {
      { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
      { "<leader>/", util.fzflua("live_grep_native"), desc = "Find in Files (Grep)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", util.fzflua("gfiles"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>ff", util.fzflua("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", util.fzflua("files", { cwd = false }), desc = "Find Files (cwd)" },
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
      { "<leader>sG", util.fzflua("grep_project", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sw", util.fzflua("grep_cword"), desc = "Word (root dir)" },
      { "<leader>sW", util.fzflua("grep_cword", { cwd = false }), desc = "Word (cwd)" },
   },
   opts = {
      previewers = {
         git_diff = {
            pager = "delta --width=$FZF_PREVIEW_COLUMNS",
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
         fd_opts = "--color=never --type f --hidden --follow --exclude '{.git,.cache,.venv}'",
      },
      grep = {
         rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --follow -g '!.git'",
      },
   },
}
