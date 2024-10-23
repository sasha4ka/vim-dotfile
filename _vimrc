" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" Basic settings ============
" colorscheme obsidian
colorscheme colorsbox-stnight
" colorscheme codedark

set nocompatible

filetype on
syntax on

set number
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set wrap
set linebreak
set showtabline=1
set backspace=indent,eol,start whichwrap+=<,>[,]

set mouse=a
set mousehide
set t_vb=
set visualbell t_vb=

set winwidth=130
set nobackup
set nowritebackup
set noswapfile

" Plugins
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'scrooloose/nerdcommenter'
    Plug 'flazz/vim-colorschemes'
    "Plug 'davidhalter/jedi-vim' 
call plug#end()

" Key remaps
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <S-F7> :vert rightb term<CR>
nnoremap <S-F1> :vert help 
nnoremap <S-F2> :colorscheme 
"nnoremap <S-F5> :!python -m pdb %<CR>
nnoremap <S-F5> :!python "C:\Users\Sasha\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\LocalCache\local-packages\Python311\site-packages\PyInstaller\__main__.py" -F %<CR>
nnoremap <F5> :!python %<CR>
nnoremap q <c-v>
let mapleader = ","
