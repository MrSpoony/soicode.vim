" Title:        soicode.vim
" Description:  A Plugin which tries to remake the functionalities of the vscode soicode plugin -> https://marketplace.visualstudio.com/items?itemName=swissolyinfo.soicode
" Last Change:  11 April 2022
" Maintainer:   MrSpoony <https://github.com/MrSpoony>


" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_soicode")
    finish
endif
let g:loaded_soicode = 1

command! -nargs=1 -complete=customlist,soicode#ListOfSamples
            \ RunOneSample
            \ call soicode#RunSample(<f-args>)
command!
            \ RunAllSamples
            \ call soicode#RunAllSamples()
command!
            \ CreateStoml
            \ call soicode#CreateStoml()
