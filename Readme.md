# Vim config
## Install
```shell
curl 'https://raw.githubusercontent.com/fred-si-conf/dotfiles-vim/main/install.sh' \
    | sh - \
    && cd "${XDG_CONFIG_HOME:-${HOME}/.config}/vim" \
    && make install \
    && cd "${OLDPWD}"
```