"
" Call pathogen plugin
" http://www.vim.org/scripts/script.php?script_id=2332
"
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set number
set mouse=a

set autoindent

set tabstop=4 shiftwidth=4 softtabstop=4

" Highlight current line in insert mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

filetype indent on

"abilitazione riconoscimento file
filetype on
autocmd FileType c,cpp,php set cindent "shiftwidth=4 "imposto indentazione C per i file c cpp e php
set textwidth=75

"Per il completamento automatico in vim
autocmd FileType css set omnifunc=csscomplete#CompleteCSS smartindent "shiftwidth=4 "aggiungo l'indentazione per i css

augroup php
    " devo disabilitarlo perchè eclim non funziona se no
    let g:acp_behaviorPhpOmniLength= -1
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType php inoremap () ()<++><Esc>F)i
    autocmd FileType php inoremap [] []<++><Esc>F]i
    "autocmd FileType php inoremap {} {}<++><Esc>F}i
    autocmd FileType php inoremap { {<CR>}<Esc>O
    autocmd FileType php inoremap <? <?php<Esc>o
    "for php-documentator plugin
    autocmd FileType php inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
    autocmd FileType php nnoremap <C-P> :call PhpDocSingle()<CR>
    autocmd FileType php vnoremap <C-P> :call PhpDocRange()<CR>

    autocmd FileType php set formatoptions=cq
    " highlights interpolated variables in sql strings and does sql-syntax
    " highlighting. yay
    "
    " autocmd FileType php let php_sql_query=1
    "
    " " does exactly that. highlights html inside of php strings
    "
    " autocmd FileType php let php_htmlInStrings=1
    "
    " " discourages use oh short tags. c'mon its deprecated remember
    "
    " autocmd FileType php let php_noShortTags=1
    "
    " " automagically folds functions & methods. this is getting IDE-like
    " isn't it?
    "
     "autocmd FileType php let php_folding=1
    
    " set 'make' command when editing php files
    " autocmd FileType php set makeprg=php\ -l\ %
    " autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
    " Ho installato l'ftplugin phpErrorMaker
    
    " zendtags
    " autocmd FileType php set tags=~/.vim/zendtags
    
    " Quando chiamo il make in automatico salvo il file prima di lanciare la
    " compilazione
    " autocmd QuickFixCmdPre make w
    "
    " Uso la variabile del plugin
    "let g:phpErrorMarker#autowrite = 1 
    let g:phpErrorMarker#openQuickfix = 0
augroup END

augroup tex
    "Per ortografia con Latex
    autocmd FileType tex setlocal spell spelllang=it
    "se non trova righe all'interno del file tex dico a vim di trattare i file con
    "estensione .tex come fossero latex e non plaintex che è di default
    let g:tex_flavor='latex'
    "let g:Tex_DefaultTargetFormat='pdf'
    "let g:Tex_ViewRule_pdf = 'okular'
    "let g:Tex_ViewRuleComplete_pdf = 'okular $*.pdf &&'
    let g:Tex_CompileRule_dvi='latex -src-specials -interaction=nonstopmode $*'
    let g:Tex_ViewRule_dvi = 'okular'
    "let g:Tex_ViewRuleComplete_dvi="xdvi -editor 'vimx --servername test --remote'"
    "let g:Tex_ViewRuleComplete_dvi = 'okular $*.dvi >/dev/null 2>&1 &'

    "necessario fare rimappare per vim-latex
    autocmd Filetype tex imap <C-i> <Plug>Tex_InsertItemOnThisLine
    "autocmd Filetype tex set textwidth=75
    "se sono in ambiente list uso sempre alt-i (o megio ctrl+i) per inserire \item
    "senza doverlo riscrivere ogni volta
    let g:Tex_ItemStyle_list = '\item <++>'
    autocmd filetype tex let g:EclimMakeLCD=0
augroup END


"Per posizionare la finestra di split sotto
set splitbelow

"Per evitare problemi di copia e incolla dal desktop uso
"il set paste e lo cambio con F12
set pastetoggle=<F12>

"per posizionare il cursore al centro dello schermo con \zz
"set scrolloff=0
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"insert one character
noremap <C-i> i<Space><Esc>r
"elimina i backslash
"nnoremap <somekey> :exec \"normal i".nr2char(getchar())."\e"<CR>
"nnoremap <someother> :exec \"normal a".nr2char(getchar())."\e"<CR>
"
"Abilitare il controllo dell'ortografia italiana
map <F10> :setlocal spell spelllang=it,en<CR>

"Per evitare che le parole vengano tagliate
set linebreak

"Muoversi sulle righe, devo usare <esc> perché ho xterm 8bit
vmap <esc>j gj
vmap <esc>k gk
vmap <esc>h gh
vmap <esc>l gl
vmap <esc>4 g$
vmap <esc>6 g^
vmap <esc>0 g^
nmap <esc>j gj
nmap <esc>k gk
nmap <esc>h gh
nmap <esc>l gl
nmap <esc>4 g$
nmap <esc>6 g^
nmap <esc>0 g^

"Folding
augroup Folding
    au BufWinLeave * mkview
    au BufWinEnter * silent loadview
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
    inoremap <F9> <C-O>zA
    nnoremap <F9> zA
    onoremap <F9> <C-C>zA
    vnoremap <F9> zF
augroup END

" Take from: http://vimcasts.org/episodes/tabs-and-spaces/
" Shortcut to rapidly toggle `set list`
nmap <Leader>k :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
	let &l:sts = l:tabstop
	let &l:ts = l:tabstop
	let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

:command! -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
:command! -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

