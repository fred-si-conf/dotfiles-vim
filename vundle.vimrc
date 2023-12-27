"{{{ Configuration de Vundle et de ses plugins
"
" see :h vundle for more details or wiki for FAQ
"
" Toutes les commandes "Plugin 'plugpath' doivent se trouver entre 
" 'call vundle#begin()' et 'call vundle#end()'
"
" The following are examples of different formats supported.
"   Plugin 'tpope/vim-fugitive' " plugin on GitHub repo
"   Plugin 'L9' " plugin from http://vim-scripts.org/vim/scripts.html
"   Plugin 'git://git.wincent.com/command-t.git' " Git not hosted on GitHub
"   Plugin 'file:///home/gmarik/path/to/plugin' " git repos on local machine
"
" On peut changer le nom d’un plugin
"   Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Ou spécifier un runtime path différent
"   Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" }}}


set nocompatible " be iMproved, required
filetype off     " required

let $bundle_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/bundle'
set rtp+=$bundle_dir/Vundle.vim
call vundle#begin() " Keep Plugin commands between vundle#begin/end.

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

Plugin 'scrooloose/syntastic.git'

Plugin 'Yggdroot/indentLine' " met en surbrillance les niveau d’indentation

Plugin 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" vim: foldmethod=marker
