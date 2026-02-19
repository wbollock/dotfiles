"##### VIMRC #####"

"# Bug in windows terminal that starts in replace mode fix"
nnoremap R <Esc>

"########### Plugins ###########"

" install vim-plug
 if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
         autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
         endif



" enable plugins (:PlugInstall)
call plug#begin('~/.vim/plugged')

" Theme
" Plug 'junegunn/seoul256.vim'
"Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
"Plug 'embark-theme/vim'
"set termguicolors

" Git Plugin - :Git/:G
Plug 'tpope/vim-fugitive'

" Vimwiki
Plug 'vimwiki/vimwiki'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Notational-fzf-vim (note searching)
Plug 'https://github.com/alok/notational-fzf-vim'

" Git syntax
Plug 'tpope/vim-git'

call plug#end()

"########### Plugins End ###########"

"########### Plugin Configuration ###########"

" seoul256 settings
"set background=dark
set background=light

" syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" #### vimwiki #####

" set filetype=markdown in directories other than vimwiki
" https://github.com/vimwiki/vimwiki/issues/769
let g:vimwiki_global_ext = 0

" enable markdown
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown'}] 

" custom folding
let g:vimwiki_folding = 'custom'

" https://github.com/vimwiki/vimwiki/issues/1055#issuecomment-1483922051
function! s:Fix_auto_diary_index()
  VimwikiDiaryGenerateLinks 
  write
endfunction

augroup vimwiki_fix_auto_diary_index
  autocmd!
  autocmd BufEnter diary.wiki call <SID>Fix_auto_diary_index()
augroup END

" https://frostyx.cz/posts/vimwiki-diary-template
au BufNewFile ~/vimwiki/diary/*.wiki :silent 0r !/home/wbollock/scripts/vim_scripts/gen_vimwiki_diary '%'

"########### Plugin Configuration End ###########"



"########### General Configuration ###########"

" enter the current millenium, technically useless
"set nocompatible

" enable syntax and plugins
syntax on
filetype indent plugin on

au FileType gitcommit setlocal tw=72
set fo+=t

" yaml editor
autocmd FileType yaml setlocal cursorcolumn

" allows copy and pasting formatting, and line numbers
" set paste
set nu

" move swp files to ~/.vim/tmp/
" https://stackoverflow.com/questions/11255877/vim-swp-files-interfere-with-repository-vimdiff
set directory=~/.vim/tmp//,/tmp

" notational-fzf search paths
let g:nv_search_paths = ['~/vimwiki' ]

" set backspace for whatever reason
" https://stackoverflow.com/questions/11560201/backspace-key-not-working-in-vim-vi
set backspace=indent,eol,start

" autosave markdown and wiki files
autocmd BufNewFile,BufRead *.md :autocmd TextChanged,TextChangedI <buffer> silent write
autocmd BufNewFile,BufRead *.wiki :autocmd TextChanged,TextChangedI <buffer> silent write

augroup gitsetup
        autocmd!

        " Only set these commands up for git commits
        autocmd FileType gitcommit
                \  hi def link gitcommitOverflow Error
                \| autocmd CursorMoved,CursorMovedI *
                        \  let &l:textwidth = line('.') == 1 ? 50 : 72
augroup end

" clipboard - https://stackoverflow.com/a/10979533
set clipboard=unnamedplus

" set cursor cause of FZF bug - https://github.com/junegunn/fzf.vim/issues/1125
let &t_SI .= "\<Esc>[5 q"
let &t_SR .= "\<Esc>[5 q"
let &t_EI .= "\<Esc>[5 q"
"########### General Configuration End ###########"

