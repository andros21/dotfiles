-- cfg.lua
-- =======
-- see https://github.com/nikbrunner/vin/blob/main/lua/vin/config.lua

_G.andros21 = { cfg = {} }

andros21.cfg = {
   mason = {
      -- via WhoIsSethDaniel/mason-tool-installer.nvim
      -- see andros21/plugins/mason-tool-installer.nvim
      formatter = {
         lua = { "stylua" },
         sh = { "shfmt" },
         fish = { "fishindent" },
         python = { "ruff" },
         yaml = { "yamlfmt" },
         toml = { "taplo" },
         javascript = { "prettier" },
         css = { "prettier" },
         html = { "prettier" },
         markdown = { "prettier" },
      },
      nvim_lint = {
         yaml = { "yamllint", "actionlint" },
         sh = { "shellcheck" },
         python = { "ruff" },
         dockerfile = { "hadolint" },
      },
      lsp_zero = { rust = { "rust-analyzer" } },
      exclude_install = { "fishindent" },
   },
   syntax = {
      -- via nvim-treesitter/nvim-treesitter
      -- see andros21/plugins/treesitter.lua
      ensure_installed = {
         "bash",
         "c",
         "cpp",
         "css",
         "dockerfile",
         "fish",
         "go",
         "html",
         "java",
         "javascript",
         "jsdoc",
         "json",
         "lua",
         "make",
         "markdown",
         "markdown_inline",
         "meson",
         "python",
         "query",
         "regex",
         "rust",
         "scss",
         "toml",
         "tsx",
         "typescript",
         "vim",
         "vimdoc",
         "yaml",
      },
   },
}
