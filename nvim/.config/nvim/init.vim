scriptencoding utf-8

""" Install Vim-Plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.local/share"/nvim/site/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

""" Vim-Plug
call plug#begin()

" Aesthetics - Main
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'

" Functionalities
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'aymericbeaumet/vim-symlink'
Plug 'chrisbra/Colorizer'
Plug 'christoomey/vim-system-copy'
Plug 'dense-analysis/ale'
Plug 'dkarter/bullets.vim'
"https://github.com/windwp/nvim-autopairs
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'moll/vim-bbye'
Plug 'preservim/nerdcommenter'
"https://github.com/nvim-treesitter/nvim-treesitter
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
"https://github.com/kylechui/nvim-surround
Plug 'tpope/vim-surround'
Plug 'zenbro/mirror.vim'
Plug 'rust-lang/rust.vim'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

call plug#end()

""" Python3 nvim virtualenv
let g:loaded_python_provider = 0

""" Coloring
colorscheme nord
hi Comment      ctermfg = 103
hi Visual       ctermbg = 8
hi LineNr       ctermfg = 3
hi CursorLine   ctermbg = 235
hi CursorLineNr ctermfg = 1

""" Other Configurations
filetype plugin indent on
set tabstop=3 softtabstop=3 shiftwidth=3 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fileencoding=utf-8
set fillchars+=vert:\
set wrap breakindent
set inccommand=split
set timeoutlen=3000
set relativenumber
set spelllang+=it
set cursorline
set hidden
set title

""" Airline
let g:airline_detect_spell                       = 0
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#fnamemod        = ':t'
let g:airline#extensions#tabline#buffer_nr_show  = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1

if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_symbols.branch    = ''
let g:airline_symbols.notexists = '?'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.linenr    = ' '

""" vim-system-copy
let g:system_copy_silent       = 1
let g:system_copy#copy_command = 'xclip -sel clipboard'

""" Deoplete
let g:deoplete#enable_at_startup = 1

""" Ale
let g:ale_lint_on_enter            = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave     = 0
let g:ale_lint_on_save             = 1
let g:ale_lint_on_text_changed     = 0

let g:ale_fix_on_enter             = 0
let g:ale_fix_on_filetype_changed  = 0
let g:ale_fix_on_insert_leave      = 0
let g:ale_fix_on_save              = 1
let g:ale_fix_on_text_changed      = 0

let g:ale_disable_lsp            = 1
let g:ale_linters_explicit       = 1
let g:ale_linters                = {
                                   \ 'cpp'    : ['clangcheck'],
                                   \ 'fish'   : ['fish'],
                                   \ 'python' : ['flake8'],
                                   \ 'rust'   : ['cargo'],
                                   \ 'vim'    : ['vint'],
                                   \ 'yaml'   : ['yamllint']
                                   \}
let g:ale_fixers                 = {
                                   \ '*'      : ['remove_trailing_lines', 'trim_whitespace'],
                                   \ 'cpp'    : ['clang-format'],
                                   \ 'python' : ['autoimport', 'black', 'isort'],
                                   \ 'rust'   : ['rustfmt'],
                                   \}

""" indentLine
let g:indentLine_enabled    = 0
let g:indentLine_char       = '▏'
let g:indentLine_color_term = '102'

""" mirror.vim
let g:mirror#config_path = expand('~/.ssh/.mirrors.yml')

""" vim-symlink
let g:symlink_redraw = 0

""" vim-rooter
let g:rooter_patterns      = ['requirements.*', '.git', 'LICENSE*', 'README*']
let g:rooter_resolve_links = 1

""" vim-easytags
let g:easytags_always_enabled = 0
let g:easytags_auto_highlight = 0
let g:easytags_auto_update    = 0
let g:easytags_on_cursorhold  = 0
let g:easytags_dynamic_files  = 2

""" Function

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists('w:SavedBufView')
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr('%')] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr('%')
    if exists('w:SavedBufView') && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

function! StartifyEntryFormat()
   return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

""" AutoCmd

augroup mine

" Run PlugInstall if there are missing plugins
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC | endif

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" When switching buffers, preserve window view
if v:version >= 700
    au BufLeave * call AutoSaveWinView()
    au BufEnter * call AutoRestoreWinView()
endif

" Enable indentLine for particular FileType
au FileType bash,c,cpp,fish,python,rust,sh IndentLinesEnable

" Enable vim-easytags for particular FileType
au FileType c,cpp,python,rust let b:easytags_auto_update=1

" Enable text-wrap for particular FileType
au FileType markdown setlocal textwidth=60

" Highlight yanked text
au TextYankPost * silent! lua require'vim.highlight'.on_yank()

augroup END

""" Custom Mappings

" Map leader key
let mapleader=','

" Airline buffer
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>p <Plug>AirlineSelectPrevTab
nmap <leader>n <Plug>AirlineSelectNextTab

" Common commands
nmap <leader>e  :e $MYVIMRC<CR>
nmap <leader>r  :so $MYVIMRC<CR>
nmap <leader>s  :w<CR>
nmap <leader>d  :Bd<CR>
nmap <leader>D  <C-O>
nmap <leader>cd :cd ~/Documents<CR>
nmap <leader>mp :w<CR>:MirrorPush<CR>

" Startify
nmap <leader>S  :Startify<CR>

" Fzf vim
nmap <leader>f  :Files<CR>
nmap <leader>F  :Files!<CR>
nmap <leader>gf :GFiles<CR>
nmap <leader>gs :GFiles?<CR>
nmap <leader>b  :Buffers<CR>
nmap <leader>rg :Rg<CR>
nmap <leader>RG :Rg!<CR>
nmap <leader>l  :BLines<CR>
nmap <leader>L  :BLines!<CR>
nmap <leader>w  :Windows<CR>
nmap <leader>hh :History<CR>
nmap <leader>H  :History!<CR>
nmap <leader>rr :History:<CR>
nmap <leader>t  :Tags<CR>
nmap <leader>T  :BTags<CR>
