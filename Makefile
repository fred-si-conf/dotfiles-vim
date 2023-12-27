.DEFAULT_GOAL=install
.PHONY=install


install: bundle/Vundle.vim

bundle/Vundle.vim:
	git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
