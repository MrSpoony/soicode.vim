# soicode.vim

## IMPORTANT NOTE

This is no longer maintained.
I'm porting this plugin to lua for neovim and will no longer do any changes to this repository.

There are some known bugs which won't be fixed by me.

## About the plugin

This is my implementation of the soicode
[vscode plugin](https://marketplace.visualstudio.com/items?itemName=swissolyinfo.soicode)
made for the [Swiss Olympiad in Informatics](https://soi.ch).
inside of vim.

This plugin only activates if you are in a working directory which contains
the word `soi`.

## TL;DR

Install the plugin with the hook `./install.sh`
(look up in your plugin manager documentation how to do it)
and put the following two lines in your `.vimrc`/`init.vim`

```vim
let g:soicode_auto_insert_template = 1
let g:soicode_use_predefined_keybindings = 1
```

Now you can create a stoml file from your clipboard with `<leader>ct`,
insert a template with `<leader>st`,
run all the samples with `<leader>ra` and
run with own input with `<leader>ro`

## Features

- You can Create a `.stoml` file with the `:SOICreateStoml` command.
  It automatically pastes your clipboard to this file,
  so you have to copy the `.stoml` file first.

  The created `.stoml` file has the same name
  as the previous file without the file ending.

- You can run one sample from the `.stoml` file
  with the `:SOIRunOneSample <sample>` command.
  The cpp file will be compiled and run with the input
  from the `<sample>.input` value from the `.stoml` file.

  After that the output of the program will be shown in a new tab.

- You can run all samples from the `.stoml` file
  with the `:SOIRunAllSamples` command.
  The cpp file will be compiled and run with the input
  of all the declared samples from the `.stoml` file.

  After that the output of the program for each sample will be shown in a new tab.

- You can run your code with own input with the `:SOIRunWithOwnInput` command.
  Then the window will split and you can type in your input,
  the output will be printend to this split and the split will disappear
  when you press enter after the program exits.

- You can add a template into the current file with the `:ISOInsertTemplate` command.
  If you set the `g:soicode_auto_insert_template` option to `1` in your config file
  the template will automatically be inserted if you open a new cpp file in a directory
  that contains the word `soi` if you want the soi commands to be available everywhere
  set the `g:soicode_enable_all_cpp_files` option to `1`
- You can set your own template in the
  `~/templates` or the `~/.config/nvim/templates` directory.
  You have to name your template `soi.cpp`,
  if there is a templtate found in one of the directories
  the initial one gets replaced by this.

- If you set the `g:soicode_use_predefined_keybindings` option
  to `1` in your config file some keybindings will be automatically loaded.
  These bindings are:

  ```vim
  nnoremap <leader>rs :SOIRunOneSample
  nnoremap <leader>ra :SOIRunAllSamples<CR>
  nnoremap <leader>ro :SOIRunWithOwnInput<CR>
  nnoremap <leader>st :SOIInsertTemplate<CR>
  nnoremap <leader>ct :SOICreateStoml <CR>
  nnoremap <leader>et :SOIEditStoml <CR>
  ```

- If the option `g:soicode_no_clangdfile` is set to `1`, no `.clangd` file is created
  in your soi path.
  There is also the option to create a `.clangd` file for every `cpp` file.
  If `g:soicode_make_clangdfile_on_all_cpp_files` is set to `1`
  then a `.clangd` file is created for every cpp file you open

### Todo

- [x] Create a `.stoml` file with the given in- and outputs.
- [x] Run one sample from the `.stoml` file.
- [x] Run all samples from the `.stoml` file.
- [x] Run with manual input
- [ ] Debug code
- [x] Insert a template

## Installation

You can easily install the plugin with your favourite package manager.

<details>
  <summary>vim-plug</summary>
  
  ```vim
  Plug 'MrSpoony/soicode.vim' { 'do': './install.sh' }
  ```
</details>
<details>
  <summary>Packer</summary>
  
  ```
  use 'MrSpoony/soicode.vim' { run = './install.sh' }
  ```
</details>
