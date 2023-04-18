-- cfg.lua
-- =======
-- see https://github.com/nikbrunner/vin/blob/main/lua/vin/config.lua

_G.andros21 = { cfg = {} }

andros21.cfg = {
   null_ls = {
      -- via jay-babu/mason-null-ls.nvim
      -- see andros21/plugins/mason-null-ls.lua
      sources = {
         diagnostics = {
            "actionlint",
            "fish",
            "hadolint",
            "ruff",
            "shellcheck",
            "yamllint",
         },
         formatting = {
            "beautysh",
            "black",
            "fish_indent",
            "stylua",
            "taplo",
            "yamlfmt",
         },
      },
      exclude_install = { "fish", "fish_indent" },
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
         "tsx",
         "typescript",
         "vim",
         "vimdoc",
         "yaml",
      },
   },
}
