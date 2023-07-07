" Display line numbers
set number

" Display relative line numbers
set relativenumber

" Enable automatic indentation
set autoindent

" Set tab and indentation settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

" Highlight search results
set hlsearch

" Enable filetype detection and indent plugins
filetype plugin indent on

" Enable syntax highlighting if available
if has("syntax")
    syntax on
endif

" Set the color scheme to 'desert'
colorscheme desert

" Enable line wrapping
set wrap
set linebreak

" Indent wrapped lines to improve readability
set breakindent
set breakindentopt=shift:2

" Enable folding
set foldmethod=indent
set foldlevel=1

" Disable arrow keys to avoid accidental usage
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Set the spell language to English
set spelllang=en_us

" Map spell checker to F9 key
map <F9> :set spell!<CR>

" Map F2 to change inner word
map <F2> ciw

" Comment or uncomment lines with <F3>
nnoremap <F3> :call CommentToggle()<CR>
vnoremap <F3> :call CommentToggle()<CR>
nnoremap <S-F3> :call UncommentToggle()<CR>
vnoremap <S-F3> :call UncommentToggle()<CR>

" Toggle comment for the current line or selected lines
function! CommentToggle()
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog' || ft == 'c' || ft == 'cpp' || ft == 'shell' || ft == 'perl' || ft == 'ruby' || ft == 'java' || ft == 'make' || ft == 'yaml' || ft == 'python' || ft == 'json' || ft == 'xml' || ft == 'markdown'
        if &selection == 'exclusive'
            let [lnum1, col1] = getpos("'<")[1:2]
            let [lnum2, col2] = getpos("'>")[1:2]
        else
            let lnum1 = line('.')
            let lnum2 = line('.')
        endif
        call ToggleComment(lnum1, lnum2)
    endif
endfunction

" Toggle uncomment for the current line or selected lines
function! UncommentToggle()
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog' || ft == 'c' || ft == 'cpp' || ft == 'shell' || ft == 'perl' || ft == 'ruby' || ft == 'java' || ft == 'make' || ft == 'yaml' || ft == 'python' || ft == 'json' || ft == 'xml' || ft == 'markdown'
        if &selection == 'exclusive'
            let [lnum1, col1] = getpos("'<")[1:2]
            let [lnum2, col2] = getpos("'>")[1:2]
        else
            let lnum1 = line('.')
            let lnum2 = line('.')
        endif
        call ToggleUncomment(lnum1, lnum2)
    endif
endfunction

" Toggle comment for the current line or selected lines
function! ToggleComment(lnum1, lnum2)
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)\\(.*\\)/\\1\\/\\/ \\2/"
    elseif ft == 'c' || ft == 'cpp' || ft == 'shell' || ft == 'perl' || ft == 'ruby' || ft == 'java' || ft == 'make' || ft == 'yaml' || ft == 'python' || ft == 'json'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)\\(.*\\)/\\1# \\2/"
    elseif ft == 'xml'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)\\(.*\\)/\\1<!-- \\2 -->/"
    elseif ft == 'markdown'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)\\(.*\\)/\\1<!--- \\2 --->/"
    endif
endfunction

" Toggle uncomment for the current line or selected lines
function! ToggleUncomment(lnum1, lnum2)
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)\\/\\/ \\(.*\\)/\\1\\2/"
    elseif ft == 'c' || ft == 'cpp' || ft == 'shell' || ft == 'perl' || ft == 'ruby' || ft == 'java' || ft == 'make' || ft == 'yaml' || ft == 'python' || ft == 'json'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)# \\(.*\\)/\\1\\2/"
    elseif ft == 'xml'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)<!-- \\(.*\\) -->/\\1\\2/"
    elseif ft == 'markdown'
        execute a:lnum1 . "," . a:lnum2 . "s/\\(\\s*\\)<!--- \\(.*\\) --->/\\1\\2/"
    endif
endfunction

" Fold instructions:
" - Use `za` to toggle folding for the current fold.
" - Use `zo` to open a fold under the cursor.
" - Use `zc` to close a fold under the cursor.
" - Use `zR` to open all folds in the current buffer.
" - Use `zM` to close all folds in the current buffer.
" - Use `zj` to move the cursor to the next fold.
" - Use `zk` to move the cursor to the previous fold.

" Comment instructions:
" - Press <F3> to toggle commenting on the current line or selected lines.
" - Press <Shift+F3> to toggle uncommenting on the current line or selected lines.
" - When no lines are selected, the current line will be toggled.
" - Supported file types for commenting/uncommenting: verilog, systemverilog, c, cpp, shell, perl, ruby, java, make, yaml, python, json, xml, and markdown.
" - Use visual mode (<Shift+v>) to select multiple lines and then press <F3> or <Shift+F3> to comment or uncomment the selected lines.
