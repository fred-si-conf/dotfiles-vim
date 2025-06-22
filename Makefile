.DEFAULT_GOAL=install
.PHONY=install


install: bundle/Vundle.vim
	/usr/bin/env vim -c PluginInstall

bundle/Vundle.vim:
	git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
