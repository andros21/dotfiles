-- init.lua
-- ========
-- see:
--  * https://github.com/LazyVim/LazyVim
--  * https://github.com/LunarVim/Neovim-from-scratch/
--  * https://github.com/nikbrunner/vin/

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("andros21.config.cfg")

require("bootstrap.lazy")
require("lazy").setup("andros21.plugins")

require("andros21.config.options")
require("andros21.config.autocmds")
require("andros21.config.keymaps")
