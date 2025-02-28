<div align="left">
    <img alt="GitHub Workflow Status" src="https://github.com/ramonvermeulen/nvim-config/actions/workflows/simple-ci.yml/badge.svg?branch=main">
</div>

Started to use LazyVim, because I have to maintain less config, see my LazyVim config [**here**](https://github.com/ramonvermeulen/lazyvim-config)

# nvim-config
Recently started experimenting with using neovim as my preferred text editor and IDE (not for all languages yet).
This repository contains my personal neovim configuration (e.g. plugins, keymaps, etc.).

Should be cloned into: `~/.config/nvim`

## installation
Run the following:
```bash
git clone https://github.com/ramonvermeulen/nvim-config.git ~/.config/nvim
```

I use Ansible to manage my dotfiles, so I use this repo as git submodule [**here**](https://github.com/ramonvermeulen/dotfiles/tree/main/roles/neovim/files) to install my neovim configuration.
