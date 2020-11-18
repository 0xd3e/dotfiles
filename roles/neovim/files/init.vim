"
" Basic Setup
"

filetype plugin indent on      " Detect filetype, load its plugin and indent file

set backspace=indent,eol,start " Set backspace behavior like in every other editor
set cmdheight=2                " Coc: Give more space for displaying messages
set colorcolumn=80,100         " Draw ruler(s) 
set cursorline                 " Highlight the current line
set hidden                     " Coc: TextEdit might fail if hidden is not set
set list                       " Show hidden characters
set listchars=tab:\→\ ,trail:· " Set characters for indicating tabs and trailing spaces
set nobackup                   " Coc: Some servers have issues with backup files
set nowritebackup              " Coc: Some servers have issues with backup files
set noshowmode                 " Hide -- INSERT -- (suggested by lightline plugin)
set shortmess+=c               " Coc: Don't pass messages to completion-menu
set showtabline=2              " Lightline: Bufferline: Always show tabline
set signcolumn=yes             " Always show the signcolumn
set splitbelow                 " Add new window below the current one for horizontal split
set splitright                 " Add new window right of the current one for vertical split
set updatetime=300             " Coc: Longer updatetime leads to poor user experience
set whichwrap+=<,>             " Let left and right arrow keys move to previous / next line

""" Coloring Stuff
set termguicolors              " Enable 24-bit RGB color
set background=light           " Use light version of the color scheme
syntax enable                  " Syntax highlighting
colorscheme PaperColor         " Set color scheme

""" Indentation
set autoindent                 " Enable autoindent
set shiftwidth=0               " Indent by 4 (0 uses the value of tabstop)
set smarttab                   " Use tabs for indentation and spaces for alignment
set tabstop=4                  " Tab width

""" Line Numbers
set number                     " Line numbers
set relativenumber             " Relative line numbers (Enables hybrid line numbers)
set numberwidth=6              " Line number gutter width

""" Encoding
set encoding=utf-8             " Set internal encoding
set fileencoding=utf-8         " Set file encoding
set fileencodings=utf-8        " Set file encoding for existing files

"
" Provider Settings
"

let g:node_host_prog = '{{ home }}/.local/share/nvim/provider/nodejs/node_modules/.bin/neovim-node-host'

"
" Mappings
"

" Break the habit of using the arrow keys for navigation.
noremap    <up>       <nop>
noremap    <down>     <nop>
noremap    <left>     <nop>
noremap    <right>    <nop>

nnoremap    sq    :w\|bd<cr>    " Use `sq` to save and close the buffer
nnoremap    qq    :bd!<cr>      " Use `qq` to close the buffer without saving

""" Change active window with <space> + winnr
nnoremap    <space>1    :exe 1 . 'wincmd w'<cr>
nnoremap    <space>2    :exe 2 . 'wincmd w'<cr>
nnoremap    <space>3    :exe 3 . 'wincmd w'<cr>
nnoremap    <space>4    :exe 4 . 'wincmd w'<cr>
nnoremap    <space>5    :exe 5 . 'wincmd w'<cr>
nnoremap    <space>6    :exe 6 . 'wincmd w'<cr>
nnoremap    <space>7    :exe 7 . 'wincmd w'<cr>
nnoremap    <space>8    :exe 8 . 'wincmd w'<cr>
nnoremap    <space>9    :exe 9 . 'wincmd w'<cr>

""" Change buffer with <leader> + ordinal buffer number
nmap    <leader>1    <plug>lightline#bufferline#go(1)
nmap    <leader>2    <plug>lightline#bufferline#go(2)
nmap    <leader>3    <plug>lightline#bufferline#go(3)
nmap    <leader>4    <plug>lightline#bufferline#go(4)
nmap    <leader>5    <plug>lightline#bufferline#go(5)
nmap    <leader>6    <plug>lightline#bufferline#go(6)
nmap    <leader>7    <plug>lightline#bufferline#go(7)
nmap    <leader>8    <plug>lightline#bufferline#go(8)
nmap    <leader>9    <plug>lightline#bufferline#go(9)
nmap    <leader>0    <plug>lightline#bufferline#go(10)

""" Move line(s) up and down with <ALT> and J or K
""" TODO: Something is broken here
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

""" Go to
nmap <silent>    gd    <plug>(coc-definition)
nmap <silent>    gy    <plug>(coc-type-definition)
nmap <silent>    gi    <plug>(coc-implementation)
nmap <silent>    gr    <plug>(coc-references)

""" Symbol renaming
nnoremap <silent>    <space>rn    <plug>(coc-rename)

""" Show documentation
nnoremap <silent>    K    :call <sid>show_documentation()<cr>

""" Open coc-explorer
nnoremap <silent><nowait>    <space>e     :CocCommand explorer<cr>

""" Show diagnostics of the current file
nnoremap <silent><nowait>    <space>d     :CocDiagnostics<cr>

""" Show coc-list
nnoremap <silent><nowait>    <space>lf    :<C-u>CocList files<cr>
nnoremap <silent><nowait>    <space>lb    :<C-u>CocList buffers<cr>

"
" Functions
"

""" Show documentation for the word under the cursor
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

""" Show file path from the Git root directory if it is in a Git repository at
""" all. Otherwise from the home directory.
function! LightlineGitFilepath()
	let dir = finddir('.git/..', expand('%:p:h').';')
	return expand('%')
endfunction

"
" Lightline Configuration
"

""" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'PaperColor_light'
let g:lightline.active = {'left': [['winnr', 'mode', 'paste'], ['readonly', 'gitfilepath', 'modified']]}
let g:lightline.inactive = {'left': [['winnr'], ['filename']]}
let g:lightline.tabline = {'left': [['buffers']], 'right': []}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
let g:lightline.component_function = {}
let g:lightline.component_function.gitfilepath = 'LightlineGitFilepath'

""" Bufferline
let g:lightline#bufferline#show_number = 2          " Show ordinal number
let g:lightline#bufferline#filename_modifier = ':t' " Show only filename

"
" coc.nvim Customization
"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"
" Language specific settings
"

""" Bazel
autocmd FileType bzl setlocal expandtab
autocmd FileType bzl setlocal softtabstop=4
autocmd FileType bzl setlocal tabstop=4

""" Go
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport') " Format on save

""" Protocol Buffers
autocmd FileType proto setlocal expandtab
autocmd FileType proto setlocal softtabstop=2
autocmd FileType proto setlocal tabstop=2

""" SQL
let g:omni_sql_no_default_maps = 1 " Disable default key mappings from SQL filetype plugin

""" Terraform
autocmd FileType tf setlocal expandtab
autocmd FileType tf setlocal softtabstop=2
autocmd FileType tf setlocal tabstop=2

""" YAML
autocmd FileType yaml setlocal expandtab
autocmd FileType yaml setlocal softtabstop=2
autocmd FileType yaml setlocal tabstop=2
