# soicode.vim

My implementation of the soicode
[vscode plugin](https://marketplace.visualstudio.com/items?itemName=swissolyinfo.soicode)
made for the [Swiss Olympiad in Informatics](https://soi.ch).
inside of vim.

## Features

This plugin only activates if you are in a working directory which contains
the word `soi`.

- You can Create  a `.stoml` file with the `:SOICreateStoml` command.
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
  with the `SOI:RunAllSamples` command.
  The cpp file will be compiled and run with the input
  of all the declared samples from the `.stoml` file.

  After that the output of the program for each sample will be shown in a new tab.

- You can add a template into the current file with the `:ISOInsertTemplate` command.

### Todo

- [x] Create a `.stoml` file with the given in- and outputs.
- [x] Run one sample from the `.stoml` file.
- [x] Run all samples from the `.stoml` file.
- [ ] Run with manual input
- [ ] Debug code
- [x] Insert a template

## Installation

You can easily install the plugin with your favourite package manager.

For vim-plug this would be:

```vim
Plug 'MrSpoony/soicode.vim'
```
