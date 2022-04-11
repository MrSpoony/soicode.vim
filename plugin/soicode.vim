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

let soi = "soi"
let path = tolower(expand('%:p:h'))

if (stridx(path, soi) < 0)
    finish
endif

" Commands
command! -nargs=1 -complete=customlist,soicode#ListOfSamples
            \ RunOneSample
            \ call soicode#RunSample(<f-args>)
command! -nargs=0
            \ RunAllSamples
            \ call soicode#RunAllSamples()
command! -nargs=0
            \ CreateStoml
            \ call soicode#CreateStoml()
command! -nargs=0
            \ InsertSOITemplate
            \ call soicode#InsertTemplate()
