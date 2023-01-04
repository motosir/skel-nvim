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
basic config
```lua
require("skel-nvim").setup{
  -- file pattern -> template mappings
  mappings = {
    ['*.cpp'] = "cpp.skel",
    ['*.h']   = "h.skel"
  }
}
```
by default, the plugin expects templates to be under XDG\_CONFIG\_HOME/skeleton/, i.e. ~/.config/nvim/skeleton/

<br/><br/>
example config for C/C++ development
```lua
-- import basic default placeholder callbacks
local skeld = require("skel-nvim.defaults")

require("skel-nvim").setup{
  -- dir containing skeleton files (default)
  templates_dir = vim.fn.stdpath("config") .. "/skeleton",

  -- file pattern -> template mappings (default)
  mappings = {
    ['main.cpp'] = "main.cpp.skel",
    ['*.cpp'] = "cpp.skel",
    ['*.h'] = "h.skel",
    ['*.t.cpp'] = "utest.cpp.skel",
    ['main.c'] = "main.c.skel",
    ['*.c'] = "c.skel",
    ["*.go"] = "go.skel",
    ['*.py'] = "py.skel",
    ['*.lua'] = "lua.skel",
    ['*.sh'] = "sh.skel"
  },

  -- substitutions in templates (default)
  -- can be a string or a callback function
  substitutions = {
    ['FILENAME']             = skeld.get_filename,
    ['NAME']                 = skeld.get_author,
    ['DATE']                 = skeld.get_date,
    ['CPP_HDR_GUARD']        = skeld.get_cppheaderguard,
    ['CPP_TEST_HDR_GUARD']   = skeld.get_testheaderguard,
    ['CPP_HDR_INCLUDE']      = skeld.get_headerinclude,
    ['CLASS_NAME']           = skeld.get_classname2,
    ['NAMESPACE_OPEN']       = skeld.get_namespaceopen,
    ['NAMESPACE_CLOSE']      = skeld.get_namespaceclose,
  },

  -- Misc config available to substitution callback functions
  author = "MyName",
  namespace =  {"MyOrg", "MyApp"},
  -- Supports user varaibles too
  my_user_variable = "my_user_value",

  -- per project overrides (default = {})
  projects = {
    project1 = {
      path = "/home/<user>/dev/proj1", -- absolute path for project1
      namespace = {"MyOrg", "Proj1"},  -- override namespace to use in1
      author    = "my project1 name"      -- overide author only in proj1
    },
    project2 = {
      path = "/home/<user>/dev/proj2", -- absolute path for project2
      namespace = {"MyOrg", "Proj2"},   -- override namespace to use in1
      my_user_variable = "I need different value in project2"
    }
  }
}
```
## Usage
### placeholder callbacks functions
placeholder callback functions are called with single table argument
```lua
config = {
  filename  = <absolute path of buffer file>,
  author    = <name provided in 'author' in setup config>,
  namespace = <ns provided in 'namespace' in setukp config>,
  <user defined values>
}

``` 
below example shows how write your own callbacks

```lua
-- calbacks take single `table` argument as described in previous section
local function my_filename_callback(config)
  return vim.fs.basename(config.filename)
end

-- using user defined key/val `my_user_key="my user value"`
local function my_filename_callback(config)
  return strings.uppper(config.my_user_key)
end

require("skel-nvim").setup{
  -- user defined key/value
  my_user_key = "my user value",     -- user defined key/vals are avilable in placeholder callbacks

  mappings = {
    ['main.cpp'] = "main.cpp.skel",
    ['*.cpp'] = "cpp.skel",
    ['*.h'] = "h.skel",
  },
  substitutions = {
    ['FILENAME']             = my_filename_callback,    -- user callback
    ['NAME']                 = "My Name",               -- can use hard-coded string 
    ['MYPLACEHOLDER1']       = my_placeholder1_callback -- in the template @MYPLACEHOLDER1@ will be replaced with "MY USER VALUE"
  }
}

```
### per project
