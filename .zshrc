# In this file place anything required to get git to work, e.g. proxy settings.
if [[ -f "${HOME}/.local.before.zshrc" ]]; then
  source "${HOME}/.local.before.zshrc"
fi

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

# Set up zcomet to manage zsh plugins and cache completions for a faster shell startup
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Plugins: described in `README.MD`
zcomet load zsh-users/zsh-completions

zcomet load sindresorhus/pure async.zsh pure.zsh

zcomet load agkozak/zsh-z

zcomet load abl/zsh-direnv

zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh
(( ${+commands[fzf]} )) || ~[fzf]/install --bin

zcomet load wfxr/forgit

# add ~/.bin and ~/.local/bin to PATH
path=($path "${HOME}/.bin" "${HOME}/.local/bin")

# Source the default Nix profile if it exists
if [[ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

# If exa is installed and on PATH, use it instead of ls
if which exa > /dev/null 2>&1; then
  alias ls=exa
fi

# If bat is installed and on PATH, use it instead of other pagers
if which bat > /dev/null 2>&1; then
  alias cat=bat
  alias less=bat
  alias more=bat
fi

# Append to history as it is created so that...
setopt inc_append_history

# ...history is shared between shells
setopt share_history

# Maybe not the best editor but one of the simplest and easiest to use.
export EDITOR="nano"
export VISUAL="nano"

# If deno is installed, add it to PATH
if [[ -d "${HOME}/.deno" ]]; then
    export DENO_INSTALL="${HOME}/.deno"
    path=($path "${DENO_INSTALL}/bin")
fi

# If golang is installed, source its environment
if [[ -d "${HOME}/.go/env" ]]; then
    source "$HOME/.go/env"
fi

# If fly is installed, add it to PATH
if [[ -d "${HOME}/.fly" ]]; then
    export FLYCTL_INSTALL="${HOME}/.fly"
    path=($path "${FLYCTL_INSTALL}/bin")
fi

# Add scopatz's excellent syntax highlighters; this requires a recent nano
# remember `nano -I` to ignore `.nanorc` if needed!
if [[ ! -d "${HOME}/.nano" ]]; then
  echo "[INFO] Setting up .nanorc..."
  pushd "${HOME}" > /dev/null
  curl -sL https://github.com/scopatz/nanorc/archive/refs/heads/master.tar.gz | tar xz
  mv nanorc-master .nano
  find ~/.nano -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc 2>/dev/null
  popd > /dev/null
fi

# If asdf is installed, configure it and add it to completions
if [[ -f "${HOME}/.asdf/asdf.sh" ]]; then
  . "${HOME}/.asdf/asdf.sh"
  fpath=("${HOME}/.asdf/completions" $fpath)
fi

# If sheldon is installed, load it
if [[ -d "${HOME}/sheldon" ]]; then
  eval "$(sheldon source)"
fi

# Add /usr/local/bin to the beginning of $PATH
path=(/usr/local/bin $path)

# If homebrew is installed to the new default directory, add it to PATH
if [[ -d "/opt/homebrew/bin" ]]; then
  path=("/opt/homebrew/bin" $path)
fi

if [[ -f "${HOME}/.local.after.zshrc" ]]; then
  source "${HOME}/.local.after.zshrc"
fi

# The ordering of these three plugins is important! They should be loaded last and in this order.
zcomet load hlissner/zsh-autopair

zcomet load zdharma-continuum/fast-syntax-highlighting

zcomet load zsh-users/zsh-autosuggestions

# Add .zsh-completions to the fpath
fpath=("${HOME}/.zsh-completions" $fpath)

# Remove duplicates from path and fpath
typeset -U fpath
typeset -U path

# Initialize completions; this should be the last line of your zsh initialization.
zcomet compinit
