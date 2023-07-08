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
nmap <F2> ciw
vmap <F2> c

" Toggle comment/uncomment with <Ctrl+/>
nmap <F3> :call CommentOrUncomment()<CR>
vmap <F3> :call CommentOrUncomment()<CR>

function! CommentOrUncomment()
    let ft = &filetype
	if ft == 'verilog' || ft == 'systemverilog' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'make' || ft == 'sh' || ft == 'python' || ft == 'yaml' || ft == 'ruby' || ft == 'perl' 
        if &selection == 'exclusive'
            let [lnum1, col1] = getpos("'<")[1:2]
            let [lnum2, col2] = getpos("'>")[1:2]
        else
            let lnum1 = line('.')
            let lnum2 = line('.')
        endif
        call ToggleCommentOrUncomment(lnum1, lnum2)
    endif
endfunction

function! ToggleCommentOrUncomment(lnum1, lnum2)
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'make' || ft == 'sh' || ft == 'python' || ft == 'yaml' || ft == 'ruby' || ft == 'perl' 
        let comment_chars = GetCommentChars()
        if len(comment_chars) > 0
            let is_commented = getline(a:lnum1) =~ comment_chars[0]
            if is_commented
                for i in range(a:lnum1, a:lnum2)
                    let line_text = substitute(getline(i), '^' . escape(comment_chars[0], '/'), '', '')
                    call setline(i, substitute(line_text, '^\s*', '', ''))
                endfor
            else
                execute a:lnum1 . "," . a:lnum2 . "s/^/". escape(comment_chars[0], '/') . " "
            endif
        endif
    endif
endfunction

function! GetCommentChars()
    let ft = &filetype
    if ft == 'verilog' || ft == 'systemverilog' || ft == 'c' || ft == 'cpp' || ft == 'java' || ft == 'make'
        return ['//']
    elseif ft == 'sh' || ft == 'python' || ft == 'yaml' || ft == 'ruby' || ft == 'perl'
        return ['#']
    endif
    return []
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
" - Comment characters are determined based on the file type.
" - For single line comments, use <F3> to toggle commenting/uncommenting.
" - For block comments, select multiple lines and use <F3> to toggle commenting/uncommenting.

