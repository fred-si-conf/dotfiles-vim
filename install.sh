#!/usr/bin/env sh

REPOSITORIES_ROOT="git@github.com:fred-si-conf"

CONFIG_DIRECTORY="${XDG_CONFIG_HOME:-${HOME}/.config}"
VIM_DIRECTORY="${CONFIG_DIRECTORY}/vim"
VIM_RC="${HOME}"
error() {
    echo "Error: $1" > /dev/stderr
    exit "${2:-1}"
}

if [ -e "${VIM_DIRECTORY}" ]; then
    error "directory ${VIM_DIRECTORY} already exists"
fi

if [ -e "${VIM_DIRECTORY}" ]; then
    error "directory ${VIM_DIRECTORY} already exists"
fi


if ! which git > /dev/null 2>&1; then
    error "Git dependency not found"
fi

git clone "${REPOSITORIES_ROOT}/dotfiles-vim.git" "${VIM_DIRECTORY}"
