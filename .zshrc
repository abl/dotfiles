if [[ -f "/mnt/c/WINDOWS/system32/wsl.exe" ]]; then
  # We're in WSL, which defaults to umask 0 and causes issues with compaudit
  umask 0022
  if [[ "${PWD}" = "/mnt/c/Users/${USER}" ]]; then
    # We're in a default WSL shell
    cd "${HOME}"
  fi
fi

if [[ ! -d "$HOME/.zinit" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  chmod 700 "$HOME/.zinit"
fi

### Added by zinit's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of zinit installer's chunk

# A binary Zsh module which transparently and automatically compiles sourced scripts
module_path+=( "${HOME}/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin &>/dev/null

zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# zdharma/history-search-multi-word
zinit ice wait"1" lucid
zinit load zdharma/history-search-multi-word

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice wait lucid blockf atinit'chmod 700 .'
zinit load agkozak/zsh-z

# BurntSushi/ripgrep
zinit ice as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg" atclone'curl -Lo _rg https://raw.githubusercontent.com/BurntSushi/ripgrep/master/complete/_rg' atpull'%atclone'
zinit light BurntSushi/ripgrep

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd" atclone'curl -Lo _fd https://raw.githubusercontent.com/sharkdp/fd/master/contrib/completion/_fd' atpull'%atclone'
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat" atclone'mv -f **/*.zsh _bat' atpull'%atclone'
zinit light sharkdp/bat

# dandavision/delta
zinit ice as"command" from"gh-r" mv"delta* -> delta" pick"delta/delta" atclone'curl -Lo _delta https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh' atpull'%atclone'
zinit light dandavison/delta
# Configure as default git diff renderer
git config --global core.pager "delta --dark"

# ogham/exa, replacement for ls
zinit ice as"command" from"gh-r" mv"exa* -> exa" pick"exa/exa" atclone'curl -Lo _exa https://raw.githubusercontent.com/ogham/exa/master/completions/completions.zsh' atpull'%atclone'
zinit light ogham/exa

# direnv
zinit ice from"gh-r" as"program" mv"direnv* -> direnv"
zinit light direnv/direnv

# gh cli 
zinit ice as"command" from"gh-r" pick"./**/gh" atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone'
zinit light cli/cli

# micro 
zinit ice as"command" from"gh-r" pick"./**/micro"
zinit light zyedidia/micro

# pyenv
zinit ice atclone"./libexec/pyenv init - > zpyenv.zsh" \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

# fzf
zinit ice from"gh-r" as"program" atclone'curl -Lo _fzf https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh' atpull'%atclone'
zinit light junegunn/fzf

# forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# zsh-autopair
zinit ice wait lucid
zinit load hlissner/zsh-autopair

# Autosuggestions & fast-syntax-highlighting
zinit ice wait"1" lucid atinit"zpcompinit; zpcdreplay" atload"FAST_HIGHLIGHT[chroma-git]=\"chroma/-ogit.ch\""
zinit light zdharma/fast-syntax-highlighting
# zsh-autosuggestions
zinit ice wait"1" lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

PATH=${PATH}:"${HOME}/.bin":"${HOME}/.local/bin"

# Nix
if [[ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

alias ls=exa
alias cat=bat
alias less=bat
alias more=bat

setopt inc_append_history
setopt share_history

export EDITOR="micro"
export VISUAL="micro"

if [[ -d "${HOME}/.deno" ]]; then
    export DENO_INSTALL="${HOME}/.deno"
    export PATH="$PATH:$DENO_INSTALL/bin"
fi

if [[ -d "${HOME}/.go/env" ]]; then
    source "$HOME/.go/env"
fi

if [[ -d "${HOME}/.fly" ]]; then
    export FLYCTL_INSTALL="${HOME}/.fly"
    export PATH="$PATH:$FLYCTL_INSTALL/bin"
fi
