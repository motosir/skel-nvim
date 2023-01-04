<div align="left">

# skel-nvim
##### nevoim skeleton plugin.
[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.5+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
</div>

## Overview
A skeleton plugin for nvim inspired by [vim-skeleton](https://github.com/noahfrederick/vim-skeleton) written in lua.
* Load boilerplate templates when a new file is created
* Configurable mapping between templates and filename patterns
* Can replace placeholder tokens in templates with either configurable strings or dynamic population using lua functions
* Supports concept of global/per-project config and templates.


## install
Using [plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'nvim-lua/plenary.nvim'
```

Using [packer](https://github.com/wbthomason/packer.nvim):

```lua
use "nvim-lua/plenary.nvim"
```
## config
example config for C++ development
```lua
require(plug)
```
  
# guide
