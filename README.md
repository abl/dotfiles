# abl's universal zshrc

Tested on a random variety of operating systems and architectures. Requires a ~recent version of `git` to be installed.

The `.zshrc` file is thoroughly commented withe the intent of each section/line.

## Warnings

 * Requires a recent (> 5.0.3) version of zsh.
 * Requires the latest version of `nano`; `nano -I` can be used to ignore the `.nanorc` that's created by this script as old `nano` versions may crash on startup.

## Installing

Fork this repository! Expect breaking changes at some point. :)

```
GITHUB_USERNAME=abl # replace with your github username
# Make sure you've forked first!
git clone https://github.com/${GITHUB_USERNAME}/dotfiles ~/.dotfiles

# You may want to copy the contents into ~/.local.after.zshrc
mv ~/.zshrc ~/.backup_of_your_zshrc

ln ~/.dotfiles/.zshrc ~/.zshrc
source ~/.zshrc
```

## Configuration

### Where do I add local tweaks?

`~/.local.before.zshrc` will be loaded immediately after zcomet and `~/.local.after.zshrc` will be loaded at the end but before completions are initialized. When in doubt, add lines to `~/.local.after.zshrc`. `~/.local.before.zshrc` is mostly useful if you require a proxy to reach github.com or an alternative method of installing zcomet.

The intent is to allow machine-specific (or company-specific) augmentations while still being able to pull down updates to `.zshrc`

### Notable PATHs

`~/.bin` and `~/.local/bin` will be added to the end of `PATH`; `/usr/local/bin` will be added to the beginning of `PATH`.

## Future Work

This repository will, over time, contain my lunarvim configuration and asdf+sheldon configuration; `.zshrc` will be self-installing but I may mirror and vendor all dependencies over time to reduce dependency on third party repositories.

## Dependencies

All dependencies are auto-installed; this list explains what each dependency does.

### https://github.com/agkozak/zcomet

zcomet is a lightweight ZSH plugin manager that makes it relatively easy to update and precompile ZSH plugins; this helps keep new shell startup time low and keep the `.zshrc` readable.

### https://github.com/zsh-users/zsh-completions

Extra completion definitions for zsh; makes tab completion massively more powerful.

### https://github.com/sindresorhus/pure

The objectively best ZSH prompt.

### https://github.com/agkozak/zsh-z

Sets up the `z` utility; run `z` with some words and it will `cd` to the path that you most frequently/recently used containing those words.

**This is the single most useful improvement I've made to my shell productivity; if you try anything here, try this!**

### https://github.com/abl/zsh-direnv

Trivial fork of https://github.com/ptavares/zsh-direnv with support for `darwin-` platforms.

Installs and configures https://direnv.net.

### https://github.com/junegunn/fzf

Installs and configures `fzf`, "a general-purpose command-line fuzzy finder".

Rebinds `CTRL-T`, `CTRL-R`, and `ALT-C` to more powerful variants.

### https://github.com/wfxr/forgit

Builds on `fzf` and provides powerful, interactive, commands; refer to https://github.com/wfxr/forgit#-features.

### https://github.com/hlissner/zsh-autopair

In the project's own words:

> A simple plugin that auto-closes, deletes and skips over matching delimiters in zsh intelligently. Hopefully.

Certain terminals (especialy VS Code Live Share) have trouble rendering this faithfully.

### https://github.com/zdharma-continuum/fast-syntax-highlighting

Fast and powerful syntax highlighting for commands.

Slow connections / slow computers (e.g. a raspberry pi on a cellular connection) should disable this.

Certain terminals (especialy VS Code Live Share) have trouble rendering this faithfully.

### https://github.com/zsh-users/zsh-autosuggestions

Suggests commands as you type based on history; commands show up in pale text. Press `END` or `right-arrow` to accept the suggestion.
