set nocompatible " Annule la compatibilité avec Vi : totalement indispensable

let $script_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Environnement {{{
if has('mouse')
    set mouse=a    " Active la souris
endif

source $script_dir/bepo.vimrc
source $script_dir/vundle.vimrc
" }}}

" Paramètres {{{
" Affichage
set title           " Met a jour le titre de fenêtre ou du terminal
set number          " Affiche le numéro des lignes
set relativenumber  " Numérote les lignes en fonction de la ligne courante
set ruler           " Affiche la position actuelle du curseur
set cursorline      " Marque la ligne sous le curseur
set cursorcolumn    " Marque la ligne sous le curseur
set colorcolumn=+1  " highlight first column after textwidth
set wrap            " Affiche les lignes trop longues sur plusieurs lignes
set showmode        " Affiche le mode dans lequel on se trouve
set linebreak       " Coupe les lignes trop longues au niveau d’un caractère
                    " 'breakat' plutot qu’au dernier caracère de la ligne

set scrolloff=3     " Affiche un minimum de 5 lignes autour du curseur

syntax enable       
set background=dark 
set t_Co=256        
colorscheme desert

" Recherche
set ignorecase " Ignore la casse lors d’une recherche
set smartcase  " Si une recherche contient une majuscule, réactive la sensibilité a la casse
set hlsearch   " Surligne les résultats de recherche
set incsearch  " Surligne les résultats de recherche pendant la saisie

" Généraux
set fileformat=unix
set backspace=indent,eol,start " Active le comportement 'habituel' de la touche retour en arriere

set history=500
set showcmd      " Affiche les commandes incomplètes

set autoindent   " Active l'indentation automatique
set expandtab    " Remplacement automatique des tabulation par des espaces
set tabstop=4    " Règle la longueur affiché d'une tabulation à 4 espaces.
set shiftwidth=4 " Nombre d'espaces  pour chaque pas d'(auto-)indentation.
set textwidth=79 " Coupe automatiquement les lignes de plus de 78 caractères

set wildmenu " Affiche un menu avec la liste des complétions possible un menu dans la ligne de commande
set hidden   " Cache un tampon abandonné plutôt que de le décharger
" }}}

" Commandes custom {{{
if !exists(":S") " Source le fichier ~/.vimrc
    command S :source ~/.vimrc
endif

if !exists(":Bepo") " Source le fichier ~/.vim/bepo.vimrc
    command Bepo :source ~/.vim/bepo.vimrc
endif

" fait un vimdiff {buffer_actif} {fichier_sur_le_disque}
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif
" }}}

" Fonctions {{{
function GoToLastPosition()
    " jump to the last known cursor position if position is valid.
    if line("'\"") > 1 && line("'\"") <= line("$") 
        exe "normal! g`\"" 
    endif
endfunction
" }}}

" Autocommands (Only when compiled with support for autocommands.) {{{
if has("autocmd")
    autocmd BufReadPost * call GoToLastPosition()

    " Met en surbrillance les caractères blanc en fin de ligne
    autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/
    highlight BadWhitespace ctermbg=red guibg=red

    " Met en surbrillance les espaces insécables
    autocmd BufRead,BufNewFile * match NonBreakableSpace / \+/
    highlight NonBreakableSpace ctermbg=238 guibg=lightgrey

    " Enable file type detection.
    filetype plugin indent on
    autocmd FileType lua setlocal textwidth=0
    autocmd FileType sh,bash,zsh setlocal foldmethod=indent

    autocmd FileType c,cpp,h,arduino
        \ setlocal foldmethod=syntax|
        \ setlocal tw=78

    autocmd FileType arduino
        \ nnoremap <leader>av :wa<CR>:ArduinoVerify<CR> |
        \ nnoremap <leader>au :wa<CR>:! screen -X kill<CR>:ArduinoUpload<CR> |
        \ nnoremap <leader>ad :wa<CR>:! screen -X kill<CR>:ArduinoUploadAndSerial<CR> |
        \ nnoremap <leader>as :! screen -X kill<CR>:ArduinoSerial<CR> |
        \ nnoremap <leader>ab :ArduinoChooseBoard<CR> |
        \ nnoremap <leader>ap :ArduinoChooseProgrammer<CR>

    " Recommendation de PEP8
    autocmd FileType python
        \ setlocal foldmethod=indent |
        \ setlocal tabstop=4 |
        \ setlocal softtabstop=4 |
        \ setlocal shiftwidth=4 |
        \ let g:python_highlight_all = 1 |
        \ syntax match pythonFunction /\v\w[[:alpha:]_.]+\ze(\s?\()/

    autocmd FileType html,php
        \ setlocal foldmethod=indent |
        \ setlocal tabstop=4 |
        \ setlocal shiftwidth=4 |
        \ setlocal colorcolumn=79 |

    autocmd FileType css
        \ setlocal foldmethod=syntax |
        \ setlocal tabstop=2 |
        \ setlocal shiftwidth=2 |
        \ setlocal textwidth=50 |

    autocmd FileType javascript
        \ setlocal foldmethod=syntax |
        \ let g:javascript_plugin_jsdoc = 1 |


    autocmd FileType tex
        \ setlocal grepprg=grep\ -nH\ $*|
        \ setlocal tabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal textwidth=76|
        \ let l:tex_flavor = "latex"

    autocmd FileType po set textwidth=0
    autocmd BufWritePost *.po !powrap %

    autocmd insertLeave * set cursorline
    autocmd insertEnter * set nocursorline
    autocmd insertLeave * set cursorcolumn
    autocmd insertEnter * set nocursorcolumn

    highlight CursorLine  cterm=none ctermbg=Blue

endif
" }}}

" Configuration du clavier {{{
let mapleader = ","        " Configure la touche <Leader>

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-A va au début de la ligne en mode commande
cnoremap <C-A> <C-B>

noremap <Space> za

" Se passer de la touche Echap
imap ,, <Esc>
map ,, <Esc>

" Delete from cursor do begin-of-line
inoremap <C-U> <C-G>u<C-U>

noremap <C-p> :<C-p>

" Navigation dans les tags
noremap <leader>s <C-]>
" Parce que sur mon terminal CTRL-T donne <CR>
noremap <leader>t :pop<CR>
" }}}

" Configuration des plugins {{{
let g:indentLine_char = '┊'

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" }}}

" vim: foldmethod=marker
