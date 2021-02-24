# abl's universal zshrc

Tested on a random variety of operating systems and architectures.

## ZSH Plugins

### zinit

Zinit is a speedy package and completion manager for zsh. It does...quite a bit, and others have done a better job optimizing their setups than I have.

The latest version of zinit will be automatically installed on first load. This may cause issues if zinit has made breaking changes.

### zdharma/zplugin

Automatically and transparently compiles sourced scripts for faster startup.

### zsh-users/zsh-completions

Completions for common commands.

### zdharma/history-search-multi-word

Multi-word search through history.

### sindresorhus/pure

The objectively best ZSH prompt.

### agkozak/zsh-z

"Frecency"-based jumping around your most commonly used directories.

### pyenv/pyenv

Python environment management; zsh integrations autoloaded.

### hlissner/zsh-autopair

Auto-closes/skips braces et al. Disable this on slow machines/connections.

### zdharma/fast-syntax-highlighting

Fast shell syntax highlighting. Disable this on slow machines/connections.

### zsh-users/zsh-autosuggestions

Suggests commands as you type. Disable this on slow machines/connections.

## Programs

### BurntSushi/ripgrep

Better than grep, better than ack, better than ag.

### sharkdp/fd

Like find, but better.

### sharkdp/bat

Like cat and less, but more.

Set as the default pager.

### dandavision/delta

Prettier, more usable, diffs for git.

Automatically configured as the global default git diff renderer; may impact other tools!

### ogham/exa

Like ls, but better defaults. Not 100% compatible with ls options.

### direnv/direnv

Directory-specific environment variable management.

### cli/cli

The GitHub CLI.

### zyedidia/micro 

Similar to nano/pico. Notably slower on very weak hardware.

Set as the default editor/visual/etc.

### junegunn/fzf

Fuzzy file finding; great for making friendly filter scripts et al.

### wfxr/forgit

Fzf-powered interactive UI for git.

## Notable Aliases/Settings

```
alias ls=exa
alias cat=bat
alias less=bat
alias more=bat

export EDITOR="micro"
export VISUAL="micro"
```

## Notable Paths

`PATH=${PATH}:"${HOME}/.bin":"${HOME}/.local/bin"`

## Other autoloads

Nix, Deno, Golang, and Fly will all autoload their settings if they are installed in default locations.
