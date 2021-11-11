if [[ -f "/mnt/c/WINDOWS/system32/wsl.exe" ]]; then
  # We're in WSL, which defaults to umask 0 and causes issues with compaudit
  umask 0022
  if [[ "${PWD}" = "/mnt/c/Users/${USER}" ]]; then
    # We're in a default WSL shell
    cd "${HOME}"
  fi
fi

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

if [[ -f "${HOME}/.local.before.zshrc" ]]; then
  source "${HOME}/.local.before.zshrc"
fi

zcomet load zsh-users/zsh-completions

zcomet load zdharma-continuum/history-search-multi-word

zcomet load sindresorhus/pure async.zsh pure.zsh

zcomet load agkozak/zsh-z

zcomet load abl/zsh-direnv

zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh
(( ${+commands[fzf]} )) || ~[fzf]/install --bin

zcomet load wfxr/forgit

zcomet load hlissner/zsh-autopair

zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

path=($path "${HOME}/.bin" "${HOME}/.local/bin")

# Nix
if [[ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

if which exa > /dev/null 2>&1; then
  alias ls=exa
fi

if which bat > /dev/null 2>&1; then
  alias cat=bat
  alias less=bat
  alias more=bat
fi

setopt inc_append_history
setopt share_history

export EDITOR="nano"
export VISUAL="nano"

if [[ -d "${HOME}/.deno" ]]; then
    export DENO_INSTALL="${HOME}/.deno"
    path=($path "${DENO_INSTALL}/bin")
fi

if [[ -d "${HOME}/.go/env" ]]; then
    source "$HOME/.go/env"
fi

if [[ -d "${HOME}/.fly" ]]; then
    export FLYCTL_INSTALL="${HOME}/.fly"
    path=($path "${FLYCTL_INSTALL}/bin")
fi

if [[ ! -d "${HOME}/.nano" ]]; then
  echo "Setting up .nanorc..."
  pushd "${HOME}" > /dev/null
  curl -sL https://github.com/scopatz/nanorc/archive/refs/heads/master.tar.gz | tar xz
  mv nanorc-master .nano
  find ~/.nano -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc 2>/dev/null
  popd > /dev/null
fi

path=(/usr/local/bin $path)

if [[ -f "${HOME}/.local.after.zshrc" ]]; then
  source "${HOME}/.local.after.zshrc"
fi

typeset -U path

zcomet compinit