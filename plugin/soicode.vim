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
let fileending = expand('%:e')
let invalidfileending = stridx(fileending, 'cpp') < 0 && stridx(fileending, 'stoml') < 0

if (exists("g:soicode_enable_all_cpp_files") && g:soicode_enable_all_cpp_files)
    if (invalidfileending)
        finish
    endif
else
    if (stridx(path, soi) < 0 || invalidfileending)
        finish
    endif
endif

if (!exists("g:soicode_no_clangdfile") || !g:soicode_no_clangdfile)
    if (exists("g:soicode_make_clangdfile_on_all_cpp_files") && g:soicode_make_clangdfile_on_all_cpp_files)
        if (stridx(path, soi) < 0 || invalidfileending)
            call soicode#MakeClangDFile()
        else
            call soicode#MakeClangDFile(expand("%:p:h"))
        endif
    else
        if (stridx(path, soi) < 0 || invalidfileending)
            finish
        else
            call soicode#MakeClangDFile(expand("%:p:h"))
        endif
    endif
endif

if (exists("g:soicode_auto_insert_template") && g:soicode_auto_insert_template)
    autocmd BufNewFile *.cpp call soicode#InsertTemplate()
endif

if (exists("g:soicode_use_predefined_keybindings") && g:soicode_use_predefined_keybindings)
    call soicode#LoadKeybindings()
endif

" Command
command! -nargs=1 -complete=customlist,soicode#ListOfSamples
            \ SOIRunOneSample
            \ call soicode#RunSample(<f-args>)
command! -nargs=0
            \ SOIRunAllSamples
            \ call soicode#RunAllSamples()
command! -nargs=0
            \ SOIRunWithOwnInput
            \ call soicode#RunWithOwnInput()
command! -nargs=0
            \ SOICreateStoml
            \ call soicode#CreateStoml()
command! -nargs=0
            \ SOIEditStoml
            \ call soicode#EditStoml()
command! -nargs=0
            \ SOIInsertTemplate
            \ call soicode#InsertTemplate()
